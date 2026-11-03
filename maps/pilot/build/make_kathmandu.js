'use strict';

const fs = require('fs');
const path = require('path');
const {
  PALETTE, DISTRICT_COLORS, LOCAL_COLORS, View, boundsOfFeatures, geomBounds,
  pathForGeometry, Labels, text, line, rect, scaleBar, northArrow,
  graticule, loadJSON, fmt,
} = require('./mapkit');
const { pageHtml } = require('./pagekit');

const HERE = __dirname;
const DATA = path.resolve(HERE, '..', 'data');
const OUT = path.resolve(HERE, '..', 'print', '03_kathmandu.html');

const provinces = loadJSON(path.join(DATA, 'provinces.geojson')).features;
const districts = loadJSON(path.join(DATA, 'districts.geojson')).features;
const locals = loadJSON(path.join(DATA, 'local_levels.geojson')).features;
const summary = loadJSON(path.join(DATA, 'summary.json'));

const DISTRICT_CODE = 306;
const district = districts.find((f) => f.properties.district_code === DISTRICT_CODE);
if (!district) throw new Error('Kathmandu district not found');
const kathmanduLocals = locals
  .filter((f) => f.properties.district_code === DISTRICT_CODE)
  .sort((a, b) => a.properties.area_km2 - b.properties.area_km2);
if (kathmanduLocals.length !== 11) throw new Error('Expected 11 Kathmandu local levels');

const NEIGHBOURS = ['Bhaktapur', 'Lalitpur', 'Makwanpur', 'Dhading', 'Nuwakot', 'Sindhupalchok', 'Kavrepalanchok'];
const neighbourFeatures = districts.filter((f) => NEIGHBOURS.includes(f.properties.district_name));
const VALLEY_NEIGHBOURS = new Set(['Bhaktapur', 'Lalitpur']);
const bagmatiDistricts = districts.filter((f) => f.properties.province_code === 3);

const typeCount = {};
for (const f of kathmanduLocals) {
  typeCount[f.properties.unit_type] = (typeCount[f.properties.unit_type] || 0) + 1;
}

// Colour key: one pastel per local level. The table repeats the swatches, so
// the fills act as a key rather than as a decorative random palette.
const localColor = new Map();
kathmanduLocals.forEach((f, i) => {
  localColor.set(f.properties.code, LOCAL_COLORS[i % LOCAL_COLORS.length]);
});

function localShortNp(f) {
  return String(f.properties.name_np || '')
    .replace(/\s*(उपमहानगरपालिका|महानगरपालिका|नगरपालिका|गाउँपालिका)$/, '')
    .trim();
}

function combinedPath(features, view) {
  return features.map((f) => pathForGeometry(f.geometry, view)).join('');
}

function leaderFor(anchor, block, color = '#6B7280') {
  if (!block || !block.leader) return '';
  const vx = anchor[0] - block.x;
  const vy = anchor[1] - block.y;
  const tx = vx ? (block.r.w / 2) / Math.abs(vx) : Infinity;
  const ty = vy ? (block.r.h / 2) / Math.abs(vy) : Infinity;
  const t = Math.min(tx, ty);
  if (!isFinite(t) || t >= 1) return '';
  const ex = block.x + vx * t;
  const ey = block.y + vy * t;
  const dx = ex - anchor[0];
  const dy = ey - anchor[1];
  const len = Math.hypot(dx, dy);
  if (len < 1.2) return '';
  const ux = dx / len;
  const uy = dy / len;
  return line(
    anchor[0] + ux * 0.8, anchor[1] + uy * 0.8,
    ex - ux * 0.35, ey - uy * 0.35,
    { stroke: color, width: 0.16, opacity: 0.8 }
  );
}

function drawBlock(block, halo = 0.4) {
  let s = '';
  for (const l of block.lines) {
    s += text(l.x, l.y, l.text, {
      size: l.size, font: l.font, weight: l.weight,
      fill: l.font === 'nep' ? '#374151' : '#1F2937',
      haloColor: '#F7F4EC',
      haloWidth: l.font === 'nep' ? halo * 0.8 : halo,
    });
  }
  return s;
}

