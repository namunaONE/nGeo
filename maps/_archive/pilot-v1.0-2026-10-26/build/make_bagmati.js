'use strict';

const fs = require('fs');
const path = require('path');
const {
  PALETTE, PROV_COLORS, DISTRICT_COLORS, View, boundsOfFeatures, geomBounds,
  pathForGeometry, Labels, text, line, rect, scaleBar, northArrow,
  graticule, loadJSON, fmt,
} = require('./mapkit');
const { pageHtml } = require('./pagekit');

const HERE = __dirname;
const DATA = path.resolve(HERE, '..', 'data');
const OUT = path.resolve(HERE, '..', 'print', '02_bagmati.html');

const provinces = loadJSON(path.join(DATA, 'provinces.geojson')).features;
const districts = loadJSON(path.join(DATA, 'districts.geojson')).features;
const locals = loadJSON(path.join(DATA, 'local_levels.geojson')).features;
const summary = loadJSON(path.join(DATA, 'summary.json'));

const PROVINCE_CODE = 3;
const bagmati = provinces.find((f) => f.properties.province_code === PROVINCE_CODE);
const bagDistricts = districts
  .filter((f) => f.properties.province_code === PROVINCE_CODE)
  .sort((a, b) => a.properties.district_code - b.properties.district_code);
const bagLocals = locals.filter((f) => f.properties.province_code === PROVINCE_CODE);
const summaryProvince = summary.provinces.find((p) => p.code === PROVINCE_CODE);

const VALLEY_DISTRICTS = new Set(['Kathmandu', 'Bhaktapur', 'Lalitpur']);
const valleyLocals = bagLocals.filter((f) => VALLEY_DISTRICTS.has(f.properties.district_name));
const nonValleyLocals = bagLocals.filter((f) => !VALLEY_DISTRICTS.has(f.properties.district_name));

if (bagDistricts.length !== 13) throw new Error('Expected 13 Bagmati districts');
if (bagLocals.length !== 119) throw new Error('Expected 119 Bagmati local levels');
if (valleyLocals.length !== 21) throw new Error('Expected 21 Kathmandu Valley local levels');

const colorByDistrict = new Map();
bagDistricts.forEach((d, i) => {
  colorByDistrict.set(d.properties.district_code, DISTRICT_COLORS[i % DISTRICT_COLORS.length]);
});

function combinedPath(features, view) {
  return features.map((f) => pathForGeometry(f.geometry, view)).join('');
}

function localShortNp(f) {
  return String(f.properties.name_np || '')
    .replace(/\s*(उपमहानगरपालिका|महानगरपालिका|नगरपालिका|गाउँपालिका)$/, '')
    .trim();
}

function leaderFor(anchor, block, color = '#9CA3AF') {
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
    anchor[0] + ux * 0.9, anchor[1] + uy * 0.9,
    ex - ux * 0.35, ey - uy * 0.35,
    { stroke: color, width: 0.15, opacity: 0.8 }
  );
}

