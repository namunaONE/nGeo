'use strict';

const fs = require('fs');
const path = require('path');
const {
  PALETTE, PROV_COLORS, DISTRICT_COLORS, View, boundsOfFeatures, geomBounds,
  pathForGeometry, Labels, text, line, rect, scaleBar, northArrow, loadJSON, fmt,
} = require('./mapkit');
const { pageHtml } = require('./pagekit');

const HERE = __dirname;
const DATA = path.resolve(HERE, '..', 'data');
const OUT = path.resolve(HERE, '..', 'print', '04_peaks.html');

const provinces = loadJSON(path.join(DATA, 'provinces.geojson')).features;
const peaksData = JSON.parse(fs.readFileSync(path.join(DATA, 'peaks_draft.geojson'), 'utf8'));
const peaks = peaksData.features.slice().sort((a, b) => b.properties.elevation_m - a.properties.elevation_m);

// A2 landscape.
const W = 594, H = 420;
const MAP = { left: 18, top: 62, width: 400, height: 320 };
const SIDE = { left: 430, top: 62, width: 146, height: 320 };

// Bounds from peaks.
const peakBounds = boundsOfFeatures(peaks);
const PAD = 0.6;
const bounds = [peakBounds[0] - PAD, peakBounds[1] - PAD, peakBounds[2] + PAD, peakBounds[3] + PAD];
const view = new View(MAP.width, MAP.height, bounds, { left: 4, right: 4, top: 4, bottom: 4 });

// National boundary from provinces (projected with the same view).
const nationalPath = provinces.map((f) => pathForGeometry(f.geometry, view)).join('');

function px(lon, lat) { return view.project(lon, lat); }

// Peak symbol.
function peakSymbol(p, x, y) {
  const cls = p.peak_class;
  const r = cls === 'eight_thousander_main' ? 2.6 : (cls === 'eight_thousander_official_additional' ? 2.2 : 1.5);
  let s = '';
  if (cls === 'eight_thousander_main') {
    // filled dark triangle
    s += `<polygon points="${x},${y - r} ${x - r},${y + r} ${x + r},${y + r}" fill="#1F2937" stroke="#FBF9F4" stroke-width="0.25"/>`;
  } else if (cls === 'eight_thousander_official_additional') {
    s += `<polygon points="${x},${y - r} ${x - r},${y + r} ${x + r},${y + r}" fill="#FFFFFF" stroke="#1F2937" stroke-width="0.35"/>`;
  } else {
    s += `<polygon points="${x},${y - r} ${x - r},${y + r} ${x + r},${y + r}" fill="#4B5563" stroke="#FBF9F4" stroke-width="0.2"/>`;
  }
  return s;
}

// Build map SVG.
let mapSvg = '';
// Province fills (light).
for (const f of provinces) {
  const code = f.properties.province_code;
  const c = PROV_COLORS[code] || '#E7E2D6';
  mapSvg += `<path d="${pathForGeometry(f.geometry, view)}" fill="${c}" fill-opacity="0.35" stroke="none"/>`;
}
// National outline.
mapSvg += `<path d="${provinces.map((f) => pathForGeometry(f.geometry, view)).join('')}" fill="none" stroke="#4B5563" stroke-width="0.6" stroke-linejoin="round"/>`;
// Graticule (light).
for (let lon = 80; lon <= 89; lon++) {
  const [x1, y1] = view.project(lon, 26.5);
  const [x2, y2] = view.project(lon, 30.5);
  mapSvg += line(x1, y1, x2, y2, { stroke: '#D9D4C8', width: 0.15 });
}
for (let lat = 27; lat <= 30; lat++) {
  const [x1, y1] = view.project(80, lat);
  const [x2, y2] = view.project(89, lat);
  mapSvg += line(x1, y1, x2, y2, { stroke: '#D9D4C8', width: 0.15 });
}
// Peaks.
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
}

// Side index.
const groups = [
  { title: 'Main 8,000 m', cls: 'eight_thousander_main' },
  { title: 'Official additional 6', cls: 'eight_thousander_official_additional' },
  { title: '7,000 m', cls: 'seven_thousander' },
];
let sideHtml = '';
for (const g of groups) {
  const items = indexed.filter(({ f }) => f.properties.peak_class === g.cls);
  sideHtml += `<div class="sidegroup"><h3>${g.title} <span class="count">${items.length}</span></h3>`;
  sideHtml += '<ol class="peakindex">';
  for (const { f, n } of items) {
    const p = f.properties;
    const np = p.name_np ? ` <span class="np">${p.name_np}</span>` : '';
    const pending = p.name_np_status === 'pending' ? ' <span class="pending">(name pending)</span>' : '';
    sideHtml += `<li value="${n}"><b>${p.name_en}</b>${np}${pending}<span class="elev">${Number(p.elevation_m).toLocaleString()} m</span></li>`;
  }
  sideHtml += '</ol></div>';
}

// Legend.
const legendHtml = `
  <div class="legendrow"><span class="peakswatch main"></span><span>Main 8,000 m (filled)</span></div>
  <div class="legendrow"><span class="peakswatch official"></span><span>Official additional 8,000 m (open)</span></div>
  <div class="legendrow"><span class="peakswatch seven"></span><span>7,000 m (numbered key)</span></div>
  <div class="legendrow"><span class="peakswatch pending"></span><span>Name pending (Thulagi Chuli)</span></div>
`;