function starPath(cx, cy, r, points = 5) {
  let d = '';
  for (let i = 0; i < points * 2; i++) {
    const rr = i % 2 === 0 ? r : r * 0.42;
    const a = -Math.PI / 2 + (i * Math.PI) / points;
    const x = cx + Math.cos(a) * rr;
    const y = cy + Math.sin(a) * rr;
    d += (i === 0 ? 'M' : 'L') + fmt(x, 2) + ' ' + fmt(y, 2);
  }
  return d + 'Z';
}

// ---------------------------------------------------------------------------
// Main map
// ---------------------------------------------------------------------------
const W = 268, H = 230;
const db = geomBounds(district.geometry);
const BUFFER = 5.0; // km
const view = new View(W, H, [db[0] - BUFFER, db[1] - BUFFER, db[2] + BUFFER, db[3] + BUFFER], {
  left: 2, right: 2, top: 2, bottom: 2,
});
const labels = new Labels(view, { margin: 1.6 });

// Reserve fixed furniture before any labels are placed.
const cartouche = { x1: 4, y1: 4, x2: 78, y2: 21 };
labels.addRect(cartouche);
labels.addRect({ x1: W - 30, y1: 3, x2: W - 3, y2: 25 }); // north arrow
labels.addRect({ x1: 3, y1: 208, x2: 68, y2: 228 }); // scale bar
labels.addRect({ x1: W - 82, y1: 184, x2: W - 3, y2: 228 }); // legend

const [kx, ky] = view.project(85.3240, 27.7172);
// Keep the capital star and its label clear of each other.
labels.addRect({ x1: kx - 3.1, y1: ky - 3.1, x2: kx + 3.1, y2: ky + 3.1 });

const localBoxes = [];
const forced = [];
for (const f of kathmanduLocals) {
  const p = f.properties;
  const isCapital = p.code === '30608';
  const [x, y] = view.project(p.label_lon, p.label_lat);

  let lines;
  if (isCapital) {
    lines = [
      { text: 'Kathmandu', size: 9.4, font: 'sans', weight: 700, factor: 0.52 },
      { text: 'काठमाडौं', size: 7.4, font: 'nep', weight: 600, factor: 0.60 },
      { text: 'Metropolitan City · capital', size: 4.7, font: 'sans', weight: 500, factor: 0.50 },
    ];
  } else {
    const long = p.name_en_short.length > 13;
    lines = [
      { text: p.name_en_short, size: long ? 6.0 : 7.1, font: 'sans', weight: 650, factor: 0.53 },
      { text: localShortNp(f), size: long ? 5.2 : 5.9, font: 'nep', weight: 500, factor: 0.60 },
    ];
  }

  const offsets = isCapital
    ? [[7, 7], [7, 0], [0, 7], [-7, 7], [7, -5], [0, -7], [-7, 0], [0, 12], [12, 0], [-12, 0]]
    : undefined;

  let block = labels.placeBlock(lines, x, y, { step: isCapital ? 3.2 : 2.6, offsets });
  if (!block) {
    block = labels.placeBlock([
      { text: p.name_en_short, size: isCapital ? 8.4 : 6.6, font: 'sans', weight: 700, factor: 0.52 },
    ], x, y, { step: 2.4 });
  }
  if (!block) {
    block = labels.placeBlock([
      { text: p.code, size: 5.2, font: 'sans', weight: 700, factor: 0.55 },
    ], x, y, { step: 1.8, force: true });
    forced.push(p.code);
  }
  localBoxes.push({ anchor: [x, y], block, local: p, isCapital });
}

