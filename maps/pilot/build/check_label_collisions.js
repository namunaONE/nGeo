// check_label_collisions.js — peak label collision heuristic (D10-deferred edition)
// Projects peaks to Web Mercator pixels at a given zoom and flags pairs closer
// than a threshold. Run: node build/check_label_collisions.js [zoom] [thresholdPx]
const fs = require('fs');
const path = require('path');
const zoom = Number(process.argv[2]) || 8;
const threshold = Number(process.argv[3]) || 40;

const src = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'peaks_draft.geojson'), 'utf8'));
const R = 6378137;
function toPx(lon, lat, z) {
  const scale = 256 * Math.pow(2, z);
  const x = (lon + 180) / 360 * scale;
  const s = Math.sin(lat * Math.PI / 180);
  const y = (0.5 - Math.log((1 + s) / (1 - s)) / (4 * Math.PI)) * scale;
  return { x, y };
}
const pts = src.features.map(f => {
  const [lon, lat] = f.geometry.coordinates;
  const px = toPx(lon, lat, zoom);
  return { id: f.properties.id, name: f.properties.name_en, cls: f.properties.peak_class, ...px };
});
const pairs = [];
for (let i = 0; i < pts.length; i++) {
  for (let j = i + 1; j < pts.length; j++) {
    const dx = pts[i].x - pts[j].x;
    const dy = pts[i].y - pts[j].y;
    const d = Math.hypot(dx, dy);
    if (d < threshold) pairs.push({ a: pts[i].name, b: pts[j].name, d: d.toFixed(1), zoom });
  }
}
pairs.sort((a, b) => a.d - b.d);
console.log('Peak label collision check — zoom', zoom, 'threshold', threshold + 'px');
console.log('Peaks:', pts.length, '| close pairs:', pairs.length);
if (pairs.length) {
  console.log('\nClosest pairs:');
  for (const p of pairs.slice(0, 30)) console.log('  ' + p.d + 'px  ' + p.a + '  ↔  ' + p.b);
  if (pairs.length > 30) console.log('  ... and', pairs.length - 30, 'more');
} else {
  console.log('No pairs closer than threshold. Good at this zoom.');
}
// Report by class
const byClass = {};
for (const p of pts) byClass[p.cls] = (byClass[p.cls] || 0) + 1;
console.log('\nBy class:', JSON.stringify(byClass));