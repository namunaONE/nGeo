#!/usr/bin/env python3
"""Build FABDEM v1.2 terrain tiles (terrarium encoding) for the explorer.

Reads the FABDEM v1.2 COG tiles covering the Nepal band from the public
links-ads/fabdem bucket (plain HTTPS, no auth, GDAL /vsicurl/), resamples
to web-mercator XYZ tiles at z0-z11 (256 px, terrarium PNG) and writes
docs/tiles/fabdem-terrain/{z}/{x}/{y}.png plus meta.json.

Deterministic by construction: integer rounding, fixed iteration order, no
timestamps inside the PNGs - a rerun over the same source produces
byte-identical tiles, so rebuilds only commit when something upstream
actually changed (the elevation-stats pattern).

Gates (fail the build, never the map):
  - Everest anchor: elevation at 86.9250E, 27.9881N must be 7900-8899 m
    (FABDEM is bare-earth circa 2020; the official high point is 8848.86 m).
  - Band sanity: min > 30 m, max < 8899 m over the built tiles.
  - Size budget: < 80 MB total - the repo stays lean and the Pages
    artifact never sees these files (payload-diet law, dart.yml rm).
"""
import json
import math
import os
import sys

import numpy as np
import rasterio
from rasterio.enums import Resampling
from rasterio.merge import merge as rio_merge

Z_MIN, Z_MAX = 0, 11
TILE = 256
BBOX = (79.9, 26.1, 88.4, 30.6)  # generous Nepal band (W, S, E, N)
BLOCK = "N20E080-N30E090_FABDEM_V1-2"
BASE = ("https://huggingface.co/buckets/links-ads/fabdem/"
        "resolve/tiles/" + BLOCK + "/")
OUT = os.path.join("docs", "tiles", "fabdem-terrain")
META = os.path.join(OUT, "meta.json")
EVEREST = (86.9250, 27.9881)
NODATA = -9999.0
BUDGET = 80 * 1024 * 1024
WORLD = 20037508.342789244


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


def main():
    lats = range(26, 31)
    lons = range(79, 88)
    srcs = []
    with rasterio.Env(GDAL_HTTP_MAX_RETRY="5",
                      GDAL_HTTP_RETRY_DELAY="2",
                      VSI_CACHE="TRUE", VSI_CACHE_SIZE="5000000"):
        for la in lats:
            for lo in lons:
                url = "%sN%dE%03d_FABDEM_V1-2.tif" % (BASE, la, lo)
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
                w, s, e, nlat = lonlat(z, x, y)
                if e <= BBOX[0] or w >= BBOX[2] or nlat <= BBOX[1] or s >= BBOX[3]:
                    continue
                sub = overlapping(srcs, w, s, e, nlat)
                if not sub:
                    continue
                mw, ms, me, mn = merc(z, x, y)
                res = (me - mw) / TILE
                arr, _ = rio_merge(sub, bounds=(mw, ms, me, mn),
                                   dst_crs="EPSG:3857", res=res,
                                   nodata=NODATA,
                                   resampling=Resampling.bilinear)
                band = arr[0]
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
        print("z%02d done (%d tiles so far)" % (z, tiles))

    if everest_sample is None:
        sys.exit("GATE: Everest tile not built - bbox or zoom range is wrong")
    if not (7900 <= everest_sample <= 8899):
        sys.exit("GATE: Everest sample %.1f m outside 7900-8899" % everest_sample)
    if not (30 < gmin < 300):
        sys.exit("GATE: band min %.1f m outside 30-300" % gmin)
    if not (gmax < 8899):
        sys.exit("GATE: band max %.1f m above 8899" % gmax)
    if total > BUDGET:
        sys.exit("GATE: tile payload %.1f MB over the 80 MB budget"
                 % (total / 1e6))

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
        "deterministic": True,
        "generatedBy": "tool/terrain/build_terrain_tiles.py",
    }
    with open(META, "w") as f:
        json.dump(meta, f, indent=2, sort_keys=True)
        f.write("\n")
    print("OK: %d tiles, %.1f MB, everest %.1f m, band %.1f-%.1f m"
          % (tiles, total / 1e6, everest_sample, gmin, gmax))


if __name__ == "__main__":
    main()
