#!/usr/bin/env python3
"""Build FABDEM v1.2 terrain tiles (terrarium encoding) for the explorer.

Reads the FABDEM v1.2 COG tiles covering the Nepal band from the public
links-ads/fabdem bucket (plain HTTPS, no auth, GDAL /vsicurl/), resamples
to web-mercator XYZ tiles at z0-z10 (256 px, terrarium PNG) and writes
docs/tiles/fabdem-terrain/{z}/{x}/{y}.png plus meta.json.

Deterministic by construction: integer rounding, fixed iteration order, no
timestamps inside the PNGs, and a pinned lossless re-encode (optipng -o2)
- a rerun over the same source produces byte-identical tiles, so rebuilds
only commit when something upstream actually changed (the
elevation-stats pattern). The one known drift source is an optipng
version bump on the runner image: it re-encodes once, commits once, then
stabilises again.

Diagnostics law: every failure exits through fail(), which carries the
full progress numbers (zoom, tiles, MB, gate values) in the message - so
the workflow's tail dump always shows the verdict, never warning spam.

Gates (fail the build, never the map):
  - Everest anchor: elevation at 86.9250E, 27.9881N must be 7900-8899 m
    (FABDEM is bare-earth circa 2020; the official high point is 8848.86 m).
  - Band sanity: min > 30 m, max < 8899 m over the built tiles.
  - Size budget: < 80 MB total, measured AFTER the lossless optipng pass -
    the repo stays lean and the Pages artifact never sees these files
    (payload-diet law, dart.yml rm).

Run 5 verdict (2026-11-07, the reason this rework exists): the build was
healthy (everest 8710.4 m, band 37.1-8726.0 m) but the payload measured
102.59 MB - 22% over the budget. Fixes, by effect: (1) the bbox is now
Nepal's true extent plus a thin border buffer - the old box paid for
~10% of Ganges-plain and Tibetan pixels that no map view ever renders,
and it dragged the band-min gate margin down to 37 m of Bangladesh
lowlands; (2) every tile is losslessly re-encoded with optipng -o2 - the
GDAL PNG driver does no filter search, and terrarium's B channel is all
zeros, which per-row Up filtering collapses.
"""
import concurrent.futures
import glob
import json
import math
import os
import subprocess
import sys
import traceback
import warnings

import numpy as np
import rasterio
from rasterio.enums import Resampling
from rasterio.errors import NotGeoreferencedWarning
from rasterio.transform import from_bounds
from rasterio.warp import reproject

# PNG tiles are consumed by MapLibre via {z}/{x}/{y} paths - geo-referencing
# is meaningless for them, and the warning would otherwise flood two log
# lines per tile write, burying the real diagnostics in the tail dump.
warnings.filterwarnings("ignore", category=NotGeoreferencedWarning)

# Run 6 verdict (2026-11-07): 96.32 MB post-optipng, still over the
# 80 MB budget - and z11 alone was ~80 MB of it (1372 of 1901 tiles,
# ~68 m/px at Nepal latitudes: not the 30 m native resolution anyway,
# z12 would be ~34 m/px). Capped at z10 (~529 tiles, ~16 MB); MapLibre
# overzooms above the source maxzoom, so higher zooms still render
# from the z10 tiles - the payload law wins over an invisible step.
Z_MIN, Z_MAX = 0, 10
TILE = 256
# Nepal's true extent: 80.058-88.199 E, 26.353-30.423 N (Kalapani west tip,
# Kanchenjunga east side, Kechana Kalan south tip). The build band keeps a
# thin ~0.05-0.1 deg border/hillshade buffer beyond that. The old
# (79.9, 26.1, 88.4, 30.6) box rendered nothing extra for Nepal but paid
# for India, Bangladesh and Tibet in both payload and gate margin.
BBOX = (79.96, 26.30, 88.25, 30.47)  # (W, S, E, N)
BASE = ("https://huggingface.co/buckets/links-ads/fabdem/"
        "resolve/tiles/")