// Surrounding district labels. These are deliberately light and small; they
// are orientation aids, not part of the district's own hierarchy.
const neighbourLabels = [
  { name: 'Nuwakot', np: 'नुवाकोट', x: 33, y: 27, anchor: 'start' },
  { name: 'Dhading', np: 'धादिङ', x: 8, y: 92, anchor: 'start' },
  { name: 'Sindhupalchok', np: 'सिन्धुपाल्चोक', x: W - 5, y: 31, anchor: 'end' },
  { name: 'Bhaktapur', np: 'भक्तपुर', x: 190, y: 120, anchor: 'start' },
  { name: 'Kavrepalanchok', np: 'काभ्रेपलाञ्चोक', x: W - 4, y: 155, anchor: 'end' },
  { name: 'Lalitpur', np: 'ललितपुर', x: 112, y: 203, anchor: 'middle' },
  { name: 'Makwanpur', np: 'मकवानपुर', x: 28, y: 203, anchor: 'start' },
];

// ---------------------------------------------------------------------------
// Main SVG
// ---------------------------------------------------------------------------
let svg = '';
svg += `<defs><clipPath id="mapclip"><rect x="0" y="0" width="${W}" height="${H}"/></clipPath></defs>`;
svg += `<g clip-path="url(#mapclip)">`;
svg += `<rect x="0" y="0" width="${W}" height="${H}" fill="#F7F4EC"/>`;
svg += graticule(view, 85.0, 85.7, 27.5, 28.0, { step: 0.1, color: '#D9D4C8', width: 0.12 });

// Neighbouring districts.
for (const f of neighbourFeatures) {
  const p = f.properties;
  const valley = VALLEY_NEIGHBOURS.has(p.district_name);
  svg += `<path d="${pathForGeometry(f.geometry, view)}" fill="${valley ? '#E4EDF5' : '#ECE8DE'}" fill-rule="evenodd" stroke="none"/>`;
}
for (const f of neighbourFeatures) {
  svg += `<path d="${pathForGeometry(f.geometry, view)}" fill="none" fill-rule="evenodd" stroke="#BDB6A8" stroke-width="0.28" stroke-linejoin="round"/>`;
}

// District base, then local levels.
svg += `<path d="${pathForGeometry(district.geometry, view)}" fill="#F1ECDF" fill-rule="evenodd" stroke="none"/>`;
for (const f of kathmanduLocals) {
  svg += `<path d="${pathForGeometry(f.geometry, view)}" fill="${localColor.get(f.properties.code)}" fill-rule="evenodd" stroke="none"/>`;
}
svg += `<path d="${combinedPath(kathmanduLocals, view)}" fill="none" stroke="#FFFFFF" stroke-width="0.42" stroke-linejoin="round" opacity="0.95"/>`;
svg += `<path d="${pathForGeometry(district.geometry, view)}" fill="none" fill-rule="evenodd" stroke="#1F2937" stroke-width="1.0" stroke-linejoin="round"/>`;

// Leaders and labels.
for (const l of localBoxes) {
  svg += leaderFor(l.anchor, l.block, l.isCapital ? '#B91C1C' : '#6B7280');
  svg += drawBlock(l.block, l.isCapital ? 0.52 : 0.38);
}

// Neighbour labels, light and unfilled.
for (const n of neighbourLabels) {
  svg += text(n.x, n.y, n.name, {
    size: 6.6, weight: 600, anchor: n.anchor, fill: '#8A8174',
    haloColor: '#F7F4EC', haloWidth: 0.32,
  });
  svg += text(n.x, n.y + 3.5, n.np, {
    size: 5.6, weight: 500, anchor: n.anchor, fill: '#9A9184', font: 'nep',
    haloColor: '#F7F4EC', haloWidth: 0.28,
  });
}

// Capital star.
svg += `<circle cx="${fmt(kx, 2)}" cy="${fmt(ky, 2)}" r="3.3" fill="#F7F4EC" opacity="0.86"/>`;
svg += `<path d="${starPath(kx, ky, 2.9)}" fill="#B91C1C" stroke="#F7F4EC" stroke-width="0.35" stroke-linejoin="round"/>`;

