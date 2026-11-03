'use strict';

const fs = require('fs');
const path = require('path');
const {
  PALETTE, PROV_COLORS, View, boundsOfFeatures, pathForGeometry,
  Labels, text, line, rect, scaleBar, northArrow, graticule, loadJSON, fmt,
} = require('./mapkit');
const { pageHtml } = require('./pagekit');

const HERE = __dirname;
const DATA = path.resolve(HERE, '..', 'data');
const OUT = path.resolve(HERE, '..', 'print', '01_national.html');

const provinces = loadJSON(path.join(DATA, 'provinces.geojson')).features;
const districts = loadJSON(path.join(DATA, 'districts.geojson')).features;
const locals = loadJSON(path.join(DATA, 'local_levels.geojson')).features;
const summary = loadJSON(path.join(DATA, 'summary.json'));

const W = 578, H = 458;
const view = new View(W, H, boundsOfFeatures(provinces), { left: 16, right: 16, top: 16, bottom: 24 });
const labels = new Labels(view, { margin: 3.4 });

function combinedPath(features) {
  return features.map((f) => pathForGeometry(f.geometry, view)).join('');
}

function spiralOffsets(step, rings) {
  const out = [[0, 0]];
  for (let r = 1; r <= rings; r++) {
    const n = Math.max(8, r * 8);
    for (let i = 0; i < n; i++) {
      const a = (Math.PI * 2 * i) / n - Math.PI / 2;
      out.push([Math.cos(a) * step * r, Math.sin(a) * step * r]);
    }
  }
  return out;
}

// Province labels only. District names are carried by the province and
// district sheets, where they can be set at a legible size.
const [kx, ky] = view.project(85.3240, 27.7172);
// Reserve the capital star and its two-line callout before labels are placed.
labels.addRect({ x1: kx - 4.2, x2: kx + 34, y1: ky - 4.4, y2: ky + 6.2 });

// Bagmati's centroid sits almost on Kathmandu. Pin it to the north-west of the
// province (Dhading / Nuwakot) so the capital callout stays clear.
const LABEL_ANCHOR = {
  3: [84.94, 28.06],
};

const provinceLabels = [];
const offsets = spiralOffsets(3.0, 6);
for (const p of provinces) {
  const pr = p.properties;
  if (pr.label_lon == null) continue;
  const anchor = LABEL_ANCHOR[pr.province_code] || [pr.label_lon, pr.label_lat];
  const [x, y] = view.project(anchor[0], anchor[1]);
  const en = pr.province_name_short.toUpperCase();
  const np = pr.province_name_np.replace(' प्रदेश', '');
  const c = labels.place(en, x, y, {
    size: 10.8, weight: 700, anchor: 'middle', factor: 0.64,
    offsets, haloWidth: 0.55, lineHeight: 1.05,
  });
  if (!c) { console.log('unplaced province', en); continue; }
  const npW = np.length * 8.2 * 0.3528 * 0.55;
  labels.addRect({
    x1: c.x - npW / 2, x2: c.x + npW / 2,
    y1: c.y + 1.8, y2: c.y + 5.2,
  });
  provinceLabels.push({ x: c.x, y: c.y, en, np });
}

const localPath = combinedPath(locals);
const districtPath = combinedPath(districts);

let svg = '';
svg += `<defs><clipPath id="mapclip"><rect x="0" y="0" width="${W}" height="${H}" rx="0.6"/></clipPath></defs>`;
svg += `<g clip-path="url(#mapclip)">`;
svg += `<rect x="0" y="0" width="${W}" height="${H}" fill="#F7F4EC"/>`;
svg += graticule(view, 80, 89, 26, 31, { step: 1, color: '#D9D4C8', width: 0.13 });
for (const p of provinces) {
  const pr = p.properties;
  svg += `<path d="${pathForGeometry(p.geometry, view)}" fill="${PROV_COLORS[pr.province_code] || '#E5E7EB'}" fill-rule="evenodd" stroke="#5B6472" stroke-width="0.42" stroke-linejoin="round"/>`;
}
svg += `<path d="${districtPath}" fill="none" stroke="#FFFFFF" stroke-width="0.50" stroke-linejoin="round" opacity="0.96"/>`;
svg += `<path d="${localPath}" fill="none" stroke="#FFFFFF" stroke-width="0.12" stroke-linejoin="round" opacity="0.55"/>`;
for (const p of provinces) {
  svg += `<path d="${pathForGeometry(p.geometry, view)}" fill="none" fill-rule="evenodd" stroke="#3F4754" stroke-width="0.62" stroke-linejoin="round"/>`;
}
for (const p of provinceLabels) {
  svg += text(p.x, p.y, p.en, {
    size: 10.8, weight: 700, fill: '#1F2937', letterSpacing: 0.04,
    haloColor: '#F7F4EC', haloWidth: 0.55,
  });
  svg += text(p.x, p.y + 4.8, p.np, {
    size: 8.2, weight: 600, fill: '#374151', font: 'nep',
    haloColor: '#F7F4EC', haloWidth: 0.4,
  });
}
// Capital marker
svg += `<g transform="translate(${fmt(kx, 2)},${fmt(ky, 2)})">
  <path d="M0 -3.1 L0.8 -1.2 L3.0 -0.9 L1.3 0.5 L1.8 2.8 L0 1.7 L-1.8 2.8 L-1.3 0.5 L-3.0 -0.9 L-0.8 -1.2 Z" fill="#B91C1C" stroke="#F7F4EC" stroke-width="0.3"/>
</g>`;
svg += text(kx + 3.4, ky + 0.9, 'Kathmandu', {
  size: 6.4, weight: 700, anchor: 'start', fill: '#7F1D1D', haloWidth: 0.45,
});
svg += text(kx + 3.4, ky + 4.2, 'काठमाडौं', {
  size: 6.2, weight: 600, anchor: 'start', fill: '#7F1D1D', font: 'nep', haloWidth: 0.34,
});
svg += scaleBar(view, 14, H - 24, 200, { height: 2.4 });
svg += northArrow(W - 24, 22, { size: 7.2 });
svg += `</g>`;
const svgOut = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${W} ${H}" preserveAspectRatio="xMidYMid meet">${svg}</svg>`;

