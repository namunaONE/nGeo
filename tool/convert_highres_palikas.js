// tool/convert_highres_palikas.js
//
// SUPERSEDED (v2.10.0) — kept for reference. docs/palika-boundaries-highres
// is COD-AB-derived now (see data/SOURCES.md); this sthaniya.gov.np
// converter is the pre-v2.10.0 lineage.
//
// Converts highres-geojson (Acesmndr/nepal-geojson, scraped from sthaniya.gov.np)
// into a cleaned GeoJSON FeatureCollection of 753 palika MultiPolygons.
//
// Dedupes multi-polygon palikas split across separate features (e.g. Mustang has
// 7 features for 'Lo Ghekar Damodarkunda'), normalises names, and attaches
// centroids from the roster (lat/lng) + SHAPE_AREA/SHAPE_LENG.
//
// Output: docs/palika-boundaries-highres.geojson (then simplified/encoded by
// tool/generate_palika_boundaries_highres.dart).
//
// Usage: node tool/convert_highres_palikas.js <highres-dir> <out.geojson>
//
// License: MIT (Acesmndr) — data scraped from sthaniya.gov.np.
// Attribution: Aashish Manandhar / namunaONE / sthaniya.gov.np

const fs = require('fs');
const path = require('path');

function readBuf(p) { return fs.readFileSync(p); }

// Douglas-Peucker simplification
function perpDist(pt, a, b) {
  const dx = b[0] - a[0], dy = b[1] - a[1];
  const len2 = dx * dx + dy * dy;
  if (len2 === 0) return Math.hypot(pt[0] - a[0], pt[1] - a[1]);
  let t = ((pt[0] - a[0]) * dx + (pt[1] - a[1]) * dy) / len2;
  t = Math.max(0, Math.min(1, t));
  const projX = a[0] + t * dx, projY = a[1] + t * dy;
  return Math.hypot(pt[0] - projX, pt[1] - projY);
}
function douglasPeucker(pts, eps) {
  if (pts.length <= 2) return pts.slice();
  let maxD = 0, idx = 0;
  for (let i = 1; i < pts.length - 1; i++) {
    const d = perpDist(pts[i], pts[0], pts[pts.length - 1]);
    if (d > maxD) { maxD = d; idx = i; }
  }
  if (maxD > eps) {
    const left = douglasPeucker(pts.slice(0, idx + 1), eps);
    const right = douglasPeucker(pts.slice(idx), eps);
    return left.slice(0, -1).concat(right);
  }
  return [pts[0], pts[pts.length - 1]];
}

function centroid(ring) {
  let sx = 0, sy = 0, n = 0;
  for (const v of ring) { sx += v[0]; sy += v[1]; n++; }
  if (ring.length > 1 && ring[0][0] === ring[ring.length - 1][0] && ring[0][1] === ring[ring.length - 1][1]) {
    sx -= ring[ring.length - 1][0]; sy -= ring[ring.length - 1][1]; n--;
  }
  return [sx / n, sy / n];
}

// Type suffixes to strip (English + Devanagari)
const EN_SUFFIXES = ['Gaunpalika', 'Nagarpalika', 'Mahanagarpalika', 'Upamahanagarpalika',
  'Gaun Palika', 'Nagar Palika', 'Mahanagar Palika', 'Upamahanagar Palika',
  'Municipality', 'Rural Municipality', 'Sub-Metropolitan City', 'Metropolitan City'];
function stripTypeSuffix(name) {
  let n = name.trim();
  for (const s of EN_SUFFIXES) {
    if (n.endsWith(s)) n = n.slice(0, n.length - s.length).trim();
  }
  return n;
}
function normName(s) { return stripTypeSuffix(s || '').toLowerCase().replace(/[^a-z0-9]/g, '').trim(); }

function main() {
  const dir = process.argv[2];
  const outPath = process.argv[3];
  if (!dir || !outPath) {
    console.error('Usage: node convert_highres_palikas.js <highres-dir> <out.geojson>');
    process.exit(1);
  }

  const files = fs.readdirSync(dir).filter(f => f.endsWith('-District.geojson'));
  const groups = {}; // key: districtNorm|nameNorm -> {district, nameEn, nameNe, polygons, area, perimeter}
  const featureList = [];
  let totalFeatures = 0;

  for (const fn of files) {
    const g = JSON.parse(fs.readFileSync(dir + '/' + fn, 'utf8'));
    for (const f of g.features) {
      const t = f.properties.FIRST_Type || f.properties.FIRST_type || f.properties.Type || '';
      if (!['Gaunpalika', 'Nagarpalika', 'Mahanagarpalika', 'Upamahanagarpalika'].includes(t)) continue;

      totalFeatures++;
      const dist = f.properties.District || f.properties.DISTRICT || f.properties.FIRST_DIST || '';
      const nameEn = stripTypeSuffix(f.properties.FIRST_GaPa || '');
      const nameNe = f.properties.GNP || null;
      const area = f.properties.SHAPE_AREA != null ? parseFloat(f.properties.SHAPE_AREA) : null;
      const perim = f.properties.SHAPE_LENG != null ? parseFloat(f.properties.SHAPE_LENG) : null;

      const key = normDist(dist) + '|' + normName(nameEn);
      if (!groups[key]) {
        groups[key] = {
          district: dist,
          nameEn: nameEn,
          nameNe: nameNe,
          polygons: [],
          area: area,
          perimeter: perim,
        };
      }
      const geom = f.geometry;
      const polys = geom.type === 'Polygon' ? [geom.coordinates] : geom.coordinates;
      for (const poly of polys) groups[key].polygons.push(poly);
    }
  }

  // Emit cleaned features (MultiPolygon per palika)
  for (const key of Object.keys(groups)) {
    const g = groups[key];
    featureList.push({
      type: 'Feature',
      properties: {
        district: g.district,
        nameEn: g.nameEn,
        nameNe: g.nameNe,
        areaSqM: g.area,
        perimeterM: g.perimeter,
        source: 'sthaniya.gov.np via Acesmndr/nepal-geojson (highres-geojson)',
      },
      geometry: {
        type: 'MultiPolygon',
        coordinates: g.polygons.map(p => [p]),
      },
    });
  }

  const fc = { type: 'FeatureCollection', features: featureList };
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(fc));
  console.log('Wrote', featureList.length, 'features to', outPath);
  console.log('Input features:', totalFeatures, '| Output features:', featureList.length);
}

// tolerate missing normDist: use simple lowercase strip
function normDist(s) { return (s || '').toLowerCase().replace(/[^a-z]/g, ''); }

main();