// Cartouche.
svg += rect(cartouche.x1, cartouche.y1, cartouche.x2 - cartouche.x1, cartouche.y2 - cartouche.y1, {
  fill: '#FBF9F4', stroke: '#D1CABB', width: 0.25, rx: 0.5,
});
svg += text(cartouche.x1 + 3, cartouche.y1 + 5.0, 'KATHMANDU DISTRICT', {
  size: 6.2, weight: 700, anchor: 'start', fill: '#7F1D1D', letterSpacing: 0.12, halo: false,
});
svg += text(cartouche.x1 + 3, cartouche.y1 + 9.2, 'काठमाडौं जिल्ला', {
  size: 6.0, weight: 600, anchor: 'start', fill: '#374151', font: 'nep', halo: false,
});
svg += text(cartouche.x1 + 3, cartouche.y1 + 13.6, '11 local levels · 414 km²', {
  size: 4.6, weight: 500, anchor: 'start', fill: '#6B7280', halo: false,
});

// Scale bar and north arrow. The scale statement sits directly under the bar.
svg += rect(3, 208, 65, 19, { fill: '#FBF9F4', opacity: 1, rx: 0.6 });
svg += scaleBar(view, 6, 211.5, 10, { height: 2.2 });
svg += text(6, 224.4, `Scale approx. 1:${Math.round(view.kmPerMm * 1e6).toLocaleString('en-US')} at A3`, {
  size: 4.4, weight: 500, anchor: 'start', fill: '#6B7280', halo: false,
});
svg += northArrow(W - 14, 14, { size: 6.2 });

// Legend.
const lx = W - 79, ly = 187;
svg += rect(lx, ly, 76, 38, { fill: '#FBF9F4', stroke: '#D8D2C4', width: 0.25, rx: 0.5 });
svg += text(lx + 3, ly + 5.0, 'LEGEND', {
  size: 5.8, weight: 700, anchor: 'start', fill: '#374151', letterSpacing: 0.10, halo: false,
});
svg += text(lx + 3, ly + 8.6, 'संकेत', {
  size: 5.4, weight: 600, anchor: 'start', fill: '#6B7280', font: 'nep', halo: false,
});
const rows = [
  { label: 'Local-level boundary', swatch: 'local' },
  { label: 'District boundary', swatch: 'district' },
  { label: 'Neighbouring district', swatch: 'neighbour' },
  { label: 'Kathmandu Valley district', swatch: 'valley' },
  { label: 'National capital', swatch: 'star' },
];
rows.forEach((r, i) => {
  const y = ly + 13.2 + i * 4.4;
  if (r.swatch === 'local') {
    svg += rect(lx + 3, y - 2.0, 9, 3.2, { fill: '#D7E6D4', stroke: '#C9C2B4', width: 0.15 });
    svg += line(lx + 3.5, y - 0.4, lx + 11.5, y - 0.4, { stroke: '#FFFFFF', width: 0.45 });
  } else if (r.swatch === 'district') {
    svg += line(lx + 3, y - 0.4, lx + 12, y - 0.4, { stroke: '#1F2937', width: 0.8 });
  } else if (r.swatch === 'neighbour') {
    svg += rect(lx + 3, y - 2.0, 9, 3.2, { fill: '#ECE8DE', stroke: '#BDB6A8', width: 0.18 });
  } else if (r.swatch === 'valley') {
    svg += rect(lx + 3, y - 2.0, 9, 3.2, { fill: '#E4EDF5', stroke: '#BDB6A8', width: 0.18 });
  } else {
    svg += `<path d="${starPath(lx + 7.5, y - 0.5, 2.1)}" fill="#B91C1C" stroke="#FBF9F4" stroke-width="0.2"/>`;
  }
  svg += text(lx + 15, y, r.label, {
    size: 5.2, weight: 500, anchor: 'start', fill: '#374151', halo: false,
  });
});

svg += `</g>`;
const svgOut = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" preserveAspectRatio="xMidYMid meet">${svg}</svg>`;

