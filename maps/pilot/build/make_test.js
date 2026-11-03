const fs = require('fs');
const lines = fs.readFileSync('web/app.js', 'utf8').split('\n');
const out = [];
for (let i = 0; i < lines.length; i++) {
  const n = i + 1;
  if (n >= 1470 && n <= 1520) continue;
  if (lines[i].includes('buildReferenceSection()')) continue;
  out.push(lines[i]);
}
fs.writeFileSync('web/app_test.js', out.join('\n'));
console.log('written', out.length, 'lines');