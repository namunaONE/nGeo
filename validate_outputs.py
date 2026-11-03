# -*- coding: utf-8 -*-
import json, csv, os, re, sys
from collections import Counter

ROOT = os.path.dirname(os.path.abspath(__file__))
GEO = os.path.join(ROOT, 'maps', 'nepal_local_levels_coded.geojson')
CSV = os.path.join(ROOT, 'maps', 'nepal_local_levels_codes.csv')
PDF = os.path.join(ROOT, 'maps', 'Nepal_Local_Level_Atlas.pdf')

errors = []
warnings = []

# ---- GeoJSON ----
gj = json.load(open(GEO, encoding='utf-8'))
feats = gj['features']
codes = [f['properties']['code'] for f in feats]
print('GeoJSON features:', len(feats))
print('unique codes:', len(set(codes)))
print('provinces:', dict(sorted(Counter(f['properties']['province_code'] for f in feats).items())))
print('types:', dict(Counter(f['properties']['unit_type'] for f in feats)))
if len(feats) != 753: errors.append('GeoJSON does not contain 753 features')
if len(set(codes)) != 753: errors.append('GeoJSON codes are not unique')
if any(not f.get('geometry') for f in feats): errors.append('GeoJSON has a feature without geometry')

# ---- CSV ----
with open(CSV, encoding='utf-8-sig') as fh:
    rows = list(csv.DictReader(fh))
print('CSV rows:', len(rows))
if len(rows) != 753: errors.append('CSV does not contain 753 rows')
if {r['code'] for r in rows} != set(codes): errors.append('CSV and GeoJSON code sets differ')

# ---- PDF ----
import pymupdf
doc = pymupdf.open(PDF)
print('PDF pages:', doc.page_count)
print('PDF size MB:', round(os.path.getsize(PDF) / 1e6, 2))
if doc.page_count != 10: errors.append(f'PDF has {doc.page_count} pages, expected 10')

page_sizes = []
for i, page in enumerate(doc):
    page_sizes.append((round(page.rect.width, 1), round(page.rect.height, 1)))
print('page sizes:', sorted(set(page_sizes)))

# every province page must contain all of its 5-digit codes
prov_pages = {'1': 3, '2': 4, '3': 5, '4': 6, '5': 7, '6': 8, '7': 9}
for pcode, pno in prov_pages.items():
    text = doc[pno - 1].get_text()
    wanted = {f['properties']['code'] for f in feats if str(f['properties']['province_code']) == pcode}
    found = set(re.findall(r'(?<!\d)(\d{5})(?!\d)', text))
    missing = wanted - found
    extra = found - wanted
    print(f'page {pno} province {pcode}: wanted {len(wanted)}, found {len(found & wanted)}, missing {len(missing)}, extra {len(extra)}')
    if missing: errors.append(f'page {pno} missing codes: {sorted(missing)}')
    if extra: warnings.append(f'page {pno} has codes not in province: {sorted(extra)}')

# text sanity
alltext = '\n'.join(p.get_text() for p in doc)
for bad in ['Â', 'â€', '\ufffd']:
    if bad in alltext:
        errors.append(f'mojibake sequence found in PDF text: {bad!r}')
print('PDF text characters:', len(alltext))

# PNGs
png_dir = os.path.join(ROOT, 'maps', 'png')
expected_png = ['cover', 'overview'] + [f'province_{p}' for p in '1234567'] + ['about']
for name in expected_png:
    path = os.path.join(png_dir, name + '.png')
    if not os.path.exists(path):
        errors.append(f'missing PNG: {name}.png')
    else:
        from PIL import Image
        with Image.open(path) as im:
            if im.size[0] < 2000:
                warnings.append(f'{name}.png is small: {im.size}')
print('PNG count:', len([n for n in os.listdir(png_dir) if n.endswith('.png')]))

print('\nERRORS:')
for e in errors: print(' -', e)
print('WARNINGS:')
for w in warnings: print(' -', w)
if errors:
    sys.exit(1)
print('\nVALIDATION PASSED')
