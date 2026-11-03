// make_reference_web.js — bundle reference_tables_draft.json into web/data/reference.js
// Run: node build/make_reference_web.js
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
const src = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'reference', 'reference_tables_draft.json'), 'utf8'));
const out = 'window.REFERENCE = ' + JSON.stringify(src) + ';\n';
fs.writeFileSync(path.join(ROOT, 'web', 'data', 'reference.js'), out);
console.log('wrote web/data/reference.js with', src.protected_areas.length, '+', src.buffer_zones.length, 'records');