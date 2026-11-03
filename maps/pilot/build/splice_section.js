const fs = require('fs');
const lines = fs.readFileSync('web/app.js', 'utf8').split('\n');
const insert = fs.readFileSync('build/reference_section.txt', 'utf8');
const idx = lines.findIndex(l => l.includes('function renderSidebar()'));
if (idx === -1) { console.error('not found'); process.exit(1); }
lines.splice(idx, 0, insert);
fs.writeFileSync('web/app.js', lines.join('\n'));
console.log('inserted at line', idx + 1);