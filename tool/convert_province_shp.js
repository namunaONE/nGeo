// tool/convert_province_shp.js
// Converts the provincial boundary shapefile (province0.shp, already WGS84)
// into a GeoJSON FeatureCollection for comparison/integration.
//
// Usage: node tool/convert_province_shp.js <shp-dir> <out.geojson> [eps]
//   shp-dir: directory containing province0.shp/.dbf/.shx/.prj
//   out:     output GeoJSON path
//   eps:     Douglas-Peucker epsilon in degrees (default 0.0001 ~ 11 m)
//
// Source: National Geoportal (Survey Department of Nepal) high-res provincial
// boundaries, WGS 84 (EPSG:4326). CRS is already WGS84 — no reprojection.
// Nepali names are stored in a legacy font encoding (unusable); only Name_E
// (English) is carried. Cases_Deng is a health overlay and is dropped.
// Douglas-Peucker simplification keeps the payload small while preserving
// province-level fidelity.

const fs = require('fs');
const path = require('path');

function readBuf(p) { return fs.readFileSync(p); }

function parseDbf(buf) {
  const numRecords = buf.readUInt32LE(4);
  const headerLen = buf.readUInt16LE(8);
  const recordLen = buf.readUInt16LE(10);
  let off = 32;
  const fields = [];
  while (off < headerLen - 1 && buf[off] !== 0x0D) {
    fields.push({
      name: buf.toString('ascii', off, off + 11).replace(/\0/g, '').trim(),
      type: String.fromCharCode(buf[off + 11]),
      len: buf[off + 16],
      dec: buf[off + 17],
    });
    off += 32;
  }
  const records = [];
  for (let i = 0; i < numRecords; i++) {
    const base = headerLen + i * recordLen;
    if (buf[base] === 0x2A) { records.push(null); continue; }
    let pos = base + 1;
    const rec = {};
    for (const f of fields) {
      rec[f.name] = buf.toString('utf8', pos, pos + f.len).trim().replace(/\0/g, '');
      pos += f.len;
    }
    records.push(rec);
  }
  return { fields, records, numRecords, headerLen, recordLen };
}

function parseShp(buf) {
  const shapeType = buf.readInt32LE(32);
  const features = [];
  let pos = 100;
  while (pos < buf.length) {
    const recLen = buf.readInt32BE(pos + 4) * 2;
    if (recLen === 0) break;
    let p = pos + 12;
    const xmin = buf.readDoubleLE(p); p += 8;
    const ymin = buf.readDoubleLE(p); p += 8;
    const xmax = buf.readDoubleLE(p); p += 8;
    const ymax = buf.readDoubleLE(p); p += 8;
    const numParts = buf.readInt32LE(p); p += 4;
    const numPoints = buf.readInt32LE(p); p += 4;
    const parts = [];
    for (let i = 0; i < numParts; i++) { parts.push(buf.readInt32LE(p)); p += 4; }
    const ring = [];
    for (let i = 0; i < numPoints; i++) {
      const x = buf.readDoubleLE(p); p += 8;
      const y = buf.readDoubleLE(p); p += 8;
      ring.push([x, y]);
    }
    features.push({ shapeType: buf.readInt32LE(pos + 8), bbox: [xmin, ymin, xmax, ymax], numParts, numPoints, parts, ring });
    pos += 8 + recLen;
  }
  return { shapeType, features };
}

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

function main() {
  const shpDir = process.argv[2];
  const outPath = process.argv[3];
  const eps = parseFloat(process.argv[4] || '0.0001');
  if (!shpDir || !outPath) {
    console.error('Usage: node convert_province_shp.js <shp-dir> <out.geojson> [eps]');
    process.exit(1);
  }
  const dbf = parseDbf(readBuf(shpDir + '/province0.dbf'));
  const shp = parseShp(readBuf(shpDir + '/province0.shp'));

  const features = [];
  let totalOrig = 0, totalSimp = 0;
  for (let i = 0; i < shp.features.length; i++) {
    const rec = dbf.records[i];
    const f = shp.features[i];
    const simpRing = douglasPeucker(f.ring, eps);
    // Ensure closed ring
    const ring = (simpRing[0][0] !== simpRing[simpRing.length - 1][0] || simpRing[0][1] !== simpRing[simpRing.length - 1][1])
      ? simpRing.concat([simpRing[0]]) : simpRing;
    totalOrig += f.ring.length;
    totalSimp += ring.length;
    const c = centroid(ring);
    features.push({
      type: 'Feature',
      properties: {
        nameEn: rec ? rec.Name_E : '',
        provinceCode: rec ? parseInt(rec.FIRST_STAT, 10) : null,
        vertexCount: ring.length,
        originalVertexCount: f.ring.length,
        centroidLng: c[0],
        centroidLat: c[1],
        epsilon: eps,
        source: 'National Geoportal (Survey Department) — high-res provincial boundaries',
      },
      geometry: { type: 'Polygon', coordinates: [ring] },
    });
  }

  const fc = { type: 'FeatureCollection', features };
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(fc));
  console.log('Wrote', features.length, 'features to', outPath);
  console.log('Total vertices: original=' + totalOrig + ' simplified=' + totalSimp + ' (eps=' + eps + ')');
  for (const f of features) {
    console.log('  ', f.properties.nameEn, '| code=' + f.properties.provinceCode, '| verts=' + f.properties.vertexCount + ' (was ' + f.properties.originalVertexCount + ')', '| centroid=' + f.properties.centroidLat.toFixed(4) + ',' + f.properties.centroidLng.toFixed(4));
  }
}

main();
