'use strict';

const fs = require('fs');
const path = require('path');

const R = 6371.0;
const LON0 = 84.1;
const LAT0 = 28.4;
const SP1 = 27.0;
const SP2 = 30.0;
const N = (Math.sin(SP1 * Math.PI / 180) + Math.sin(SP2 * Math.PI / 180)) / 2;
const C = Math.cos(SP1 * Math.PI / 180) ** 2 + 2 * N * Math.sin(SP1 * Math.PI / 180);
const RHO0 = Math.sqrt(C - 2 * N * Math.sin(LAT0 * Math.PI / 180)) / N;

const PALETTE = {
  paper: '#FBF9F4',
  panel: '#F3F0E6',
  ink: '#1F2937',
  muted: '#6B7280',
  faint: '#9CA3AF',
  rule: '#B91C1C',
  grid: '#D9D4C8',
  protected: '#E8E2D2',
  neighbor: '#E9E5DB',
  neighborLine: '#CFC9BC',
};

const PROV_COLORS = {
  1: '#DCE8D4',
  2: '#F2E2C8',
  3: '#D7E5F1',
  4: '#E7DDF0',
  5: '#F3D8D2',
  6: '#E7E1C8',
  7: '#D5EAE6',
};

const DISTRICT_COLORS = [
  '#CFE3D2', '#F1E0C3', '#D3E2F2', '#F2D5DE', '#E3DAF1', '#F5D8C6',
  '#D6EDE8', '#E8E3C9', '#DCE8C8', '#D8DFF3', '#F0DBD2', '#E6DEF4',
  '#D5EADB', '#F2E8C9',
];

const LOCAL_COLORS = [
  '#D7E6D4', '#F0E0C4', '#D4E3F2', '#F1D6DF', '#E3DBF2',
  '#F4D8C6', '#D8ECE8', '#E9E3CB', '#DDE9C9', '#D9E0F2', '#F1DCD3',
];

function albers(lon, lat) {
  const rho = Math.sqrt(C - 2 * N * Math.sin(lat * Math.PI / 180)) / N;
  const theta = N * (lon - LON0) * Math.PI / 180;
  return [R * rho * Math.sin(theta), R * (RHO0 - rho * Math.cos(theta))];
}

function polygonsOf(geom) {
  if (!geom) return [];
  if (geom.type === 'Polygon') return [geom.coordinates];
  if (geom.type === 'MultiPolygon') return geom.coordinates;
  return [];
}

function eachPoint(geom, fn) {
  for (const poly of polygonsOf(geom)) {
    for (const ring of poly) {
      for (const p of ring) fn(p);
    }
  }
}

function geomBounds(geom) {
  let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
  eachPoint(geom, ([lon, lat]) => {
    const [x, y] = albers(lon, lat);
    if (x < minX) minX = x;
    if (y < minY) minY = y;
    if (x > maxX) maxX = x;
    if (y > maxY) maxY = y;
  });
  return [minX, minY, maxX, maxY];
}

function boundsOfFeatures(features) {
  let b = [Infinity, Infinity, -Infinity, -Infinity];
  for (const f of features) {
    const fb = geomBounds(f.geometry);
    b[0] = Math.min(b[0], fb[0]);
    b[1] = Math.min(b[1], fb[1]);
    b[2] = Math.max(b[2], fb[2]);
    b[3] = Math.max(b[3], fb[3]);
  }
  return b;
}

class View {
  constructor(width, height, bounds, padding) {
    this.width = width;
    this.height = height;
    this.bounds = bounds;
    this.padding = Object.assign({ left: 6, right: 6, top: 6, bottom: 6 }, padding || {});
    const [minX, minY, maxX, maxY] = bounds;
    const availW = width - this.padding.left - this.padding.right;
    const availH = height - this.padding.top - this.padding.bottom;
    this.scale = Math.min(availW / (maxX - minX), availH / (maxY - minY));
    this.offsetX = this.padding.left + (availW - (maxX - minX) * this.scale) / 2;
    this.offsetY = this.padding.top + (availH - (maxY - minY) * this.scale) / 2;
    this.kmPerMm = 1 / this.scale;
  }

