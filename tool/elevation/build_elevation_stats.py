#!/usr/bin/env python3
"""Per-district elevation statistics from Copernicus GLO-30 (E1).

Reads the 77 official district polygons (docs/district-boundaries.geojson,
WGS 84), downloads the Copernicus GLO-30 30 m DEM tiles that cover them
from the public AWS bucket (no account; the COGs are EPSG:4326, so the
stats need no reprojection), computes zonal min/mean/max per district and
writes bindings/geojson/districts.elevation.geojson.

Deterministic by construction: features sorted by districtId, integer
metres, fixed key order, no timestamps - rebuilding from the same frozen
2021 tiles is byte-identical, so CI only ever commits a real change.

Hard-fail validation gates (see data/SOURCES.md for the anchor rationale):
  - 77/77 districts with non-null stats (full raster coverage);
  - elevMin <= elevMean <= elevMax for every district;
  - Solukhumbu elevMax >= 8700 m   (Everest 8848.86);
  - Taplejung elevMax >= 8400 m    (Kangchenjunga 8586);
  - Myagdi elevMax >= 7900 m       (Annapurna I 8091);
  - national minimum in [50, 100] m (Kechana Kalan, Jhapa, ~70 m);
  - pixel-weighted national mean in [1800, 2700] m (published ~2112 m;
    GLO-30 is a surface model, so the band has headroom);
  - Mustang elevMin >= 1300 m      (Kali Gandaki gorge: catches a
    grossly wrong tile faster than any checksum would).

Runs inside .github/workflows/elevation-stats.yml. The ~1.5 GB tile
download lives on the Actions runner; the repository only ever sees the
~15 KB statistics artifact.
"""

from __future__ import annotations

import hashlib
import json
import math
import sys
import tempfile
import time
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import urlopen

from rasterio.vrt import build_vrt
from rasterstats import zonal_stats
from shapely.geometry import shape
from shapely.ops import unary_union

BUCKET = "https://copernicus-dem-30m.s3.amazonaws.com"
DISTRICTS_GEOJSON = Path("docs/district-boundaries.geojson")
OUT_PATH = Path("bindings/geojson/districts.elevation.geojson")
EXPECTED_DISTRICTS = 77
COPYRIGHT = chr(169)
ATTRIBUTION = (
    COPYRIGHT + " DLR e.V. 2010-2014 and " + COPYRIGHT + " Airbus Defence "
    "and Space GmbH 2014-2018 provided under COPERNICUS by the European "
    "Union and ESA"
)


def fail(message: str) -> None:
    print("GATE FAILED: " + message, file=sys.stderr)
    raise SystemExit(1)


def load_districts() -> list[dict]:
    if not DISTRICTS_GEOJSON.exists():
        fail("missing input: " + str(DISTRICTS_GEOJSON) + " (see data/SOURCES.md)")
    geo = json.loads(DISTRICTS_GEOJSON.read_text(encoding="utf-8"))
    features = geo.get("features", [])
    if len(features) != EXPECTED_DISTRICTS:
        fail("expected %d districts, found %d" % (EXPECTED_DISTRICTS, len(features)))
    records: list[dict] = []
    seen: set[str] = set()
    for feature in features:
        props = feature["properties"]
        district_id = props["districtId"]
        if district_id in seen:
            fail("duplicate districtId: " + district_id)
        seen.add(district_id)
        records.append({
            "districtId": district_id,
            "nameEn": props["nameEn"],
            "nameNe": props.get("nameNe") or None,
            "geom": shape(feature["geometry"]),
        })
    return records


def covering_tiles(records: list[dict]) -> list[str]:
    """The 1-degree GLO-30 tiles whose cells intersect any district."""
    union = unary_union([r["geom"] for r in records])
    minx, miny, maxx, maxy = union.bounds
    names: list[str] = []
    for lat in range(math.floor(miny), math.floor(maxy) + 1):
        for lng in range(math.floor(minx), math.floor(maxx) + 1):
            if lat < 0 or lng < 0:
                fail("tile grid unexpectedly outside N/E: %d, %d" % (lat, lng))
            cell = shape({
                "type": "Polygon",
                "coordinates": [[
                    [lng, lat], [lng + 1, lat], [lng + 1, lat + 1],
                    [lng, lat + 1], [lng, lat],
                ]],
            })
            if cell.intersects(union):
                names.append(
                    "Copernicus_DSM_COG_10_N%02d_00_E%03d_00_DEM" % (lat, lng))
    return names


def download_tile(name: str, dest: Path, attempts: int = 3) -> None:
    url = BUCKET + "/" + name + "/" + name + ".tif"
    for attempt in range(1, attempts + 1):
        try:
            with urlopen(url, timeout=600) as response:
                dest.write_bytes(response.read())
            return
        except HTTPError as err:
            fail("download failed: " + url + " (HTTP " + str(err.code) + ")")
        except (URLError, OSError) as err:
            if attempt == attempts:
                fail("download failed after %d tries: %s (%s)" % (attempts, url, err))
            print("retry %d/%d: %s (%s)" % (attempt, attempts, url, err),
                  file=sys.stderr)
            time.sleep(5 * attempt)