OUT = os.path.join("docs", "tiles", "fabdem-terrain")
META = os.path.join(OUT, "meta.json")
EVEREST = (86.9250, 27.9881)
NODATA = -9999.0
BUDGET = 80 * 1024 * 1024
WORLD = 20037508.342789244

# Progress readout for failure diagnostics (updated inside the build loop).
PROGRESS = {"z": None, "x": None, "y": None, "tiles": 0, "bytes": 0}


def fail(msg):
    print("TERRAIN FAIL: %s" % msg)
    sys.exit(1)


def block_for(la, lo):
    """10-degree block folder that holds the 1-degree tile (la, lo).

    The bucket groups tiles into block folders labelled by their SW
    corner: N26E079 lives in N20E070-N30E080, N30E088 in
    N30E080-N40E090 (verified against the links-ads/fabdem-v12 STAC
    catalog - every STAC item asset href follows exactly this rule).
    """
    return "N%02dE%03d-N%02dE%03d_FABDEM_V1-2" % (
        la // 10 * 10, lo // 10 * 10,
        la // 10 * 10 + 10, lo // 10 * 10 + 10)


def merc(z, x, y):
    """(w, s, e, n) web-mercator bounds of tile z/x/y."""
    res = 2 * WORLD / (2 ** z)
    return (x * res - WORLD, WORLD - (y + 1) * res,
            (x + 1) * res - WORLD, WORLD - y * res)


def lonlat(z, x, y):
    """(w, s, e, n) geographic bounds of tile z/x/y."""
    n = 2 ** z

    def lon(v):
        return v / n * 360.0 - 180.0

    def lat(v):
        r = math.pi * (1 - 2 * v / n)
        return math.degrees(math.atan(math.sinh(r)))

    return (lon(x), lat(y + 1), lon(x + 1), lat(y))


def overlapping(srcs, w, s, e, n):
    return [d for d in srcs
            if not (d.bounds[0] >= e or d.bounds[2] <= w or
                    d.bounds[1] >= n or d.bounds[3] <= s)]


def tile_band(sub, mw, ms, me, mn):
    """Composite the EPSG:4326 sources into one EPSG:3857 256 px band.

    rasterio.merge does not reproject (dst_crs was never a merge kwarg),
    so each source is warped directly into the destination grid with a
    single bilinear resample (rasterio.warp.reproject). Sources partition
    the plane, so a destination pixel has at most one valid contributor;
    first-valid-wins compositing in fixed source order keeps the build
    deterministic and matches merge()'s default 'first' semantics.
    """
    band = np.full((TILE, TILE), NODATA, dtype=np.float32)
    dst_transform = from_bounds(mw, ms, me, mn, TILE, TILE)
    for d in sub:
        tmp = np.full((TILE, TILE), NODATA, dtype=np.float32)
        reproject(
            source=rasterio.band(d, 1),
            destination=tmp,
            src_transform=d.transform,
            src_crs=d.crs,
            dst_transform=dst_transform,
            dst_crs="EPSG:3857",
            src_nodata=NODATA,
            dst_nodata=NODATA,
            resampling=Resampling.bilinear,
        )
        m = (band == NODATA) & (tmp != NODATA)
        band[m] = tmp[m]
    return band


def terrarium(arr):
    """float32 metres -> terrarium uint8 RGB with conservative void fill."""
    a = np.asarray(arr, dtype=np.float64)
    valid = a != NODATA
    a = np.where(valid, a, 0.0)
    for _ in range(64):
        if valid.all():
            break
        neigh = np.full(a.shape, np.inf)
        for dy, dx in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            s = np.roll(np.where(valid, a, np.inf), (dy, dx), axis=(0, 1))
            neigh = np.minimum(neigh, s)
        m = (~valid) & np.isfinite(neigh)
        if not m.any():
            break
        a[m] = neigh[m]
        valid |= m
    v = np.clip(np.rint(a), -32768, 32767).astype(np.int64) + 32768
    r, g, b = (v >> 8) & 0xFF, v & 0xFF, np.zeros(v.shape, dtype=np.int64)
    return np.dstack([r, g, b]).astype(np.uint8), a, valid


def optimize_all():
    """Losslessly re-encode every built tile with optipng -o2 (in place).

    The GDAL PNG driver writes with fixed settings and no filter search;
    optipng tries per-row filter combinations at zlib 9, which on
    terrarium data (one all-zero channel, smooth elevation gradients)
    typically cuts 20-40% of the bytes without touching a single pixel.
    The re-encode is lossless, so no data gate can move - only the size
    budget, which is measured after this pass. Deterministic for a given
    optipng build (the runner's apt pin); a version bump re-encodes once.
    """
    files = sorted(glob.glob(os.path.join(OUT, "**", "*.png"),
                             recursive=True))
    if not files:
        fail("optipng: no PNG tiles found under %s" % OUT)
    workers = max(1, (os.cpu_count() or 2) - 1)

    def one(path):
        return subprocess.run(["optipng", "-o2", "-quiet", path]).returncode

    bad = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=workers) as ex:
        for path, rc in zip(files, ex.map(one, files)):
            if rc != 0:
                bad.append("%s (rc=%d)" % (path, rc))
    if bad:
        fail("optipng: %d tile(s) failed to re-encode, first: %s"
             % (len(bad), bad[0]))
    print("optipng: losslessly re-encoded %d tiles" % len(files))


