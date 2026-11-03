const fs = require('fs');
const lines = fs.readFileSync('build/make_peaks.js', 'utf8').split('\n');
// Replace lines 72-89 (1-indexed) = indices 71-88
const newBlock = `// Peaks.
const labels = new Labels(view, { margin: 3 });
const indexed = peaks.map((f, i) => ({ f, n: i + 1 }));
for (const { f, n } of indexed) {
  const p = f.properties;
  const [x, y] = px(f.geometry.coordinates[0], f.geometry.coordinates[1]);
  const isMain = p.peak_class === 'eight_thousander_main';
  const isOfficial = p.peak_class === 'eight_thousander_official_additional';
  const r = isMain ? 2.6 : (isOfficial ? 2.2 : 1.5);
  const fill = isMain ? '#1F2937' : (isOfficial ? '#FFFFFF' : '#4B5563');
  const stroke = isMain ? '#F7F4EC' : '#1F2937';
  mapSvg += '<polygon points="' + fmt(x,2) + ',' + fmt(y-r,2) + ' ' + fmt(x-r,2) + ',' + fmt(y+r,2) + ' ' + fmt(x+r,2) + ',' + fmt(y+r,2) + '" fill="' + fill + '" stroke="' + stroke + '" stroke-width="0.25"/>';
  if (isMain) {
    const primary = p.name_en;
    const np = p.name_np || '';
    const block = labels.placeBlock([
      { text: primary, size: 5.6, weight: 700, factor: 0.54 },
    ].concat(np ? [{ text: np, size: 4.8, weight: 600, factor: 0.52, font: 'nep' }] : []).concat(p.elevation_m ? [{ text: Number(p.elevation_m).toLocaleString() + ' m', size: 4.4, weight: 500, factor: 0.5 }] : []), x + 2.6, y - 1.0, { anchor: 'start', step: 3.0 });
    if (block) {
      for (const ln of block.lines) {
        mapSvg += text(ln.x, ln.y, ln.text, {
          size: ln.size, weight: ln.weight, anchor: 'start',
          fill: ln.font === 'nep' ? '#374151' : (ln.size === 4.4 ? '#6B7280' : '#1F2937'),
          font: ln.font, haloColor: '#FBF9F4', haloWidth: 0.3,
        });
      }
      if (block.leader) {
        const len = Math.hypot(block.x - x, block.y - y);
        if (len > 0.5) {
          mapSvg += line(x + 1.4, y - 0.6, block.x - 0.3, block.y, { stroke: '#9CA3AF', width: 0.15, opacity: 0.7 });
        }
      }
    }
  } else {
    // Numbered key for official additional 8,000 m and 7,000 m peaks.
    mapSvg += text(x + 2.2, y - 1.0, String(n), { size: 4.6, weight: 700, anchor: 'start', fill: '#374151', haloColor: '#FBF9F4', haloWidth: 0.3 });
  }
}`.split('\n');
const startIdx = 71; // 0-based for line 72
const count = 18; // lines 72-89
lines.splice(startIdx, count, ...newBlock);
fs.writeFileSync('build/make_peaks.js', lines.join('\n'));
console.log('done, new length', lines.length);