// ---------------------------------------------------------------------------
// Locator maps
// ---------------------------------------------------------------------------
const NEPAL_W = 45, NEPAL_H = 26;
const nepalView = new View(NEPAL_W, NEPAL_H, boundsOfFeatures(provinces), {
  left: 1, right: 1, top: 1, bottom: 1,
});
let nepalSvg = '';
nepalSvg += `<rect x="0" y="0" width="${NEPAL_W}" height="${NEPAL_H}" fill="#F7F4EC"/>`;
for (const p of provinces) {
  const isBag = p.properties.province_code === 3;
  nepalSvg += `<path d="${pathForGeometry(p.geometry, nepalView)}" fill="${isBag ? '#BBD5EC' : '#E8E3D8'}" fill-rule="evenodd" stroke="${isBag ? '#3F4754' : '#B3AC9F'}" stroke-width="${isBag ? 0.4 : 0.18}" stroke-linejoin="round"/>`;
}
const [nkx, nky] = nepalView.project(85.3240, 27.7172);
nepalSvg += `<circle cx="${fmt(nkx, 2)}" cy="${fmt(nky, 2)}" r="0.9" fill="#B91C1C" stroke="#F7F4EC" stroke-width="0.25"/>`;
nepalSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${NEPAL_W} ${NEPAL_H}" preserveAspectRatio="xMidYMid meet">${nepalSvg}</svg>`;

const BAG_W = 45, BAG_H = 28;
const bagView = new View(BAG_W, BAG_H, boundsOfFeatures(bagmatiDistricts), {
  left: 1, right: 1, top: 1, bottom: 1,
});
let bagSvg = '';
bagSvg += `<rect x="0" y="0" width="${BAG_W}" height="${BAG_H}" fill="#F7F4EC"/>`;
for (const d of bagmatiDistricts) {
  const p = d.properties;
  const isFocus = p.district_code === DISTRICT_CODE;
  const valley = VALLEY_NEIGHBOURS.has(p.district_name);
  bagSvg += `<path d="${pathForGeometry(d.geometry, bagView)}" fill="${isFocus ? '#BBD5EC' : valley ? '#E4EDF5' : '#E8E3D8'}" fill-rule="evenodd" stroke="${isFocus ? '#1F2937' : '#B3AC9F'}" stroke-width="${isFocus ? 0.55 : 0.18}" stroke-linejoin="round"/>`;
}
const [bkx, bky] = bagView.project(85.3240, 27.7172);
bagSvg += `<circle cx="${fmt(bkx, 2)}" cy="${fmt(bky, 2)}" r="1.0" fill="#B91C1C" stroke="#F7F4EC" stroke-width="0.25"/>`;
bagSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${BAG_W} ${BAG_H}" preserveAspectRatio="xMidYMid meet">${bagSvg}</svg>`;

// ---------------------------------------------------------------------------
// Side panel data
// ---------------------------------------------------------------------------
const districtArea = district.properties.area_km2;
const avgArea = districtArea / kathmanduLocals.length;

const tableRows = kathmanduLocals
  .slice()
  .sort((a, b) => a.properties.code.localeCompare(b.properties.code))
  .map((f) => {
    const p = f.properties;
    const type = p.unit_type === 'Metropolitan City' ? 'Metro.' : 'Mun.';
    const isCapital = p.code === '30608';
    return `<div class="lrow${isCapital ? ' capital' : ''}">
      <div class="lname"><span class="sw" style="background:${localColor.get(p.code)}"></span><b>${p.name_en_short}</b><span class="np nep">${localShortNp(f)}</span></div>
      <div class="ltype">${type}</div>
      <div class="lcode">${p.code}</div>
      <div class="larea">${p.area_km2.toFixed(1)}</div>
    </div>`;
  }).join('');