def measure():
    """Post-optimization (tiles, bytes) over the output tree."""
    tiles, total = 0, 0
    for path in sorted(glob.glob(os.path.join(OUT, "**", "*.png"),
                                 recursive=True)):
        tiles += 1
        total += os.path.getsize(path)
    return tiles, total


def build():
    # Nepal band source tiles: N26..N30 (Nepal reaches 30.42N) x
    # E079..E088 (the bbox spans 79.96E..88.25E). All 50 verified in the
    # links-ads/fabdem-v12 STAC catalog.
    lats = range(26, 31)
    lons = range(79, 89)
    srcs = []
    with rasterio.Env(GDAL_HTTP_MAX_RETRY="10",
                      GDAL_HTTP_RETRY_DELAY="2",
                      VSI_CACHE="TRUE", VSI_CACHE_SIZE="5000000"):
        for la in lats:
            for lo in lons:
                url = "%s%s/N%dE%03d_FABDEM_V1-2.tif" % (BASE, block_for(la, lo), la, lo)
                ds = rasterio.open("/vsicurl/" + url)
                srcs.append(ds)
    print("opened %d FABDEM tiles" % len(srcs))

    os.makedirs(OUT, exist_ok=True)
    tiles = 0
    total = 0
    gmin, gmax = math.inf, -math.inf
    everest_sample = None

    for z in range(Z_MIN, Z_MAX + 1):
        n = 2 ** z
        x0 = max(0, int((BBOX[0] + 180) / 360 * n) - 1)
        x1 = min(n - 1, int((BBOX[2] + 180) / 360 * n) + 1)

        def lat2y(lat):
            r = math.log(math.tan(math.pi / 4 + math.radians(lat) / 2))
            return (1 - r / math.pi) / 2 * n

        y0 = max(0, int(lat2y(BBOX[3])) - 1)
        y1 = min(n - 1, int(lat2y(BBOX[1])) + 1)
        for x in range(x0, x1 + 1):
            os.makedirs(os.path.join(OUT, str(z), str(x)), exist_ok=True)
            for y in range(y0, y1 + 1):
                PROGRESS.update(z=z, x=x, y=y, tiles=tiles, bytes=total)
                w, s, e, nlat = lonlat(z, x, y)
                if e <= BBOX[0] or w >= BBOX[2] or nlat <= BBOX[1] or s >= BBOX[3]:
                    continue
                sub = overlapping(srcs, w, s, e, nlat)
                if not sub:
                    continue
                mw, ms, me, mn = merc(z, x, y)
                band = tile_band(sub, mw, ms, me, mn)
                if z == Z_MAX and w <= EVEREST[0] < e and s <= EVEREST[1] < nlat:
                    px = int((EVEREST[0] - w) / (e - w) * TILE)
                    py = int((nlat - EVEREST[1]) / (nlat - s) * TILE)
                    everest_sample = float(band[py, px])
                rgb, band, valid = terrarium(band)
                if valid.any():
                    gmin = min(gmin, float(band[valid].min()))
                    gmax = max(gmax, float(band[valid].max()))
                path = os.path.join(OUT, str(z), str(x), "%d.png" % y)
                with rasterio.open(path, "w", driver="PNG", width=TILE,
                                   height=TILE, count=3, dtype="uint8") as dst:
                    dst.write(np.transpose(rgb, (2, 0, 1)),
                              indexes=[1, 2, 3])
                tiles += 1
                total += os.path.getsize(path)
                PROGRESS.update(tiles=tiles, bytes=total)
                if tiles % 256 == 0:
                    print("progress: z=%02d tiles=%d %.1f MB"
                          % (z, tiles, total / 1e6))
        print("z%02d done (%d tiles so far, %.1f MB)"
              % (z, tiles, total / 1e6))

    print("built %d tiles, %.1f MB before optimization"
          % (tiles, total / 1e6))
    optimize_all()
    tiles, total = measure()
    print("GATE REPORT: tiles=%d totalMB=%.2f everest=%s gmin=%s gmax=%s"
          % (tiles, total / 1e6,
             "None" if everest_sample is None else "%.1f" % everest_sample,
             "inf" if gmin == math.inf else "%.1f" % gmin,
             "-inf" if gmax == -math.inf else "%.1f" % gmax))

    if everest_sample is None:
        fail("GATE: Everest tile not built - bbox or zoom range is wrong")
    if not (7900 <= everest_sample <= 8899):
        fail("GATE: Everest sample %.1f m outside 7900-8899" % everest_sample)
    if not (30 < gmin < 300):
        fail("GATE: band min %.1f m outside 30-300" % gmin)
    if not (gmax < 8899):
        fail("GATE: band max %.1f m above 8899" % gmax)
    if total > BUDGET:
        fail("GATE: tile payload %.1f MB over the 80 MB budget (%d tiles)"
             % (total / 1e6, tiles))

    meta = {
        "layer": "fabdem-terrain",
        "source": "FABDEM V1-2 (University of Bristol / Fathom)",
        "access": BASE,
        "license": "CC BY-NC-SA 4.0 (non-commercial, share-alike)",
        "attribution": "FABDEM v1.2 - University of Bristol, CC BY-NC-SA 4.0",
        "encoding": "terrarium",
        "zooms": [Z_MIN, Z_MAX],
        "bbox": list(BBOX),
        "tileSize": TILE,
        "tiles": tiles,
        "totalBytes": total,
        "everestSampleM": round(everest_sample, 1),
        "bandMinM": round(gmin, 1),
        "bandMaxM": round(gmax, 1),
        "optimizer": "optipng -o2 (lossless, in-place re-encode)",
        "deterministic": True,
        "generatedBy": "tool/terrain/build_terrain_tiles.py",
    }
    with open(META, "w") as f:
        json.dump(meta, f, indent=2, sort_keys=True)
        f.write("\n")
    print("OK: %d tiles, %.1f MB, everest %.1f m, band %.1f-%.1f m"
          % (tiles, total / 1e6, everest_sample, gmin, gmax))


def main():
    try:
        build()
    except SystemExit:
        raise
    except Exception:
        tb = traceback.format_exc().strip().splitlines()
        fail("exception at z=%s x=%s y=%s after %d tiles / %.1f MB: %s"
             % (PROGRESS["z"], PROGRESS["x"], PROGRESS["y"],
                PROGRESS["tiles"], PROGRESS["bytes"] / 1e6,
                " | ".join(tb[-3:])))


if __name__ == "__main__":
    main()