function drawBlock(block, halo = 0.38) {
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

function localLines(f, mode) {
  const p = f.properties;
  if (mode === 'bilingual') {
    return [
      { text: p.name_en_short, size: 5.0, font: 'sans', weight: 600, factor: 0.52 },
      { text: localShortNp(f), size: 4.15, font: 'nep', weight: 500, factor: 0.58 },
    ];
  }
  if (mode === 'en') {
    return [{ text: p.name_en_short, size: 5.2, font: 'sans', weight: 600, factor: 0.52 }];
  }
  return [{ text: p.code, size: 4.6, font: 'sans', weight: 700, factor: 0.55 }];
}

// ---------------------------------------------------------------------------
// Main map
// ---------------------------------------------------------------------------
const W = 400, H = 344;
const view = new View(W, H, boundsOfFeatures([bagmati]), {
  left: 8, right: 8, top: 10, bottom: 54,
});
const labels = new Labels(view, { margin: 2.0 });

const vb = boundsOfFeatures(valleyLocals);
const [vbx1, vby1] = view.projectXY(vb[0], vb[3]);
const [vbx2, vby2] = view.projectXY(vb[2], vb[1]);
const valleyBox = {
  x1: vbx1 - 1.4, y1: vby1 - 1.4,
  x2: vbx2 + 1.4, y2: vby2 + 1.4,
};
labels.addRect(valleyBox);

// Valley callout, placed before district and local labels.
const calloutAnchor = [valleyBox.x2 + 1.5, valleyBox.y1 + 2.5];
const valleyCallout = labels.placeBlock([
  { text: 'Kathmandu Valley', size: 5.3, font: 'sans', weight: 700, factor: 0.54 },
  { text: 'काठमाडौं उपत्यका', size: 4.5, font: 'nep', weight: 600, factor: 0.58 },
  { text: 'see inset', size: 4.2, font: 'sans', weight: 500, factor: 0.52 },
], calloutAnchor[0] + 18, calloutAnchor[1] - 1.2, { anchor: 'start', step: 2.0 });
if (!valleyCallout) {
  labels.placeBlock([
    { text: 'Kathmandu Valley', size: 5.0, font: 'sans', weight: 700, factor: 0.54 },
    { text: 'see inset', size: 4.0, font: 'sans', weight: 500, factor: 0.52 },
  ], calloutAnchor[0] + 16, calloutAnchor[1] - 1.2, { anchor: 'start', force: true });
}

// District labels: the three valley districts are represented by the inset.
const districtLabelBoxes = [];
for (const d of bagDistricts) {
  const p = d.properties;
  if (VALLEY_DISTRICTS.has(p.district_name)) continue;
  const [x, y] = view.project(p.label_lon, p.label_lat);
  let block = labels.placeBlock([
    { text: p.district_name, size: 8.7, font: 'sans', weight: 700, factor: 0.52 },
    { text: p.district_name_np, size: 6.8, font: 'nep', weight: 600, factor: 0.58 },
  ], x, y, { step: 3.2 });
  if (!block) {
    block = labels.placeBlock([
      { text: p.district_name, size: 8.2, font: 'sans', weight: 700, factor: 0.52 },
    ], x, y, { step: 3.0, force: true });
    console.log('forced district label', p.district_name);
  }
  districtLabelBoxes.push({ anchor: [x, y], block, district: p });
}

// Local labels: smallest districts first, so the most constrained labels are
// placed while the map is still open.
const areaByDistrict = new Map(bagDistricts.map((d) => [d.properties.district_code, d.properties.area_km2]));
const labelLocals = nonValleyLocals.slice().sort((a, b) => {
  const aa = areaByDistrict.get(a.properties.district_code) || 0;
  const bb = areaByDistrict.get(b.properties.district_code) || 0;
  if (aa !== bb) return aa - bb;
  return a.properties.name_en_short.localeCompare(b.properties.name_en_short);
});

const localLabelBoxes = [];
const unplacedLocals = [];
for (const f of labelLocals) {
  const p = f.properties;
  const [x, y] = view.project(p.label_lon, p.label_lat);
  let block = labels.placeBlock(localLines(f, 'bilingual'), x, y, { step: 2.05 });
  if (!block) block = labels.placeBlock(localLines(f, 'en'), x, y, { step: 2.0 });
  if (!block) block = labels.placeBlock(localLines(f, 'code'), x, y, { step: 1.7 });
  if (!block) {
    block = labels.placeBlock(localLines(f, 'code'), x, y, { step: 1.7, force: true });
    unplacedLocals.push(p.code);
  }
  localLabelBoxes.push({ anchor: [x, y], block, local: p, mode: block.lines.length });
}

// ---------------------------------------------------------------------------
// Main SVG
// ---------------------------------------------------------------------------
let svg = '';
svg += `<defs><clipPath id="mapclip"><rect x="0" y="0" width="${W}" height="${H}"/></clipPath></defs>`;
svg += `<g clip-path="url(#mapclip)">`;
svg += `<rect x="0" y="0" width="${W}" height="${H}" fill="#F7F4EC"/>`;
svg += graticule(view, 83, 87, 27, 29, { step: 0.5, color: '#D9D4C8', width: 0.13 });

for (const d of bagDistricts) {
  const p = d.properties;
  svg += `<path d="${pathForGeometry(d.geometry, view)}" fill="${colorByDistrict.get(p.district_code)}" fill-rule="evenodd" stroke="none"/>`;
}
svg += `<path d="${combinedPath(bagLocals, view)}" fill="none" stroke="#FFFFFF" stroke-width="0.24" stroke-linejoin="round" opacity="0.88"/>`;
for (const d of bagDistricts) {
  svg += `<path d="${pathForGeometry(d.geometry, view)}" fill="none" fill-rule="evenodd" stroke="#5B6472" stroke-width="0.55" stroke-linejoin="round"/>`;
}
svg += `<path d="${pathForGeometry(bagmati.geometry, view)}" fill="none" fill-rule="evenodd" stroke="#1F2937" stroke-width="1.0" stroke-linejoin="round"/>`;

// Valley frame and inset callout.
svg += rect(valleyBox.x1, valleyBox.y1, valleyBox.x2 - valleyBox.x1, valleyBox.y2 - valleyBox.y1, {
  fill: 'none', stroke: '#B91C1C', width: 0.75, rx: 0.6,
});
svg += rect(valleyBox.x1 + 0.5, valleyBox.y1 + 0.5, valleyBox.x2 - valleyBox.x1 - 1, valleyBox.y2 - valleyBox.y1 - 1, {
  fill: 'none', stroke: '#F7F4EC', width: 0.35, rx: 0.5,
});

for (const d of districtLabelBoxes) {
  svg += leaderFor(d.anchor, d.block);
  svg += drawBlock(d.block, 0.42);
}
for (const l of localLabelBoxes) {
  svg += leaderFor(l.anchor, l.block);
  svg += drawBlock(l.block, 0.32);
}
if (valleyCallout) {
  svg += leaderFor(calloutAnchor, valleyCallout, '#B91C1C');
  svg += drawBlock(valleyCallout, 0.35);
}

// ---------------------------------------------------------------------------
// Locator: Bagmati in Nepal
// ---------------------------------------------------------------------------
const locW = 86, locH = 40;
const locView = new View(locW, locH, boundsOfFeatures(provinces), { left: 1.2, right: 1.2, top: 1.2, bottom: 1.2 });
const locX = 9, locY = H - 50;
svg += `<g transform="translate(${fmt(locX, 2)},${fmt(locY, 2)})">`;
svg += rect(0, 0, locW, locH, { fill: '#F7F4EC', stroke: '#D8D2C4', width: 0.25 });
for (const p of provinces) {
  const isBag = p.properties.province_code === PROVINCE_CODE;
  svg += `<path d="${pathForGeometry(p.geometry, locView)}" fill="${isBag ? '#BBD5EC' : '#E8E3D8'}" fill-rule="evenodd" stroke="${isBag ? '#3F4754' : '#B3AC9F'}" stroke-width="${isBag ? 0.45 : 0.2}" stroke-linejoin="round"/>`;
}
const [lkx, lky] = locView.project(85.3240, 27.7172);
svg += `<circle cx="${fmt(lkx, 2)}" cy="${fmt(lky, 2)}" r="1.0" fill="#B91C1C" stroke="#F7F4EC" stroke-width="0.3"/>`;
svg += `</g>`;
svg += text(locX + 1.5, locY + locH + 4.2, 'Bagmati in Nepal', {
  size: 5.4, weight: 700, anchor: 'start', fill: '#374151', halo: false,
});
svg += text(locX + 1.5, locY + locH + 7.4, 'नेपालमा बागमती', {
  size: 4.9, weight: 600, anchor: 'start', fill: '#6B7280', font: 'nep', halo: false,
});

// Scale bar and north arrow.
svg += scaleBar(view, 112, H - 19, 50, { height: 2.2 });
svg += northArrow(W - 20, 20, { size: 6.2 });
svg += `</g>`;
const svgOut = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" preserveAspectRatio="xMidYMid meet">${svg}</svg>`;

// ---------------------------------------------------------------------------
// Kathmandu Valley inset
// ---------------------------------------------------------------------------
const IW = 132, IH = 100;
const insetView = new View(IW, IH, boundsOfFeatures(valleyLocals), {
  left: 3, right: 3, top: 5, bottom: 10,
});
const insetLabels = new Labels(insetView, { margin: 1.2 });
const valleyDistrictList = bagDistricts.filter((d) => VALLEY_DISTRICTS.has(d.properties.district_name));

for (const d of valleyDistrictList) {
  const p = d.properties;
  const [x, y] = insetView.project(p.label_lon, p.label_lat);
  const block = insetLabels.placeBlock([
    { text: p.district_name, size: 6.2, font: 'sans', weight: 700, factor: 0.52 },
    { text: p.district_name_np, size: 5.3, font: 'nep', weight: 600, factor: 0.58 },
  ], x, y, { step: 2.6, force: true });
  block.anchor = [x, y];
  block.district = p;
}

// Numbered key: Kathmandu 1–11, Bhaktapur 12–15, Lalitpur 16–21.
const valleyOrder = ['Kathmandu', 'Bhaktapur', 'Lalitpur'];
const numberedValley = [];
for (const name of valleyOrder) {
  const list = valleyLocals
    .filter((f) => f.properties.district_name === name)
    .sort((a, b) => a.properties.name_en_short.localeCompare(b.properties.name_en_short));
  for (const f of list) numberedValley.push({ n: numberedValley.length + 1, f });
}

const numberLabels = new Labels(insetView, { margin: 0.9 });
for (const item of insetLabels.items) numberLabels.addRect(item.r);

const numOffsets = [
  [0, 0], [0, -2.4], [0, 2.4], [2.4, 0], [-2.4, 0],
  [2.4, -2.4], [-2.4, -2.4], [2.4, 2.4], [-2.4, 2.4],
  [0, -4.8], [0, 4.8], [4.8, 0], [-4.8, 0],
  [3.4, -3.4], [-3.4, -3.4], [3.4, 3.4], [-3.4, 3.4],
];
const placedNumbers = [];
for (const { n, f } of numberedValley) {
  const p = f.properties;
  const [x, y] = insetView.project(p.label_lon, p.label_lat);
  const r = 1.85;
  let pos = null;
  for (const [dx, dy] of numOffsets) {
    const box = { x1: x + dx - r, x2: x + dx + r, y1: y + dy - r, y2: y + dy + r };
    if (!numberLabels.inFrame(box) || numberLabels.collides(box)) continue;
    numberLabels.addRect(box);
    pos = { x: x + dx, y: y + dy, leader: Math.hypot(dx, dy) > 2.3 };
    break;
  }
  if (!pos) {
    const box = { x1: x - r, x2: x + r, y1: y - r, y2: y + r };
    numberLabels.addRect(box);
    pos = { x, y, leader: false };
  }
  placedNumbers.push({ n, f, anchor: [x, y], pos });
}

let inset = '';
inset += `<defs><clipPath id="insetclip"><rect x="0" y="0" width="${IW}" height="${IH}"/></clipPath></defs>`;
inset += `<g clip-path="url(#insetclip)">`;
inset += `<rect x="0" y="0" width="${IW}" height="${IH}" fill="#F7F4EC"/>`;
for (const d of valleyDistrictList) {
  const p = d.properties;
  inset += `<path d="${pathForGeometry(d.geometry, insetView)}" fill="${colorByDistrict.get(p.district_code)}" fill-rule="evenodd" stroke="none"/>`;
}
inset += `<path d="${combinedPath(valleyLocals, insetView)}" fill="none" stroke="#FFFFFF" stroke-width="0.38" stroke-linejoin="round" opacity="0.9"/>`;
for (const d of valleyDistrictList) {
  inset += `<path d="${pathForGeometry(d.geometry, insetView)}" fill="none" fill-rule="evenodd" stroke="#4B5563" stroke-width="0.6" stroke-linejoin="round"/>`;
}
inset += `<path d="${pathForGeometry({ type: 'MultiPolygon', coordinates: valleyDistrictList.flatMap((d) => d.geometry.type === 'Polygon' ? [d.geometry.coordinates] : d.geometry.coordinates) }, insetView)}" fill="none" fill-rule="evenodd" stroke="#1F2937" stroke-width="1.0" stroke-linejoin="round"/>`;

for (const d of valleyDistrictList) {
  const placed = insetLabels.items.find((x) => x.district && x.district.district_code === d.properties.district_code);
  if (placed) {
    inset += leaderFor(placed.anchor, placed);
    inset += drawBlock(placed, 0.38);
  }
}
for (const p of placedNumbers) {
  if (p.pos.leader) {
    const dx = p.pos.x - p.anchor[0];
    const dy = p.pos.y - p.anchor[1];
    const len = Math.hypot(dx, dy);
    if (len > 3.0) {
      inset += line(
        p.anchor[0] + dx / len * 0.5, p.anchor[1] + dy / len * 0.5,
        p.pos.x - dx / len * 2.1, p.pos.y - dy / len * 2.1,
        { stroke: '#6B7280', width: 0.14, opacity: 0.8 }
      );
    }
  }
  inset += `<circle cx="${fmt(p.pos.x, 2)}" cy="${fmt(p.pos.y, 2)}" r="1.85" fill="#FFFFFF" stroke="#1F2937" stroke-width="0.34"/>`;
  inset += text(p.pos.x, p.pos.y + 0.62, String(p.n), {
    size: 5.0, weight: 700, anchor: 'middle', halo: false, fill: '#1F2937',
  });
}
inset += scaleBar(insetView, 3, IH - 5.5, 5, { height: 1.8 });
inset += northArrow(IW - 8, 8, { size: 3.8 });
inset += `</g>`;
inset += rect(0.2, 0.2, IW - 0.4, IH - 0.4, { fill: 'none', stroke: '#C9C2B4', width: 0.35 });
const insetSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${IW} ${IH}" preserveAspectRatio="xMidYMid meet">${inset}</svg>`;

const keyHalf = Math.ceil(numberedValley.length / 2);
const keyColumns = [numberedValley.slice(0, keyHalf), numberedValley.slice(keyHalf)];
const valleyKeyHtml = `<div class="valley-key">${keyColumns.map((col) => `<div class="vcol">${col.map(({ n, f }) => `<div class="vitem"><span class="vn">${n}</span><span class="ve">${f.properties.name_en_short}</span><span class="vnp nep">${localShortNp(f)}</span></div>`).join('')}</div>`).join('')}</div>`;

// ---------------------------------------------------------------------------
// Side panel data
// ---------------------------------------------------------------------------
const typeCounts = {};
for (const f of bagLocals) {
  const t = f.properties.unit_type;
  typeCounts[t] = (typeCounts[t] || 0) + 1;
}

const districtRows = bagDistricts
  .slice()
  .sort((a, b) => a.properties.district_name.localeCompare(b.properties.district_name))
  .map((d) => {
    const p = d.properties;
    const isValley = VALLEY_DISTRICTS.has(p.district_name);
    return `<div class="drow2${isValley ? ' valley' : ''}">
      <div class="dname"><b>${isValley ? '<span class="vd"></span>' : ''}${p.district_name}</b><span class="np nep">${p.district_name_np}</span></div>
      <div class="dnum">${p.local_count}</div>
      <div class="darea">${Math.round(p.area_km2).toLocaleString('en-US')}</div>
    </div>`;
  }).join('');

const html = pageHtml({
  width: 594, height: 420,
  css: `
  .masthead { left: 18mm; right: 18mm; top: 12mm; height: 44mm; }
  .masthead .title { font-size: 35pt; }
  .masthead .title .np { font-size: 19pt; margin-top: 2.2mm; }
  .masthead .subtitle { font-size: 9pt; margin-top: 2.4mm; }
  .masthead .eyebrow { font-size: 7.6pt; }
  .masthead .edition { font-size: 6.8pt; }
  .rule { top: 46mm; height: 0.55mm; }
  .mapframe { left: 18mm; top: 58mm; width: 400mm; height: 344mm; }
  .side { left: 428mm; top: 58mm; width: 148mm; height: 344mm; padding: 6mm 6mm 5mm 6mm; }
  .footer { left: 18mm; right: 18mm; bottom: 7mm; font-size: 5.8pt; padding-top: 1.6mm; }
  .side h2 { font-size: 7.4pt; margin-bottom: 0.8mm; }
  .side h2 + .np { font-size: 7.8pt; margin-bottom: 2.4mm; }
  .side .section { margin-top: 3.8mm; }
  .side .divider { margin-top: 3.2mm; }
  .profile-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 2mm; margin-top: 1.4mm; }
  .profile-grid .stat { border-top: 0.25mm solid #D8D2C4; padding-top: 1.2mm; }
  .profile-grid b { display: block; font-size: 13pt; line-height: 1; letter-spacing: -0.02em; }
  .profile-grid span { display: block; font-size: 5.2pt; color: #6B7280; margin-top: 0.7mm; text-transform: uppercase; letter-spacing: 0.05em; }
  .typebox2 { font-size: 6.3pt; line-height: 1.45; color: #374151; margin-top: 2mm; }
  .typebox2 b { font-weight: 700; }
  .inset-wrap { margin-top: 0.6mm; border: 0.25mm solid #D8D2C4; background: #F7F4EC; }
  .inset-wrap svg { display: block; width: 100%; height: auto; }
  .inset-note { font-size: 5.3pt; line-height: 1.35; color: #6B7280; margin-top: 1mm; }
  .valley-key { display: grid; grid-template-columns: 1fr 1fr; gap: 0 3mm; margin-top: 1.3mm; }
  .vcol { min-width: 0; }
  .vitem { display: flex; align-items: baseline; gap: 1.1mm; font-size: 5.2pt; line-height: 1.38; }
  .vn { width: 3.2mm; flex: 0 0 auto; text-align: right; color: #B91C1C; font-weight: 700; font-size: 5.0pt; }
  .ve { color: #1F2937; white-space: nowrap; }
  .vnp { color: #6B7280; font-size: 5.0pt; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  .dtable { width: 100%; border-collapse: collapse; margin-top: 1mm; }
  .dtable .thead { display: flex; align-items: baseline; font-size: 5.1pt; text-transform: uppercase; letter-spacing: 0.07em; color: #6B7280; border-bottom: 0.25mm solid #C9C2B4; padding-bottom: 0.8mm; }
  .dtable .thead .dname { flex: 1; }
  .dtable .thead .dnum, .dtable .thead .darea { width: 10mm; text-align: right; }
  .drow2 { display: flex; align-items: baseline; padding: 0.78mm 0; border-bottom: 0.18mm solid #E2DCCF; }
  .drow2 .dname { flex: 1; min-width: 0; }
  .drow2 .dname b { display: block; font-size: 6.8pt; font-weight: 600; color: #1F2937; white-space: nowrap; }
  .drow2 .dname .np { display: block; font-size: 6.1pt; color: #6B7280; margin-top: -0.2mm; }
  .drow2 .dnum, .drow2 .darea { width: 10mm; text-align: right; font-size: 6.4pt; color: #374151; }
  .drow2 .darea { color: #6B7280; font-size: 6.0pt; }
  .drow2.valley { background: #EAF2F9; }
  .vd { display: inline-block; width: 1.5mm; height: 1.5mm; background: #B91C1C; border-radius: 50%; margin-right: 1mm; vertical-align: middle; }
  .side .note { font-size: 6.3pt; line-height: 1.45; }
  .map-legend {
    position: absolute; right: 6mm; bottom: 7mm; width: 92mm;
    padding: 3mm 3.5mm; background: rgba(251,249,244,0.95);
    border: 0.25mm solid #D8D2C4;
  }
  .ml-title { font-size: 6.2pt; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase; color: #374151; margin-bottom: 1.4mm; }
  .ml-title .nep { text-transform: none; letter-spacing: 0; font-weight: 600; color: #6B7280; margin-left: 1.5mm; }
  .ml-row { display: flex; align-items: center; gap: 2.2mm; font-size: 6.0pt; color: #374151; margin: 1.1mm 0; }
  .ml-line { width: 9mm; height: 0; border-top: 0.5mm solid #1F2937; flex: 0 0 auto; }
  .ml-line.district { border-top: 0.3mm solid #6B7280; }
  .ml-line.local { border-top: 0.18mm solid #9CA3AF; }
  .ml-line.valley { border-top: 0.6mm dashed #B91C1C; }
  .ml-star { width: 9mm; text-align: center; color: #B91C1C; font-size: 9pt; flex: 0 0 auto; }
  .badge { font-size: 5.4pt; padding: 1.2mm 1.9mm; margin-top: 2mm; }
  .side .tiny { font-size: 5.5pt; }
  `,
  body: {
    title: 'Bagmati Province — Nepal Local Level Atlas Pilot',
    html: `
<div class="page">
  <div class="masthead">
    <div class="topline">
      <div class="eyebrow">Nepal · Local Level Atlas · Pilot · Sheet 2</div>
      <div class="edition">Open-data pilot<br>October 2026</div>
    </div>
    <div class="title">Bagmati Province<span class="np nep">बागमती प्रदेश</span></div>
    <div class="subtitle">13 districts · 119 local levels &nbsp;|&nbsp; Kathmandu Valley inset &nbsp;|&nbsp; Administrative reference map</div>
    <div class="rule"></div>
  </div>

  <div class="mapframe">${svgOut}
    <div class="map-legend">
      <div class="ml-title">Legend <span class="nep">संकेत</span></div>
      <div class="ml-row"><span class="ml-line"></span> Province boundary</div>
      <div class="ml-row"><span class="ml-line district"></span> District boundary</div>
      <div class="ml-row"><span class="ml-line local"></span> Local-level boundary</div>
      <div class="ml-row"><span class="ml-line valley"></span> Kathmandu Valley inset extent</div>
      <div class="ml-row"><span class="ml-star">★</span> National capital</div>
    </div>
  </div>

  <aside class="side">
    <h2>Province profile</h2>
    <div class="np">प्रदेश परिचय</div>
    <div class="profile-grid">
      <div class="stat"><b>13</b><span>districts</span></div>
      <div class="stat"><b>119</b><span>local levels</span></div>
      <div class="stat"><b>${Math.round(summaryProvince.area_km2).toLocaleString('en-US')}</b><span>km²</span></div>
    </div>
    <div class="typebox2">
      <b>${typeCounts['Metropolitan City'] || 0}</b> metropolitan &nbsp;·&nbsp;
      <b>${typeCounts['Sub-Metropolitan City'] || 0}</b> sub-metropolitan<br>
      <b>${typeCounts['Urban Municipality'] || 0}</b> municipalities &nbsp;·&nbsp;
      <b>${typeCounts['Rural Municipality'] || 0}</b> rural municipalities
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Kathmandu Valley</h2>
      <div class="np">काठमाडौं उपत्यका</div>
      <div class="inset-wrap">${insetSvg}</div>
      ${valleyKeyHtml}
      <div class="inset-note">21 local levels in Kathmandu, Bhaktapur and Lalitpur. Numbers key to the list above; local labels are suppressed in the red box on the main map.</div>
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Districts</h2>
      <div class="np">जिल्लाहरू</div>
      <div class="dtable">
        <div class="thead"><div class="dname">District / जिल्ला</div><div class="dnum">LL</div><div class="darea">km²</div></div>
        ${districtRows}
      </div>
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Source &amp; accuracy</h2>
      <div class="note">
        Boundaries: Open Knowledge Nepal, <i>LocalBoundaries</i> (CC BY 4.0).
        Codes and names: official 753-unit table. Projection: Albers equal-area, 27°N / 30°N.
      </div>
      <div class="note" style="margin-top:2mm">
        <b>Open-data edition.</b> Boundaries are generalised and are not a legal
        boundary determination.
      </div>
      <div class="badge">Pilot · not survey-grade</div>
    </div>
  </aside>

  <div class="footer">
    <div>Boundaries: Open Knowledge Nepal, LocalBoundaries (CC BY 4.0) · Codes: official 753-unit table · Projection: Albers equal-area, 27°N/30°N · October 2026</div>
    <div class="right">Open-data edition — not survey-grade · <span class="sheetno">Sheet 2 of 3</span></div>
  </div>
</div>`,
  },
});

fs.writeFileSync(OUT, html);
console.log('wrote', OUT, (fs.statSync(OUT).size / 1024).toFixed(1) + ' KB');
console.log('district labels:', districtLabelBoxes.length);
console.log('local labels:', localLabelBoxes.length, 'forced code labels:', unplacedLocals.length, unplacedLocals.slice(0, 20).join(','));
console.log('inset numbered locals:', placedNumbers.length, '/', valleyLocals.length);
