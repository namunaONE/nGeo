'use strict';

const { PALETTE } = require('./mapkit');

function baseCss(pageW, pageH) {
  return `
@page { size: ${pageW}mm ${pageH}mm; margin: 0; }
* { box-sizing: border-box; }
html, body { margin: 0; padding: 0; background: #d9d4c8; }
body {
  font-family: "Segoe UI", Arial, sans-serif;
  color: ${PALETTE.ink};
  -webkit-print-color-adjust: exact;
  print-color-adjust: exact;
}
.page {
  position: relative;
  width: ${pageW}mm;
  height: ${pageH}mm;
  overflow: hidden;
  background: ${PALETTE.paper};
  margin: 0 auto;
}
.page:after {
  content: "";
  position: absolute; inset: 0;
  pointer-events: none;
  box-shadow: inset 0 0 0 0.25mm rgba(31,41,55,0.06);
}
.nep { font-family: "Nirmala UI", "Noto Sans Devanagari", sans-serif; }
.sans { font-family: "Segoe UI", Arial, sans-serif; }
.eyebrow {
  font-size: 7.2pt; font-weight: 700; letter-spacing: 0.22em;
  text-transform: uppercase; color: ${PALETTE.rule};
}
.title { font-size: 31pt; line-height: 0.98; font-weight: 700; letter-spacing: -0.02em; }
.title .np { display: block; font-size: 17pt; font-weight: 600; letter-spacing: 0; margin-top: 2.2mm; color: #374151; }
.subtitle { font-size: 8.4pt; color: #4B5563; margin-top: 2.2mm; letter-spacing: 0.01em; }
.masthead {
  position: absolute; left: 18mm; right: 18mm; top: 13mm; height: 38mm;
}
.masthead .topline {
  display: flex; justify-content: space-between; align-items: baseline;
}
.masthead .edition {
  font-size: 6.6pt; font-weight: 700; letter-spacing: 0.16em;
  text-transform: uppercase; color: #6B7280; text-align: right; line-height: 1.55;
}
.rule {
  position: absolute; left: 0; right: 0; top: 37mm; height: 0.55mm;
  background: ${PALETTE.rule};
}
.mapframe {
  position: absolute; left: 18mm; top: 62mm; width: 402mm; height: 322mm;
  background: #F7F4EC; border: 0.25mm solid #D8D2C4; overflow: hidden;
}
.mapframe svg { display: block; width: 100%; height: 100%; }
.side {
  position: absolute; left: 432mm; top: 62mm; width: 144mm; height: 322mm;
  background: ${PALETTE.panel}; border: 0.25mm solid #D8D2C4;
  padding: 7mm 7mm 6mm 7mm; overflow: hidden;
}
.side h2 {
  margin: 0 0 1.2mm 0; font-size: 7.2pt; letter-spacing: 0.2em;
  text-transform: uppercase; color: #374151; font-weight: 700;
}
.side h2 + .np { margin: -0.4mm 0 3mm 0; font-size: 7.5pt; color: #6B7280; }
.side .section { margin-top: 5.5mm; }
.side .divider { height: 0.25mm; background: #D8D2C4; margin: 4.2mm 0 0 0; }
.side .muted { color: #6B7280; }
.side .tiny { font-size: 5.7pt; line-height: 1.5; color: #6B7280; }
.side .note { font-size: 6.1pt; line-height: 1.55; color: #4B5563; }
.footer {
  position: absolute; left: 18mm; right: 18mm; bottom: 8mm;
  display: flex; justify-content: space-between; gap: 8mm;
  font-size: 5.6pt; line-height: 1.35; color: #6B7280;
  border-top: 0.25mm solid #D8D2C4; padding-top: 1.6mm;
}
.footer .right { text-align: right; white-space: nowrap; }
.sheetno { color: #B91C1C; font-weight: 700; }
.legendrow { display: flex; align-items: center; gap: 2.4mm; margin: 1.5mm 0; font-size: 6.3pt; color: #374151; }
.legendline { width: 11mm; height: 0; border-top: 0.5mm solid #1F2937; }
.legendline.district { border-top: 0.3mm solid #6B7280; }
.legendline.local { border-top: 0.18mm solid #9CA3AF; }
.legendline.protected { border-top: 0; height: 3.2mm; background: #E8E2D2; border: 0.2mm solid #C9C2B2; }
.swatch { width: 4.4mm; height: 4.4mm; border: 0.2mm solid rgba(31,41,55,0.18); flex: 0 0 auto; }
.provrow { display: flex; align-items: center; gap: 2.2mm; margin: 2.4mm 0; }
.provrow .names { flex: 1; min-width: 0; }
.provrow .en { font-size: 7.2pt; font-weight: 700; letter-spacing: 0.01em; }
.provrow .np { font-size: 6.6pt; color: #4B5563; margin-top: -0.3mm; }
.provrow .count { font-size: 6.3pt; color: #4B5563; text-align: right; white-space: nowrap; }
.provrow .count b { color: #1F2937; font-size: 8pt; }
.statgrid { display: grid; grid-template-columns: 1fr 1fr; gap: 2.2mm 3mm; margin-top: 2.2mm; }
.stat { border-top: 0.25mm solid #D8D2C4; padding-top: 1.4mm; }
.stat b { display: block; font-size: 15pt; line-height: 1; letter-spacing: -0.03em; }
.stat span { display: block; font-size: 5.8pt; color: #6B7280; margin-top: 0.8mm; text-transform: uppercase; letter-spacing: 0.08em; }
.typebox { font-size: 6.1pt; line-height: 1.55; color: #374151; margin-top: 1.8mm; }
.typebox b { font-weight: 700; }
.badge {
  display: inline-block; font-size: 5.4pt; font-weight: 700; letter-spacing: 0.12em;
  text-transform: uppercase; color: #7F1D1D; background: #F6E4E0;
  border: 0.2mm solid #E7C4BC; padding: 1.2mm 2mm; margin-top: 2.5mm;
}
@media screen {
  body { padding: 8mm 0; }
  .page { box-shadow: 0 2mm 10mm rgba(0,0,0,0.18); }
}
@media print {
  html, body { background: ${PALETTE.paper}; }
  .page { box-shadow: none; margin: 0; }
}
`;
}

function pageHtml({ width, height, css, body }) {
  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>${body.title || 'Nepal Local Level Atlas — Pilot'}</title>
<style>${baseCss(width, height)}${css || ''}</style>
</head>
<body>
${body.html}
</body>
</html>`;
}

module.exports = { baseCss, pageHtml };