const extraCss = `
  .mapframe { width: 400mm; height: 320mm; }
  .side { left: 430mm; top: 62mm; width: 146mm; height: 320mm; }
  .peakswatch { width: 4.4mm; height: 4.4mm; flex: 0 0 auto; display: inline-block; }
  .peakswatch.main { background: #1F2937; clip-path: polygon(50% 0%, 0% 100%, 100% 100%); }
  .peakswatch.official { background: #FFFFFF; border: 0.3mm solid #1F2937; clip-path: polygon(50% 0%, 0% 100%, 100% 100%); }
  .peakswatch.seven { background: #4B5563; clip-path: polygon(50% 0%, 0% 100%, 100% 100%); width: 3.2mm; height: 3.2mm; }
  .peakswatch.pending { background: #B91C1C; clip-path: polygon(50% 0%, 0% 100%, 100% 100%); }
  .sidegroup { margin-top: 4mm; }
  .sidegroup h3 { font-size: 6.6pt; font-weight: 700; margin: 0 0 1.5mm; color: #374151; text-transform: uppercase; letter-spacing: 0.1em; }
  .sidegroup h3 .count { color: #6B7280; font-weight: 500; }
  .peakindex { list-style: none; padding: 0; margin: 0; columns: 1; }
  .peakindex li { font-size: 5.6pt; line-height: 1.35; margin: 0.8mm 0; break-inside: avoid; }
  .peakindex li b { font-weight: 700; color: #1F2937; }
  .peakindex .np { font-family: "Nirmala UI", "Noto Sans Devanagari", sans-serif; color: #4B5563; margin-left: 1.2mm; font-size: 5.4pt; }
  .peakindex .elev { float: right; color: #6B7280; font-variant-numeric: tabular-nums; }
  .peakindex .pending { color: #B91C1C; font-style: italic; font-size: 5.2pt; }
  .notebox { margin-top: 5mm; padding: 3mm 3.5mm; background: #F7F4EC; border: 0.2mm solid #D8D2C4; border-radius: 0.5mm; font-size: 5.6pt; line-height: 1.5; color: #374151; }
  .notebox b { font-weight: 700; }
`;

const bodyHtml = `
  <div class="page">
    <div class="masthead">
      <div class="topline">
        <div>
          <div class="eyebrow">Nepal Local Level Atlas · v1.1 reference edition · peaks</div>
          <div class="title">Peaks of Nepal<span class="np">नेपालका हिमाल चुचुरा</span></div>
          <div class="subtitle">8 main eight-thousanders · 6 official additional summits · 37 curated 7,000 m peaks · point symbols only · published areas and elevations, not survey-grade</div>
        </div>
        <div class="edition">
          Sheet 04 of 4<br>
          A2 landscape<br>
          October 2026<br>
          Open-data reference edition
        </div>
      </div>
      <div class="rule"></div>
    </div>

    <div class="mapframe">
      <svg viewBox="0 0 ${MAP.width} ${MAP.height}" preserveAspectRatio="none">
        ${mapSvg}
      </svg>
    </div>

    <div class="side">
      <h2>Peak index<span class="np">चुचुरा सूची</span></h2>
      <div class="statgrid">
        <div class="stat"><b>${peaks.length}</b><span>Total peaks</span></div>
        <div class="stat"><b>8</b><span>Main 8,000 m</span></div>
        <div class="stat"><b>6</b><span>Official additional</span></div>
        <div class="stat"><b>37</b><span>7,000 m</span></div>
      </div>
      ${sideHtml}
      <div class="divider"></div>
      <div class="notebox">
        <b>8 vs 14:</b> Nepal's 2025 official profile lists 14 peaks above 8,000 m by adding six subsidiary summits to the eight main eight-thousanders. UIAA/international recognition remains eight. The atlas presents both classes without adjudicating the dispute.<br><br>
        <b>Geometry:</b> peaks are point symbols only. No peak polygon, buffer or viewshed is drawn. Elevations vary by source; figures are compiled from Wikidata, Wikipedia and the Himalayan Database.<br><br>
        <b>Protected areas:</b> under D10 (DNPWC deferral) no protected-area or buffer-zone polygon is shown. Attributes appear in the reference tables. Boundaries are indicative, not legal.<br><br>
        <b>Accuracy:</b> open-data reference edition. Not survey-grade, not a legal boundary determination. Published areas are not measurements of project geometry.
      </div>
      <div class="divider"></div>
      <h2 style="margin-top:4mm">Legend<span class="np">संकेत</span></h2>
      ${legendHtml}
    </div>

    <div class="footer">
      <div>
        <b>Source:</b> Wikidata (CC0), Wikipedia (CC BY-SA 4.0), Himalayan Database (facts only), Open Knowledge Nepal LocalBoundaries (CC BY 4.0).<br>
        <b>Protected-area figures:</b> published DNPWC/Nepal Tourism Board/OpenDataNepal figures, compiled for this atlas; boundaries pending (D10).<br>
        <b>Accuracy:</b> Open-data reference edition. Not survey-grade. Not a legal boundary determination.
      </div>
      <div class="right">
        <span class="sheetno">Sheet 04 of 4</span><br>
        Peaks · A2 landscape<br>
        October 2026
      </div>
    </div>
  </div>
`;

const html = pageHtml({ width: W, height: H, css: extraCss, body: { title: 'Nepal peaks — A2', html: bodyHtml } });
fs.writeFileSync(OUT, html);
console.log('Wrote', OUT);
console.log('Peaks:', peaks.length, '(8 main + 6 official + 37 seven-thousanders)');