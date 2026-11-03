const fs = require('fs');
const lines = fs.readFileSync('web/app.js', 'utf8').split('\n');
// Find the stray block: a '}' line followed by '    return String(value || ...)' then ... then '  }' then blank then '  function normalizeSearch'
const stray = ['  }', '    return String(value || \'\' )'.replace(/ /g,''), '      .toLowerCase()', '      .normalize(\'NFKD\')', '      .replace(/[\\u0300-\\u036f]/g, \'\')', '      .replace(/\\s+/g, \' \')', '      .trim();', '  }'];
// Instead, do targeted: find index of first '  function normalizeSearch(value) {' and walk back
let idx = lines.findIndex(l => l.trim() === 'function normalizeSearch(value) {');
console.log('normalizeSearch at', idx + 1);
// The stray block is 7 lines before it (lines idx-7 .. idx-1)
for (let i = idx - 7; i < idx; i++) console.log(i + 1, JSON.stringify(lines[i]));