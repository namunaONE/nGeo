import json, re, os, math, csv

GEO = '_geo/suraj_municipality.geojson'
XLS = 'xls_dump.json'
OUT = 'maps'
os.makedirs(OUT, exist_ok=True)

# ---------- projection ----------
R = 6371.0
LON0, LAT0, SP1, SP2 = 84.1, 28.4, 27.0, 30.0

def _albers_setup():
    n = (math.sin(math.radians(SP1)) + math.sin(math.radians(SP2))) / 2.0
    C = math.cos(math.radians(SP1))**2 + 2*n*math.sin(math.radians(SP1))
    rho0 = math.sqrt(C - 2*n*math.sin(math.radians(LAT0))) / n
    return n, C, rho0

N_ALB, C_ALB, RHO0 = _albers_setup()

def albers(lon, lat):
    n, C, rho0 = N_ALB, C_ALB, RHO0
    rho = math.sqrt(C - 2*n*math.sin(math.radians(lat))) / n
    theta = n * math.radians(lon - LON0)
    return R * rho * math.sin(theta), R * (rho0 - rho * math.cos(theta))

def albers_inv(x, y):
    n, C, rho0 = N_ALB, C_ALB, RHO0
    xr, yr = x / R, y / R
    rho = math.hypot(xr, rho0 - yr)
    theta = math.atan2(xr, rho0 - yr)
    lat = math.degrees(math.asin((C - (rho*n)**2) / (2*n)))
    lon = LON0 + math.degrees(theta / n)
    return lon, lat

# ---------- geometry helpers ----------
def ring_area_centroid(ring):
    a = cx = cy = 0.0
    for i in range(len(ring)-1):
        x0, y0 = ring[i]; x1, y1 = ring[i+1]
        cross = x0*y1 - x1*y0
        a += cross
        cx += (x0 + x1) * cross
        cy += (y0 + y1) * cross
    a *= 0.5
    if abs(a) < 1e-12:
        return 0.0, (ring[0][0], ring[0][1])
    return a, (cx/(6*a), cy/(6*a))

def point_in_ring(x, y, ring):
    inside = False
    j = len(ring) - 1
    for i in range(len(ring)):
        xi, yi = ring[i]; xj, yj = ring[j]
        if ((yi > y) != (yj > y)) and (x < (xj-xi)*(y-yi)/(yj-yi) + xi):
            inside = not inside
        j = i
    return inside

def interior_point(ring, cx, cy):
    if point_in_ring(cx, cy, ring):
        return cx, cy
    # widest intersection along horizontal scanline through cy
    xs = []
    for i in range(len(ring)-1):
        x0, y0 = ring[i]; x1, y1 = ring[i+1]
        if (y0 > cy) != (y1 > cy):
            xs.append(x0 + (cy-y0)*(x1-x0)/(y1-y0))
    xs.sort()
    best = None
    for i in range(0, len(xs)-1, 2):
        w = xs[i+1]-xs[i]
        if best is None or w > best[0]:
            best = (w, (xs[i]+xs[i+1])/2)
    if best:
        return best[1], cy
    # fallback: average vertices
    return sum(p[0] for p in ring)/len(ring), sum(p[1] for p in ring)/len(ring)

def polygons_of(geom):
    if geom['type'] == 'Polygon':
        return [geom['coordinates']]
    if geom['type'] == 'MultiPolygon':
        return geom['coordinates']
    return []

def label_point(geom):
    best = None
    for poly in polygons_of(geom):
        if not poly: continue
        ring = [(albers(x, y)) for x, y in poly[0]]
        a, (cx, cy) = ring_area_centroid(ring)
        if best is None or abs(a) > abs(best[0]):
            best = (a, ring, cx, cy)
    if not best:
        return None
    a, ring, cx, cy = best
    px, py = interior_point(ring, cx, cy)
    lon, lat = albers_inv(px, py)
    return lon, lat

# ---------- load master ----------
xls = json.load(open(XLS, encoding='utf-8'))
rows = xls['localunit_code'][3:]
master = {}
for r in rows:
    code = str(int(r[4]))
    master[code] = {
        'code': code,
        'district': r[1].strip(),
        'name_en': r[2].strip(),
        'name_np': r[3].strip(),
        'province_code': code[0],
        'district_code': code[:3],
    }