def zonal(records: list[dict], tiles: list[str]) -> list[dict]:
    with tempfile.TemporaryDirectory(prefix="glo30-") as tmp:
        tmp_dir = Path(tmp)
        paths: list[str] = []
        for name in tiles:
            dest = tmp_dir / (name + ".tif")
            print("downloading " + name + " ...")
            download_tile(name, dest)
            paths.append(str(dest))
        vrt = tmp_dir / "nepal-glo30.vrt"
        build_vrt(str(vrt), paths)
        print("computing zonal stats ...")
        return zonal_stats(
            [r["geom"] for r in records],
            str(vrt),
            stats=["min", "mean", "max", "count"],
            all_touched=False,
        )


def check_anchors(records: list[dict]) -> None:
    by_name = {r["nameEn"]: r for r in records}

    def district(name: str) -> dict:
        record = by_name.get(name)
        if record is None:
            fail("anchor district " + repr(name) + " not in the roster; "
                 "roster: " + ", ".join(sorted(by_name)))
        return record

    def at_least(name: str, field: str, floor_m: int) -> None:
        value = district(name)[field]
        if value < floor_m:
            fail("%s %s = %d m, expected >= %d m" % (name, field, value, floor_m))
        print("anchor %s %s = %d m (gate >= %d)" % (name, field, value, floor_m))

    at_least("Solukhumbu", "elevMax", 8700)
    at_least("Taplejung", "elevMax", 8400)
    at_least("Myagdi", "elevMax", 7900)
    at_least("Mustang", "elevMin", 1300)

    national_min = min(r["elevMin"] for r in records)
    if not 50 <= national_min <= 100:
        fail("national minimum %d m outside the 50-100 m band" % national_min)
    holder = min(records, key=lambda r: r["elevMin"])
    print("anchor national elevMin = %d m (%s; gate 50-100)"
          % (national_min, holder["nameEn"]))

    total = sum(r["pixels"] for r in records)
    weighted = sum(r["meanF"] * r["pixels"] for r in records) / total
    national_mean = int(round(weighted))
    if not 1800 <= national_mean <= 2700:
        fail("national mean %d m outside the 1800-2700 m band" % national_mean)
    print("anchor national elevMean = %d m (gate 1800-2700)" % national_mean)

    top = max(records, key=lambda r: r["elevMax"])
    print("anchor national elevMax = %d m (%s)"
          % (top["elevMax"], top["nameEn"]))


def main() -> None:
    records = load_districts()
    tiles = covering_tiles(records)
    print("covering tiles: %d" % len(tiles))

    stats = zonal(records, tiles)
    for record, stat in zip(records, stats):
        if stat["min"] is None or stat["mean"] is None or stat["max"] is None:
            fail("%s (%s) has no valid pixels - tile coverage is broken"
                 % (record["districtId"], record["nameEn"]))
        record["elevMin"] = int(round(stat["min"]))
        record["elevMean"] = int(round(stat["mean"]))
        record["elevMax"] = int(round(stat["max"]))
        record["meanF"] = float(stat["mean"])
        record["pixels"] = int(stat["count"])
        if not record["elevMin"] <= record["elevMean"] <= record["elevMax"]:
            fail("monotonicity violated for " + record["districtId"])

    check_anchors(records)

    records.sort(key=lambda r: r["districtId"])
    tile_hash = hashlib.sha256(",".join(tiles).encode("utf-8")).hexdigest()
    collection = {
        "type": "FeatureCollection",
        "name": "districts-elevation",
        "metadata": {
            "source": "Copernicus GLO-30 (Copernicus Digital Elevation "
                      "Model, 30 m), frozen 2021 release",
            "bucket": BUCKET,
            "attribution": ATTRIBUTION,
            "license": "Copernicus licence for GLO-30: free use including "
                       "commercial, with attribution",
            "crs": "EPSG:4326 (native; computed without reprojection)",
            "tiles": tiles,
            "tilesSha256": tile_hash,
            "statsConvention": "zonal min/mean/max of GLO-30 pixels inside "
                               "each official district polygon "
                               "(all_touched=False, source nodata masked), "
                               "rounded to integer metres",
            "generatedBy": "tool/elevation/build_elevation_stats.py via "
                           ".github/workflows/elevation-stats.yml",
        },
        "features": [
            {
                "type": "Feature",
                "geometry": None,
                "properties": {
                    "districtId": r["districtId"],
                    "nameEn": r["nameEn"],
                    "nameNe": r["nameNe"],
                    "elevMin": r["elevMin"],
                    "elevMean": r["elevMean"],
                    "elevMax": r["elevMax"],
                },
            }
            for r in records
        ],
    }

    text = json.dumps(collection, indent=2, ensure_ascii=False) + chr(10)
    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)
    OUT_PATH.write_text(text, encoding="utf-8")
    print("wrote %s: %d districts, %d bytes" % (OUT_PATH, len(records), len(text)))


if __name__ == "__main__":
    main()