const html = pageHtml({
  width: 420, height: 297,
  css: `
  .masthead { left: 18mm; right: 18mm; top: 10mm; height: 30mm; }
  .masthead .title { font-size: 34pt; }
  .masthead .title .np { font-size: 18.5pt; margin-top: 1.6mm; }
  .masthead .subtitle { font-size: 8.4pt; margin-top: 1.8mm; }
  .masthead .eyebrow { font-size: 7.4pt; }
  .masthead .edition { font-size: 6.6pt; }
  .rule { top: 41mm; height: 0.55mm; }
  .mapframe { left: 18mm; top: 47mm; width: 268mm; height: 230mm; }
  .side { left: 294mm; top: 47mm; width: 108mm; height: 230mm; padding: 6mm 6mm 5mm 6mm; }
  .footer { left: 18mm; right: 18mm; bottom: 6mm; font-size: 5.6pt; padding-top: 1.5mm; }
  .side h2 { font-size: 7.0pt; margin-bottom: 0.7mm; }
  .side h2 + .np { font-size: 7.2pt; margin-bottom: 1.8mm; }
  .side .section { margin-top: 3.6mm; }
  .side .divider { margin-top: 3.4mm; }
  .profile-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.8mm; margin-top: 1.0mm; }
  .profile-grid .stat { border-top: 0.25mm solid #D8D2C4; padding-top: 1.0mm; }
  .profile-grid b { display: block; font-size: 14pt; line-height: 1; letter-spacing: -0.02em; }
  .profile-grid span { display: block; font-size: 4.9pt; color: #6B7280; margin-top: 0.6mm; text-transform: uppercase; letter-spacing: 0.05em; }
  .typebox2 { font-size: 5.9pt; line-height: 1.4; color: #374151; margin-top: 1.6mm; }
  .typebox2 b { font-weight: 700; }
  .locator-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 3mm; align-items: stretch; margin-top: 0.8mm; }
  .locator-card { display: flex; flex-direction: column; }
  .locator-grid .cap { font-size: 4.8pt; color: #6B7280; margin-top: auto; padding-top: 1.0mm; text-align: center; }
  .locator-grid svg { display: block; width: 100%; height: auto; border: 0.2mm solid #D8D2C4; background: #F7F4EC; }
  .ltable { width: 100%; border-collapse: collapse; margin-top: 1.0mm; }
  .lhead { display: flex; align-items: baseline; font-size: 4.9pt; text-transform: uppercase; letter-spacing: 0.06em; color: #6B7280; border-bottom: 0.25mm solid #C9C2B4; padding-bottom: 0.7mm; }
  .lhead .lname { flex: 1; }
  .lhead .ltype, .lhead .lcode, .lhead .larea { width: 10mm; text-align: right; }
  .lhead .larea { width: 11mm; }
  .lrow { display: flex; align-items: baseline; padding: 0.74mm 0; border-bottom: 0.16mm solid #E2DCCF; }
  .lrow.capital { background: #EAF2F9; }
  .lrow .lname { flex: 1; min-width: 0; display: flex; align-items: baseline; gap: 1.1mm; }
  .lrow .lname .sw { width: 2.2mm; height: 2.2mm; border: 0.15mm solid rgba(31,41,55,0.2); flex: 0 0 auto; }
  .lrow .lname b { font-size: 6.3pt; font-weight: 650; color: #1F2937; white-space: nowrap; }
  .lrow .lname .np { font-size: 5.5pt; color: #6B7280; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  .lrow .ltype, .lrow .lcode, .lrow .larea { width: 10mm; text-align: right; font-size: 5.6pt; color: #374151; }
  .lrow .ltype { color: #6B7280; font-size: 5.2pt; }
  .lrow .lcode { color: #6B7280; font-size: 5.2pt; }
  .lrow .larea { width: 11mm; color: #374151; }
  .totrow { display: flex; align-items: baseline; padding: 0.8mm 0 0 0; font-size: 5.6pt; color: #374151; }
  .totrow .lname { flex: 1; font-weight: 700; }
  .totrow .ltype, .totrow .lcode { width: 10mm; }
  .totrow .larea { width: 11mm; text-align: right; font-weight: 700; }
  .tnote { font-size: 4.9pt; color: #6B7280; margin-top: 0.8mm; line-height: 1.35; }
  .side .note { font-size: 5.9pt; line-height: 1.45; }
  .badge { font-size: 5.2pt; padding: 1.1mm 1.8mm; margin-top: 1.8mm; }
  .side .tiny { font-size: 5.2pt; }
  `,
  body: {
    title: 'Kathmandu District — Nepal Local Level Atlas Pilot',
    html: `
<div class="page">
  <div class="masthead">
    <div class="topline">
      <div class="eyebrow">Nepal · Local Level Atlas · Pilot · Sheet 3</div>
      <div class="edition">Open-data pilot<br>October 2026</div>
    </div>
    <div class="title">Kathmandu District<span class="np nep">काठमाडौं जिल्ला</span></div>
    <div class="subtitle">11 local levels · Bagmati Province · Kathmandu Valley &nbsp;|&nbsp; Administrative reference map</div>
    <div class="rule"></div>
  </div>

  <div class="mapframe">${svgOut}</div>

  <aside class="side">
    <h2>District profile</h2>
    <div class="np">जिल्ला परिचय</div>
    <div class="profile-grid">
      <div class="stat"><b>11</b><span>local levels</span></div>
      <div class="stat"><b>${Math.round(districtArea)}</b><span>km²</span></div>
      <div class="stat"><b>${typeCount['Metropolitan City'] || 0}</b><span>metropolitan</span></div>
    </div>
    <div class="typebox2">
      <b>${typeCount['Urban Municipality'] || 0}</b> municipalities · all 11 local levels are urban.<br>
      Average local-level area: <b>${avgArea.toFixed(1)} km²</b>. District code <b>306</b>.
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Location</h2>
      <div class="np">अवस्थान</div>
      <div class="locator-grid">
        <div class="locator-card">
          <div>${nepalSvg}</div>
          <div class="cap">Nepal</div>
        </div>
        <div class="locator-card">
          <div>${bagSvg}</div>
          <div class="cap">Bagmati Province · 13 districts</div>
        </div>
      </div>
      <div class="tiny" style="margin-top:1.2mm">Kathmandu district is highlighted in blue; the red dot marks the national capital.</div>
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Local levels</h2>
      <div class="np">स्थानीय तह</div>
      <div class="ltable">
        <div class="lhead"><div class="lname">Local level / स्थानीय तह</div><div class="ltype">Type</div><div class="lcode">Code</div><div class="larea">km²</div></div>
        ${tableRows}
        <div class="totrow"><div class="lname">Total · 11 local levels</div><div class="ltype"></div><div class="lcode"></div><div class="larea">${districtArea.toFixed(1)}</div></div>
      </div>
      <div class="tnote">Metro. = Metropolitan City; Mun. = Municipality. Areas are computed from the open-data geometry and may differ from official statistics.</div>
    </div>

    <div class="source-block">
      <div class="divider"></div>
      <div class="section">
        <h2>Source &amp; accuracy</h2>
        <div class="note">
          Boundaries: Open Knowledge Nepal, <i>LocalBoundaries</i> (CC BY 4.0).
          Codes and names: official 753-unit table. Projection: Albers equal-area, 27°N / 30°N.
        </div>
        <div class="note" style="margin-top:1.6mm">
          <b>Open-data edition.</b> Boundaries are generalised and are not a legal
          boundary determination.
        </div>
        <div class="badge">Pilot · not survey-grade</div>
      </div>
    </div>
  </aside>

  <div class="footer">
    <div>Boundaries: Open Knowledge Nepal, LocalBoundaries (CC BY 4.0) · Codes: official 753-unit table · Projection: Albers equal-area, 27°N/30°N · October 2026</div>
    <div class="right">Open-data edition — not survey-grade · <span class="sheetno">Sheet 3 of 3</span></div>
  </div>
</div>`,
  },
});

fs.writeFileSync(OUT, html);
console.log('wrote', OUT, (fs.statSync(OUT).size / 1024).toFixed(1) + ' KB');
console.log('local labels:', localBoxes.length, 'forced:', forced.join(',') || 'none');
console.log('scale 1:' + Math.round(view.kmPerMm * 1e6));