TYPE_RE = re.compile(r'\s+(Rural Municipality|Urban Municipality|Sub-Metropolitian City|Sub-Metropolitan City|Metropolitian City|Metropolitan City)$', re.I)
def short_name(s):
    return TYPE_RE.sub('', s).strip()

def norm_type(s):
    if 'Sub-Metropolitian' in s or 'Sub-Metropolitan' in s: return 'Sub-Metropolitan City'
    if 'Metropolitian City' in s or 'Metropolitan City' in s: return 'Metropolitan City'
    if 'Sub-Metropolitian' in s or 'Sub-Metropolitan' in s: return 'Sub-Metropolitan City'
    if 'Urban Municipality' in s: return 'Urban Municipality'
    if 'Rural Municipality' in s: return 'Rural Municipality'
    return 'Other'

# ---------- load & group boundaries ----------
gj = json.load(open(GEO, encoding='utf-8'))
groups = {}
for f in gj['features']:
    p = f['properties']
    code = p.get('municipality_code')
    if not code:
        continue
    code = str(code)
    groups.setdefault(code, []).append(f)

assert set(groups) == set(master), (len(groups), len(master))
assert len(groups) == 753, len(groups)

PROVINCES = {
    '1': ('Koshi Province', 'koshi'),
    '2': ('Madhesh Province', 'madhesh'),
    '3': ('Bagmati Province', 'bagmati'),
    '4': ('Gandaki Province', 'gandaki'),
    '5': ('Lumbini Province', 'lumbini'),
    '6': ('Karnali Province', 'karnali'),
    '7': ('Sudurpashchim Province', 'sudurpashchim'),
}

features = []
for code in sorted(groups, key=lambda c: (c[0], c[:3], c)):
    fs = groups[code]
    m = master[code]
    polys = []
    for f in fs:
        polys.extend(polygons_of(f['geometry']))
    # merge all polygons for this code
    geom = {'type': 'MultiPolygon', 'coordinates': polys}
    lp = label_point(geom)
    prov_name, slug = PROVINCES[m['province_code']]
    features.append({
        'type': 'Feature',
        'id': code,
        'properties': {
            'code': code,
            'province_code': int(m['province_code']),
            'province_name': prov_name,
            'district_code': int(m['district_code']),
            'district_name': m['district'],
            'local_unit': m['name_en'],
            'local_unit_short': short_name(m['name_en']),
            'local_unit_np': m['name_np'],
            'unit_type': norm_type(m['name_en']),
            'parts': len(polys),
            'label_lon': round(lp[0], 6) if lp else None,
            'label_lat': round(lp[1], 6) if lp else None,
        },
        'geometry': geom,
    })

out = {'type': 'FeatureCollection', 'name': 'Nepal local levels (753 units, official codes)', 'features': features}
with open(f'{OUT}/nepal_local_levels_coded.geojson', 'w', encoding='utf-8') as fh:
    json.dump(out, fh, ensure_ascii=False)
print('wrote geojson', len(features), os.path.getsize(f'{OUT}/nepal_local_levels_coded.geojson'))

# CSV
with open(f'{OUT}/nepal_local_levels_codes.csv', 'w', encoding='utf-8-sig', newline='') as fh:
    w = csv.writer(fh)
    w.writerow(['code','province_code','province_name','district_code','district_name','local_unit','local_unit_short','local_unit_np','unit_type','parts','label_lon','label_lat'])
    for f in features:
        p = f['properties']
        w.writerow([p[k] for k in ['code','province_code','province_name','district_code','district_name','local_unit','local_unit_short','local_unit_np','unit_type','parts','label_lon','label_lat']])
print('wrote csv')

# counts
from collections import Counter
print('provinces', Counter(f['properties']['province_code'] for f in features))
print('types', Counter(f['properties']['unit_type'] for f in features))
print('multi-part', [(f['properties']['code'], f['properties']['local_unit_short'], f['properties']['parts']) for f in features if f['properties']['parts'] > 1])