const provinceRows = summary.provinces.map((p) => `
  <div class="provrow">
    <span class="pnum">${p.code}</span>
    <span class="swatch" style="background:${PROV_COLORS[p.code]}"></span>
    <div class="names">
      <div class="en">${p.name.replace(' Province', '')}</div>
      <div class="np nep">${p.name_np.replace(' प्रदेश', '')}</div>
    </div>
    <div class="count"><b>${p.local_levels}</b><br>${p.districts} dist.</div>
  </div>`).join('');

const districtGroups = summary.provinces.map((p) => ({
  province: p,
  list: districts
    .filter((d) => d.properties.province_code === p.code)
    .sort((a, b) => a.properties.district_name.localeCompare(b.properties.district_name)),
}));

function districtColumn(groups) {
  return groups.map(({ province, list }) => `
    <div class="dgroup">
      <div class="dgroup-head">
        <span>${province.code} · ${province.name.replace(' Province', '')}</span>
        <span>${list.length}</span>
      </div>
      ${list.map((d) => `
        <div class="drow">
          <span class="den">${d.properties.district_name}</span>
          <span class="dnp nep">${d.properties.district_name_np}</span>
          <span class="dct">${d.properties.local_count}</span>
        </div>`).join('')}
    </div>`).join('');
}

const districtIndexHtml = `
  <div class="district-index">
    <div>${districtColumn(districtGroups.filter((g) => g.province.code <= 2))}</div>
    <div>${districtColumn(districtGroups.filter((g) => g.province.code === 3 || g.province.code === 4))}</div>
    <div>${districtColumn(districtGroups.filter((g) => g.province.code >= 5))}</div>
  </div>`;