  project(lon, lat) {
    const [x, y] = albers(lon, lat);
    return [
      this.offsetX + (x - this.bounds[0]) * this.scale,
      this.offsetY + (this.bounds[3] - y) * this.scale,
    ];
  }

  projectXY(x, y) {
    return [
      this.offsetX + (x - this.bounds[0]) * this.scale,
      this.offsetY + (this.bounds[3] - y) * this.scale,
    ];
  }
}

function fmt(n, d = 2) {
  return Number(n).toFixed(d).replace(/\.0+$/, '').replace(/(\.\d*?)0+$/, '$1');
}

function pathForGeometry(geom, view, decimals = 2) {
  const parts = [];
  for (const poly of polygonsOf(geom)) {
    for (const ring of poly) {
      if (!ring.length) continue;
      let d = '';
      for (let i = 0; i < ring.length; i++) {
        const [x, y] = view.project(ring[i][0], ring[i][1]);
        d += (i === 0 ? 'M' : 'L') + fmt(x, decimals) + ' ' + fmt(y, decimals);
      }
      d += 'Z';
      parts.push(d);
    }
  }
  return parts.join('');
}

function esc(s) {
  return String(s == null ? '' : s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function textWidthMm(text, sizePt, factor = 0.54) {
  return String(text).length * sizePt * 0.3528 * factor;
}

class Labels {
  constructor(view, opts = {}) {
    this.view = view;
    this.rects = [];
    this.items = [];
    this.margin = opts.margin == null ? 2 : opts.margin;
  }

  addRect(r) {
    this.rects.push(r);
    return r;
  }

  collides(r) {
    for (const q of this.rects) {
      if (!(r.x2 < q.x1 || r.x1 > q.x2 || r.y2 < q.y1 || r.y1 > q.y2)) return true;
    }
    return false;
  }

  inFrame(r) {
    return r.x1 >= this.margin && r.x2 <= this.view.width - this.margin &&
      r.y1 >= this.margin && r.y2 <= this.view.height - this.margin;
  }

  fit(text, x, y, opts = {}) {
    const size = opts.size || 6;
    const factor = opts.factor || 0.54;
    const w = textWidthMm(text, size, factor);
    const h = size * 0.3528 * (opts.lineHeight || 1.15);
    const anchor = opts.anchor || 'middle';
    let x1 = x, x2 = x;
    if (anchor === 'middle') { x1 = x - w / 2; x2 = x + w / 2; }
    else if (anchor === 'start') { x1 = x; x2 = x + w; }
    else if (anchor === 'end') { x1 = x - w; x2 = x; }
    const y1 = y - h * 0.8, y2 = y + h * 0.2;
    return { x1, y1, x2, y2, w, h };
  }

  place(text, x, y, opts = {}) {
    const candidates = [];
    const size = opts.size || 6;
    const step = size * 0.3528 * 1.15;
    const offsets = opts.offsets || [
      [0, 0], [0, -step], [0, step], [0, -2 * step], [0, 2 * step],
      [step * 0.9, 0], [-step * 0.9, 0], [step * 0.9, -step], [-step * 0.9, -step],
      [step * 0.9, step], [-step * 0.9, step],
      [0, -3 * step], [0, 3 * step], [step * 1.8, 0], [-step * 1.8, 0],
    ];
    for (const [dx, dy] of offsets) {
      const r = this.fit(text, x + dx, y + dy, opts);
      if (!this.inFrame(r) || this.collides(r)) continue;
      candidates.push({ x: x + dx, y: y + dy, r, leader: Math.hypot(dx, dy) > step * 0.6 });
      break;
    }
    if (!candidates.length) {
      if (!opts.force) return null;
      const r = this.fit(text, x, y, opts);
      candidates.push({ x, y, r, leader: false });
    }
    const c = candidates[0];
    this.addRect(c.r);
    this.items.push(c);
    return c;
  }

  // Place a multi-line label block. `lines` is an array of
  // { text, size, font, weight, factor }. The anchor (x, y) is the centre of
  // the block; the returned lines carry baseline positions for rendering.
  placeBlock(lines, x, y, opts = {}) {
    const step = opts.step || (lines[0].size || 6) * 0.3528 * 1.25;
    const offsets = opts.offsets || [
      [0, 0], [0, -step], [0, step], [0, -2 * step], [0, 2 * step],
      [step * 0.9, 0], [-step * 0.9, 0], [step * 0.9, -step], [-step * 0.9, -step],
      [step * 0.9, step], [-step * 0.9, step],
      [0, -3 * step], [0, 3 * step], [step * 1.8, 0], [-step * 1.8, 0],
      [0, -4 * step], [0, 4 * step], [step * 2.7, 0], [-step * 2.7, 0],
    ];
    const heights = lines.map((l) => (l.size || 6) * 0.3528 * 1.2);
    const h = heights.reduce((a, b) => a + b, 0);
    const w = Math.max(...lines.map((l) => textWidthMm(l.text, l.size || 6, l.factor || 0.54)));
    const anchor = opts.anchor || 'middle';

    const makeRect = (cx, cy) => {
      let x1 = cx;
      let x2 = cx;
      if (anchor === 'middle') { x1 = cx - w / 2; x2 = cx + w / 2; }
      else if (anchor === 'start') { x1 = cx; x2 = cx + w; }
      else if (anchor === 'end') { x1 = cx - w; x2 = cx; }
      return { x1, x2, y1: cy - h / 2, y2: cy + h / 2, w, h };
    };

    let chosen = null;
    for (const [dx, dy] of offsets) {
      const r = makeRect(x + dx, y + dy);
      if (!this.inFrame(r) || this.collides(r)) continue;
      chosen = { x: x + dx, y: y + dy, r, leader: Math.hypot(dx, dy) > step * 0.6 };
      break;
    }
    if (!chosen) {
      if (!opts.force) return null;
      const r = makeRect(x, y);
      chosen = { x, y, r, leader: false };
    }

    this.addRect(chosen.r);
    let baseline = chosen.y - h / 2 + heights[0] * 0.82;
    chosen.lines = lines.map((l, i) => {
      const item = {
        x: chosen.x,
        y: baseline,
        text: l.text,
        size: l.size || 6,
        font: l.font || 'sans',
        weight: l.weight == null ? 500 : l.weight,
        factor: l.factor || 0.54,
        anchor,
      };
      baseline += heights[i] * 1.02;
      return item;
    });
    this.items.push(chosen);
    return chosen;
  }
}

function text(x, y, s, opts = {}) {
  const size = opts.size || 6;
  const fill = opts.fill || PALETTE.ink;
  const weight = opts.weight || 400;
  const anchor = opts.anchor || 'middle';
  const font = opts.font || 'sans';
  const family = font === 'nep'
    ? "'Nirmala UI','Noto Sans Devanagari',sans-serif"
    : "'Segoe UI',Arial,sans-serif";
  // In an SVG with a scaled viewBox, Chromium resolves `pt` font sizes in
  // user units rather than CSS points. Convert explicitly so the size passed
  // by the layout code is the physical point size on the printed sheet.
  const fontSize = size * 0.3528;
  const attrs = [
    `x="${fmt(x, 2)}"`, `y="${fmt(y, 2)}"`,
    `font-family="${family}"`, `font-size="${fmt(fontSize, 2)}"`, `font-weight="${weight}"`,
    `fill="${fill}"`, `text-anchor="${anchor}"`,
  ];
  if (opts.letterSpacing) attrs.push(`letter-spacing="${opts.letterSpacing}"`);
  if (opts.opacity != null) attrs.push(`opacity="${opts.opacity}"`);
  if (opts.halo !== false) {
    attrs.push('paint-order="stroke"', `stroke="${opts.haloColor || PALETTE.paper}"`,
      `stroke-width="${opts.haloWidth || 0.45}"`, 'stroke-linejoin="round"');
  }
  if (opts.className) attrs.push(`class="${opts.className}"`);
  return `<text ${attrs.join(' ')}>${esc(s)}</text>`;
}

function line(x1, y1, x2, y2, opts = {}) {
  return `<line x1="${fmt(x1, 2)}" y1="${fmt(y1, 2)}" x2="${fmt(x2, 2)}" y2="${fmt(y2, 2)}" ` +
    `stroke="${opts.stroke || PALETTE.ink}" stroke-width="${opts.width || 0.2}" ` +
    (opts.dash ? `stroke-dasharray="${opts.dash}" ` : '') +
    (opts.opacity != null ? `opacity="${opts.opacity}" ` : '') +
    `stroke-linecap="${opts.cap || 'butt'}" />`;
}

function rect(x, y, w, h, opts = {}) {
  return `<rect x="${fmt(x, 2)}" y="${fmt(y, 2)}" width="${fmt(w, 2)}" height="${fmt(h, 2)}" ` +
    `fill="${opts.fill || 'none'}" stroke="${opts.stroke || 'none'}" ` +
    `stroke-width="${opts.width || 0}" ${opts.rx ? `rx="${opts.rx}" ` : ''}/>`;
}

function scaleBar(view, x, y, km, opts = {}) {
  const mm = km * view.scale;
  const h = opts.height || 2.2;
  const half = mm / 2;
  let s = '';
  s += rect(x, y, half, h, { fill: '#1F2937' });
  s += rect(x + half, y, half, h, { fill: '#FBF9F4', stroke: '#1F2937', width: 0.18 });
  s += text(x, y + h + 3.0, '0', { size: 5.5, anchor: 'middle', halo: false, fill: '#374151' });
  s += text(x + half, y + h + 3.0, fmt(km / 2, 0), { size: 5.5, anchor: 'middle', halo: false, fill: '#374151' });
  s += text(x + mm, y + h + 3.0, fmt(km, 0) + ' km', { size: 5.5, anchor: 'middle', halo: false, fill: '#374151' });
  return s;
}

function northArrow(x, y, opts = {}) {
  const s = opts.size || 7;
  return `<g transform="translate(${fmt(x, 2)},${fmt(y, 2)})">` +
    `<path d="M0 ${fmt(-s, 2)} L${fmt(s * 0.42, 2)} ${fmt(s * 0.55, 2)} L0 ${fmt(s * 0.22, 2)} L${fmt(-s * 0.42, 2)} ${fmt(s * 0.55, 2)} Z" fill="#1F2937"/>` +
    text(0, -s - 2.4, 'N', { size: 6.5, weight: 700, halo: false, fill: '#1F2937' }) +
    `</g>`;
}

function graticule(view, lonMin, lonMax, latMin, latMax, opts = {}) {
  let s = '';
  const step = opts.step || 1;
  const color = opts.color || '#D8D3C7';
  const width = opts.width || 0.12;
  for (let lon = Math.ceil(lonMin); lon <= lonMax; lon += step) {
    let d = '';
    for (let lat = latMin; lat <= latMax + 0.001; lat += 0.2) {
      const [x, y] = view.project(lon, Math.min(lat, latMax));
      d += (d ? 'L' : 'M') + fmt(x, 2) + ' ' + fmt(y, 2);
    }
    s += `<path d="${d}" fill="none" stroke="${color}" stroke-width="${width}"/>`;
  }
  for (let lat = Math.ceil(latMin); lat <= latMax; lat += step) {
    let d = '';
    for (let lon = lonMin; lon <= lonMax + 0.001; lon += 0.2) {
      const [x, y] = view.project(Math.min(lon, lonMax), lat);
      d += (d ? 'L' : 'M') + fmt(x, 2) + ' ' + fmt(y, 2);
    }
    s += `<path d="${d}" fill="none" stroke="${color}" stroke-width="${width}"/>`;
  }
  return s;
}

function loadJSON(p) {
  return JSON.parse(fs.readFileSync(p, 'utf8'));
}

function localDate() {
  return new Date().toISOString().slice(0, 10);
}

module.exports = {
  R, LON0, LAT0, SP1, SP2, N, C, RHO0,
  PALETTE, PROV_COLORS, DISTRICT_COLORS, LOCAL_COLORS,
  albers, polygonsOf, geomBounds, boundsOfFeatures, View,
  pathForGeometry, esc, textWidthMm, Labels, text, line, rect,
  scaleBar, northArrow, graticule, loadJSON, fmt, localDate,
};
