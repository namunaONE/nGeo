// tool/simplify_geojson.cjs — Douglas-Peucker simplification of a GeoJSON
// FeatureCollection. Used to produce a web-friendly mid-resolution variant of
// docs/palika-boundaries-highres.geojson for the explorer's "High detail"
// toggle without shipping the 39 MB full-resolution source.
//
// Usage: node tool/simplify_geojson.cjs <input.geojson> <output.geojson> <eps>
//   eps is in degrees (e.g. 0.001). Default 0.001.
//
// Only polygon rings are simplified; topology is not guaranteed to stay
// watertight, but the source is already per-palika so gaps are pre-existing.
'use strict';
const fs = require('fs');

function perpDist(pt, a, b) {
  const dx = b[0] - a[0], dy = b[1] - a[1];
  const len2 = dx * dx + dy * dy;
  if (len2 === 0) return Math.hypot(pt[0] - a[0], pt[1] - a[1]);
  let t = ((pt[0] - a[0]) * dx + (pt[1] - a[1]) * dy) / len2;
  t = Math.max(0, Math.min(1, t));
  return Math.hypot(pt[0] - (a[0] + t * dx), pt[1] - (a[1] + t * dy));
}
function dp(pts, eps) {
  if (pts.length <= 2) return pts.slice();
  let maxD = 0, idx = 0;
  for (let i = 1; i < pts.length - 1; i++) {
    const d = perpDist(pts[i], pts[0], pts[pts.length - 1]);
    if (d > maxD) { maxD = d; idx = i; }
  }
  if (maxD > eps) {
    const left = dp(pts.slice(0, idx + 1), eps);
    const right = dp(pts.slice(idx), eps);
    return left.slice(0, -1).concat(right);
  }
  return [pts[0], pts[pts.length - 1]];
}
function simplifyRing(ring, eps) {
  if (ring.length <= 4) return ring.slice();
  const out = dp(ring, eps);
  // ensure closed
  if (out.length > 1 && (out[0][0] !== out[out.length - 1][0] || out[0][1] !== out[out.length - 1][1])) {
    out.push([out[0][0], out[0][1]]);
  }
  return out.length >= 4 ? out : ring.slice();
}
function normalizeMultiPolygon(geom) {
  // The vendored high-res GeoJSON is over-wrapped (4 levels). Unwrap one
  // level so we end up with a standard MultiPolygon: [polygon][ring][point].
  const coords = geom.coordinates;
  const polygons = geom.type === 'Polygon' ? [coords] : coords.map(p => p); // ensure array
  // flatten one extra level if present (4-level -> 3-level)
  const flat = [];
  for (const p of polygons) {
    if (Array.isArray(p) && p.length === 1 && Array.isArray(p[0]) && p[0].length === 1 && Array.isArray(p[0][0]) && Array.isArray(p[0][0][0]) && typeof p[0][0][0][0] === 'number') {
      // p = [ [ [pt,...] ] ]  -> unwrap to [ [pt,...] ]
      flat.push([p[0][0]]);
    } else if (Array.isArray(p) && Array.isArray(p[0]) && Array.isArray(p[0][0]) && typeof p[0][0][0] === 'number') {
      // already standard polygon [ring][point]
      flat.push(p);
    } else {
      flat.push(p);
    }
  }
  return { type: 'MultiPolygon', coordinates: flat };
}
function simplifyGeom(geom, eps) {
  const ng = normalizeMultiPolygon(geom);
  const coords = ng.coordinates.map(p => p.map(r => simplifyRing(r, eps)));
  return { type: 'MultiPolygon', coordinates: coords };
}

const [input, output, epsStr] = process.argv.slice(2);
if (!input || !output) { console.error('Usage: node simplify_geojson.cjs <in> <out> <eps>'); process.exit(1); }
const eps = parseFloat(epsStr || '0.001');
const g = JSON.parse(fs.readFileSync(input, 'utf8'));
let before = 0, after = 0;
for (const f of g.features) {
  function count(x) { if (Array.isArray(x) && typeof x[0] === 'number') return 1; let n = 0; for (const y of x) n += count(y); return n; }
  before += count(f.geometry.coordinates);
  f.geometry = simplifyGeom(f.geometry, eps);
  after += count(f.geometry.coordinates);
}
fs.writeFileSync(output, JSON.stringify(g));
const sz = fs.statSync(output).size;
console.log('features:', g.features.length, 'vertices', before, '->', after, 'size:', Math.round(sz / 1024) + 'KB');