const types = summary.counts.types;
const html = pageHtml({
  width: 841, height: 594,
  css: `
  .masthead { left: 20mm; right: 20mm; top: 15mm; height: 46mm; }
  .masthead .title { font-size: 43pt; }
  .masthead .title .np { font-size: 22pt; margin-top: 2.6mm; }
  .masthead .subtitle { font-size: 10pt; margin-top: 3mm; }
  .masthead .eyebrow { font-size: 8.4pt; }
  .masthead .edition { font-size: 7.6pt; }
  .rule { top: 47mm; height: 0.65mm; }
  .mapframe { left: 20mm; top: 80mm; width: 590mm; height: 470mm; }
  .side { left: 625mm; top: 80mm; width: 196mm; height: 470mm; padding: 9mm 9mm 8mm 9mm; }
  .footer { left: 20mm; right: 20mm; bottom: 10mm; font-size: 6.4pt; padding-top: 2mm; }
  .side h2 { font-size: 8.2pt; }
  .side h2 + .np { font-size: 8.6pt; }
  .provrow { margin: 3.4mm 0; gap: 3mm; }
  .provrow .en { font-size: 8.2pt; }
  .provrow .np { font-size: 7.5pt; }
  .provrow .count { font-size: 7pt; }
  .provrow .count b { font-size: 9.2pt; }
  .pnum {
    width: 6.6mm; height: 6.6mm; border-radius: 50%; background: #1F2937; color: #fff;
    font-size: 7.4pt; font-weight: 700; display: flex; align-items: center; justify-content: center;
    flex: 0 0 auto;
  }
  .statgrid { gap: 3mm 4mm; }
  .stat b { font-size: 19pt; }
  .stat span { font-size: 6.4pt; }
  .typebox { font-size: 6.8pt; }
  .district-index {
    display: grid; grid-template-columns: repeat(3, 1fr); gap: 0 5.5mm;
    margin-top: 2.2mm;
  }
  .dgroup { margin-bottom: 3.6mm; }
  .dgroup-head {
    display: flex; justify-content: space-between; align-items: baseline;
    font-size: 5.9pt; font-weight: 700; color: #7F1D1D;
    border-bottom: 0.22mm solid #D3CDBF; padding-bottom: 0.9mm; margin-bottom: 0.9mm;
    letter-spacing: 0.02em;
  }
  .drow { display: flex; align-items: baseline; gap: 1.2mm; font-size: 5.65pt; line-height: 1.5; }
  .drow .den { color: #374151; white-space: nowrap; }
  .drow .dnp { flex: 1; color: #6B7280; font-size: 5.4pt; white-space: nowrap; overflow: hidden; }
  .drow .dct { color: #9CA3AF; font-size: 5.15pt; }
  .index-key { font-size: 5.6pt; color: #6B7280; margin-top: 0.6mm; }
  .side .note { font-size: 6.8pt; }
  .side .tiny { font-size: 6.2pt; }
  .legendrow { font-size: 7pt; margin: 2mm 0; }
  .badge { font-size: 5.8pt; padding: 1.5mm 2.4mm; }
  `,
  body: {
    title: 'Nepal — Local Level Atlas Pilot',
    html: `
<div class="page">
  <div class="masthead">
    <div class="topline">
      <div class="eyebrow">Nepal · Local Level Atlas · Pilot</div>
      <div class="edition">Open-data pilot<br>October 2026</div>
    </div>
    <div class="title">Nepal<span class="np nep">नेपाल</span></div>
    <div class="subtitle">7 provinces · 77 districts · 753 local levels &nbsp;|&nbsp; Administrative reference map</div>
    <div class="rule"></div>
  </div>

  <div class="mapframe">${svgOut}</div>

  <aside class="side">
    <h2>Provinces</h2>
    <div class="np">प्रदेशहरू</div>
    ${provinceRows}

    <div class="divider"></div>
    <div class="section">
      <h2>At a glance</h2>
      <div class="statgrid">
        <div class="stat"><b>753</b><span>local levels</span></div>
        <div class="stat"><b>77</b><span>districts</span></div>
        <div class="stat"><b>7</b><span>provinces</span></div>
        <div class="stat"><b>17</b><span>metro / sub-metro</span></div>
      </div>
      <div class="typebox">
        <b>${types['Rural Municipality']}</b> rural municipalities &nbsp;·&nbsp;
        <b>${types['Urban Municipality']}</b> municipalities<br>
        <b>${types['Sub-Metropolitan City']}</b> sub-metropolitan &nbsp;·&nbsp;
        <b>${types['Metropolitan City']}</b> metropolitan cities
      </div>
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>District index</h2>
      <div class="np">जिल्ला सूची</div>
      <div class="index-key">Number after each district = local levels in that district.</div>
      ${districtIndexHtml}
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>How to read</h2>
      <div class="note">
        Province names are placed directly on the map. White lines separate
        the 77 districts; faint white lines show local-level boundaries beneath
        them. District names and local-level detail appear on the province and
        district sheets, where they can be set at a legible size.
      </div>
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Legend</h2>
      <div class="legendrow"><span class="legendline"></span> Province boundary</div>
      <div class="legendrow"><span class="legendline district"></span> District boundary</div>
      <div class="legendrow"><span class="legendline local"></span> Local-level boundary</div>
      <div class="legendrow"><span style="display:inline-block;width:6mm;text-align:center;color:#B91C1C;font-size:10pt">★</span> National capital</div>
    </div>

    <div class="divider"></div>
    <div class="section">
      <h2>Source &amp; accuracy</h2>
      <div class="note">
        Boundaries: Open Knowledge Nepal, <i>LocalBoundaries</i> (CC BY 4.0).
        Codes and names: official 753-unit table.
        Projection: Albers equal-area, 27°N / 30°N.
      </div>
      <div class="note" style="margin-top:2.8mm">
        <b>Open-data edition.</b> Boundaries are generalised and are not a legal
        boundary determination. Protected-area polygons are deliberately omitted
        from this pilot because the open overlay is incomplete.
      </div>
      <div class="badge">Pilot · not survey-grade</div>
    </div>
  </aside>

  <div class="footer">
    <div>Boundaries: Open Knowledge Nepal, LocalBoundaries (CC BY 4.0) · Codes: official 753-unit table · Projection: Albers equal-area, 27°N/30°N · October 2026</div>
    <div class="right">Open-data edition — not survey-grade · <span class="sheetno">Sheet 1 of 3</span></div>
  </div>
</div>`,
  },
});

fs.writeFileSync(OUT, html);
console.log('wrote', OUT, (fs.statSync(OUT).size / 1024).toFixed(1) + ' KB');
console.log('province labels placed:', provinceLabels.length);
