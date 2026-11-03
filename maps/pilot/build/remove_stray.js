const fs = require('fs');
const lines = fs.readFileSync('web/app.js', 'utf8').split('\n');
// delete lines 1232-1238 (1-indexed) = indices 1231-1237
const start = 1231; // 0-based index for line 1232
const count = 7;
lines.splice(start, count);
fs.writeFileSync('web/app.js', lines.join('\n'));
console.log('removed', count, 'lines; new total', lines.length);