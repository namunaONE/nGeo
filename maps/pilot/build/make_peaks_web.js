// make_peaks_web.js — bundle peaks_draft.geojson into web/data/peaks.js
// Run: node build/make_peaks_web.js
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
const src = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'peaks_draft.geojson'), 'utf8'));
const out = 'window.PEAKS = ' + JSON.stringify({ type: 'FeatureCollection', features: src.features }) + ';\n';
fs.writeFileSync(path.join(ROOT, 'web', 'data', 'peaks.js'), out);
console.log('wrote web/data/peaks.js with', src.features.length, 'features');