// nepal_admin_api website JavaScript

// Theme toggle with localStorage persistence
function initTheme() {
  const toggle = document.getElementById('theme-toggle');
  if (!toggle) return;

  const savedTheme = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const isDark = savedTheme ? savedTheme === 'dark' : prefersDark;

  document.documentElement.classList.toggle('dark', isDark);
  if (savedTheme) {
    document.documentElement.setAttribute('data-theme', savedTheme);
  }

  toggle.addEventListener('click', () => {
    const newDark = !document.documentElement.classList.contains('dark');
    applyTheme(newDark);
  });
  applyTheme(isDark);
}

function applyTheme(isDark) {
  document.documentElement.classList.toggle('dark', isDark);
  localStorage.setItem('theme', isDark ? 'dark' : 'light');
  document.documentElement.setAttribute('data-theme', isDark ? 'dark' : 'light');
  syncThemeColorMeta(isDark);
  // WCAG 2.2 AA (Wave 1.4): the pressed state is announced, not just styled.
  const themeBtn = document.getElementById('theme-toggle');
  if (themeBtn) themeBtn.setAttribute('aria-pressed', String(isDark));
  // Swap theme-sensitive brand imagery (SVG <img> can't read page classes).
  document.querySelectorAll('img[data-logo-light]').forEach((img) => {
    const next = isDark ? img.dataset.logoDark : img.dataset.logoLight;
    if (next && img.getAttribute('src') !== next) img.setAttribute('src', next);
  });
}

function syncThemeColorMeta(isDark) {
  let meta = document.querySelector('meta[name="theme-color"]:not([media])');
  if (!meta) {
    meta = document.createElement('meta');
    meta.setAttribute('name', 'theme-color');
    document.head.appendChild(meta);
  }
  meta.setAttribute('content', isDark ? '#0f172a' : '#ffffff');
}

// Mobile navigation (hamburger): toggle panel, close on link/Escape.
function initNav() {
  const toggle = document.querySelector('.nav-toggle');
  const menu = document.getElementById('nav-menu');
  if (!toggle || !menu) return;
  const setOpen = (open) => {
    toggle.setAttribute('aria-expanded', String(open));
    menu.classList.toggle('open', open);
  };
  toggle.addEventListener('click', () => {
    setOpen(toggle.getAttribute('aria-expanded') !== 'true');
  });
  menu.querySelectorAll('a').forEach((a) => {
    a.addEventListener('click', () => setOpen(false));
  });
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      setOpen(false);
      toggle.blur();
    }
  });
  document.addEventListener('click', (e) => {
    if (!menu.classList.contains('open')) return;
    const target = e.target;
    if (target instanceof Node &&
        !menu.contains(target) &&
        !toggle.contains(target)) {
      setOpen(false);
    }
  });
}

// Toast notification
function showToast(message) {
  const existing = document.querySelector('.toast');
  if (existing) existing.remove();

  const toast = document.createElement('div');
  toast.className = 'toast';
  // WCAG 2.2 AA (Wave 1.4): clipboard/feedback messages are announced,
  // not just shown — role=status is an implicit polite live region.
  toast.setAttribute('role', 'status');
  toast.textContent = message;
  document.body.appendChild(toast);

  requestAnimationFrame(() => toast.classList.add('show'));

  setTimeout(() => {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 200);
  }, 2000);
}

// Copy code blocks
document.addEventListener('click', (e) => {
  if (e.target.matches('.copy-btn')) {
    const codeBlock = e.target.closest('.code-block');
    const code = codeBlock.querySelector('code').textContent;

    navigator.clipboard.writeText(code).then(() => {
      const originalText = e.target.textContent;
      e.target.textContent = 'Copied!';
      e.target.style.background = 'var(--color-success)';
      e.target.style.color = 'white';
      e.target.style.borderColor = 'var(--color-success)';

      setTimeout(() => {
        e.target.textContent = originalText;
        e.target.style.background = '';
        e.target.style.color = '';
        e.target.style.borderColor = '';
      }, 1500);

      showToast('Code copied to clipboard');
    }).catch(() => {
      showToast('Failed to copy');
    });
  }
});

// Active nav highlighting
const currentPage = window.location.pathname.split('/').pop() || 'index.html';
document.querySelectorAll('.nav-link').forEach(link => {
  if (link.getAttribute('href') === currentPage) {
    link.classList.add('active');
  }
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function(e) {
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      e.preventDefault();
      // WCAG 2.2 AA (Wave 1.4): reduced-motion users get instant jumps,
      // consistent with focusMarker() and initHeaderScroll().
      const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
      target.scrollIntoView({ behavior: reduced ? 'auto' : 'smooth', block: 'start' });
    }
  });
});

// Explicit type metadata — never derive CSS classes via chained
// string replaces (that produced unstyled `type-ruralmun` /
/// `type-submetro` chips for rural + sub-metro rows).
const TYPE_META = {
  metropolitan: { cls: 'metro', label: 'Metro', full: 'Metropolitan City' },
  subMetropolitan: { cls: 'sub', label: 'Sub-Metro', full: 'Sub-Metropolitan City' },
  municipality: { cls: 'mun', label: 'Municipality', full: 'Municipality' },
  ruralMunicipality: { cls: 'rural', label: 'Rural', full: 'Rural Municipality' },
};

function typeBadge(type) {
  const meta = TYPE_META[type] || { cls: 'unknown', label: type, full: type };
  return `<span class="type-badge type-${meta.cls}" title="${escapeHtmlAttr(meta.full)}">${escapeHtml(meta.label)}</span>`;
}

// Bilingual label: English plus the Devanagari name when the record has one.
// The separator is only added when there IS a second script, so a record
// without a Devanagari name renders cleanly instead of leaving a dangling "·".
function bilingualName(item) {
  const en = escapeHtml(item.name);
  const ne = item.nameNe ? escapeHtml(item.nameNe) : '';
  return ne ? `${en}<span class="name-ne" lang="ne">${ne}</span>` : en;
}

// CBS code confidence, as three distinct states rather than two.
//   verified     — doubly-attested (postal-2025 + CBS roster)
//   singleSource — one attestation from the CBS roster; usable for joins
//   unverified   — no defensible code
function confidenceMeta(item) {
  const tier = item.cbsCodeConfidence
    || (item.cbsCodeVerified ? 'verified' : (item.cbsCode != null ? 'singleSource' : 'unverified'));
  switch (tier) {
    case 'verified':
      return { cls: 'verified', label: '✓ Verified', full: 'Doubly-attested: the postal-2025 list and the CBS roster name the same code' };
    case 'singleSource':
      return { cls: 'single-source', label: '~ Single', full: 'One attestation from the CBS roster only. Usable for joins, but not doubly-attested' };
    default:
      return { cls: 'unverified', label: '— None', full: 'No defensible code. Left empty on purpose rather than guessed' };
  }
}

function tierBadge(item) {
  const meta = confidenceMeta(item);
  return `<span class="${meta.cls}" title="${escapeHtmlAttr(meta.full)}">${escapeHtml(meta.label)}</span>`;
}

// Explorer functionality (if on explorer page)
if (document.querySelector('.explorer-table')) {
  initExplorer();
}

function initExplorer() {
  const searchInput = document.getElementById('search-input');
  const provinceFilter = document.getElementById('province-filter');
  const districtFilter = document.getElementById('district-filter');
  const typeFilter = document.getElementById('type-filter');
  const tableBody = document.querySelector('.explorer-table tbody');
  const statsEl = document.querySelector('.explorer-stats');
  const paginationEl = document.querySelector('.pagination');

  let allData = [];
  let filteredData = [];
  let currentPage = 1;
  const pageSize = 25;
  // Versioned URL busts stale CDN/browser caches after deploys.
  // Bump when data.json shape changes.
  const DATA_URL = 'data.json?v=4';

  // Loading skeleton (Wave 3 PR B): the table is born empty while
  // data.json loads; give waiting eyes the final shape (8 columns,
  // page-sized rows, muted pulse) instead of a blank panel. Replaced
  // whole by the first renderTable/error; rows are aria-hidden so
  // screen readers never hear "loading"; the stats strip stays empty
  // (it is a live region — announcing a skeleton would be noise).
  renderTableSkeleton();

  function renderTableSkeleton() {
    const widths = ['62', '34', '48', '44', '58', '44', '48', '32'];
    let html = '';
    for (let r = 0; r < 10; r++) {
      html += '<tr class="skeleton-row" aria-hidden="true">';
      for (const w of widths) {
        html += '<td><span class="skeleton" style="width:' + w + '%"></span></td>';
      }
      html += '</tr>';
    }
    tableBody.innerHTML = html;
  }

  // The elevation metric and its popups ride a separate lazy artifact;
  // kick the fetch off early so bands are usually ready before a
  // visitor ever switches the figure. Wave 4-C: under Save-Data the
  // prefetch waits until the figure is actually picked (setMapMetric
  // awaits the same memoized promise — nothing is lost, only the
  // eager copy is skipped).
  if (!SAVE_DATA) ensureDistrictElevation();

  // Load data
  fetch(DATA_URL)
    .then(res => {
      if (!res.ok) {
        throw new Error(`HTTP ${res.status} loading ${DATA_URL}`);
      }
      return res.json();
    })
    .then(data => {
      if (!Array.isArray(data)) {
        throw new Error('data.json did not parse to an array');
      }
      allData = data;
      filteredData = [...data];
      window.__explorerByCbs = (cbs) =>
        allData.find(d => String(d.cbsCode) === String(cbs)) || null;
      // Choropleth boundary join needs the full unfiltered dataset.
      window.__explorerAll = () => allData;
      populateFilters();
      applyDeepLinkState();
      applyFilters();
    })
    .catch(err => {
      console.error('Failed to load data:', err);
      showLoadError(err);
    });

  function showLoadError(err) {
    const detail = (err && err.message) ? err.message : String(err);
    tableBody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 48px;">` +
      `<div style="color: var(--color-text); font-weight: 600; margin-bottom: 8px;">Could not load dataset</div>` +
      `<div style="color: var(--color-text-muted); font-size: 0.875rem; margin-bottom: 16px;"><code>${escapeHtml(detail)}</code></div>` +
      `<button class="btn btn-secondary btn-sm" id="retry-load">Retry</button>` +
      `</td></tr>`;
    const retry = document.getElementById('retry-load');
    if (retry) {
      retry.addEventListener('click', () => window.location.reload());
    }
    const status = document.getElementById('map-status');
    if (status) status.textContent = `Data failed to load (${detail}) — map unavailable.`;
  }

  function populateFilters() {
    const provinces = [...new Set(allData.map(d => d.province))].sort();
    const districts = [...new Set(allData.map(d => d.district))].sort();
    const types = [...new Set(allData.map(d => d.type))].sort();

    provinceFilter.innerHTML = '<option value="">All Provinces</option>' +
      provinces.map(p => `<option value="${p}">${p}</option>`).join('');
    districtFilter.innerHTML = '<option value="">All Districts</option>' +
      districts.map(d => `<option value="${d}">${d}</option>`).join('');
    typeFilter.innerHTML = '<option value="">All Types</option>' +
      types.map(t => {
        const label = (typeof TYPE_META !== 'undefined' && TYPE_META[t]) ? TYPE_META[t].label : t;
        return `<option value="${t}">${label}</option>`;
      }).join('');
  }

  // ---- Deep links: the URL is the shareable explorer state ----
  // Landing on explorer.html?q=...&province=...&district=...&type=...
  // &metric=... applies those values as the initial filter state, and
  // every filter change rewrites the address bar via
  // history.replaceState (no history spam), so "copy the URL" always
  // shares the exact current view. Unmanaged params (e.g. ?cbs= for the
  // map-focus deep link) are preserved, never dropped.
  const MANAGED_PARAMS = ['q', 'province', 'district', 'type', 'metric'];

  function setSelectValue(sel, value) {
    if (!sel || value == null) return;
    const opts = sel.options ? Array.from(sel.options) : [];
    if (opts.some(o => o.value === value)) sel.value = value;
  }

  function applyDeepLinkState() {
    const params = new URLSearchParams(window.location.search || '');
    searchInput.value = params.get('q') || '';
    setSelectValue(provinceFilter, params.get('province'));
    setSelectValue(districtFilter, params.get('district'));
    setSelectValue(typeFilter, params.get('type'));
    const metricSel = document.getElementById('metric-filter');
    const metric = params.get('metric');
    if (metric && metricSel) {
      setSelectValue(metricSel, metric);
      if (metricSel.value === metric) setMapMetric(metric);
    }
  }

  function syncUrl() {
    // Guarded: the smoke harness stubs window without history, and any
    // environment without replaceState degrades silently (the URL just
    // stays as-is) instead of throwing inside the render path.
    if (!window.history || typeof window.history.replaceState !== 'function') return;
    const params = new URLSearchParams(window.location.search || '');
    MANAGED_PARAMS.forEach(p => params.delete(p));
    const q = searchInput.value.trim();
    if (q) params.set('q', q);
    if (provinceFilter.value) params.set('province', provinceFilter.value);
    if (districtFilter.value) params.set('district', districtFilter.value);
    if (typeFilter.value) params.set('type', typeFilter.value);
    if (typeof _mapMetric !== 'undefined' && _mapMetric && _mapMetric !== 'type') {
      params.set('metric', _mapMetric);
    }
    const qs = params.toString();
    const url = window.location.pathname + (qs ? '?' + qs : '') + (window.location.hash || '');
    window.history.replaceState(null, '', url);
  }

  function applyFilters() {
    const search = searchInput.value.toLowerCase().trim();
    const province = provinceFilter.value;
    const district = districtFilter.value;
    const type = typeFilter.value;

    filteredData = allData.filter(item => {
      // Search both scripts: an English or Devanagari query matches either
      // name, so the explorer is usable in both languages.
      const matchesSearch = !search ||
        item.name.toLowerCase().includes(search) ||
        (item.nameNe && item.nameNe.toLowerCase().includes(search)) ||
        item.district.toLowerCase().includes(search) ||
        (item.districtNe && item.districtNe.toLowerCase().includes(search)) ||
        item.province.toLowerCase().includes(search);
      const matchesProvince = !province || item.province === province;
      const matchesDistrict = !district || item.district === district;
      const matchesType = !type || item.type === type;
      return matchesSearch && matchesProvince && matchesDistrict && matchesType;
    });

    currentPage = 1;
    render();
    syncUrl();
  }

  function render() {
    const start = (currentPage - 1) * pageSize;
    const end = start + pageSize;
    const pageData = filteredData.slice(start, end);

    // Update stats. Code confidence is three-state, not two: a
    // single-source code is attested (usable for joins) but not
    // doubly-attested, and collapsing the two would overstate the gap.
    const doubled = filteredData.filter(d => d.cbsCodeConfidence === 'verified').length;
    const single = filteredData.filter(d => d.cbsCodeConfidence === 'singleSource').length;
    const uncoded = filteredData.length - doubled - single;
    const mapped = filteredData.filter(d => d.lat != null && d.lng != null).length;
    statsEl.innerHTML = `
      <span>Total: <strong>${filteredData.length}</strong></span>
      <span>Coded: <strong>${doubled + single}</strong></span>
      <span>Verified: <strong>${doubled}</strong></span>
      <span>Single-source: <strong>${single}</strong></span>
      <span>No code: <strong>${uncoded}</strong></span>
      <span>Mapped: <strong>${mapped}</strong></span>
    `;
    syncMap(filteredData);

    // Render table — guarded so a single bad record can never wipe
    // the stats/map above. Bad rows are skipped with a console warning.
    try {
      renderTable(pageData);
    } catch (err) {
      console.error('Table render failed:', err);
      tableBody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding: 48px;">` +
        `<div style="color: var(--color-text); font-weight: 600; margin-bottom: 8px;">Table failed to render</div>` +
        `<div style="color: var(--color-text-muted); font-size: 0.875rem;"><code>${escapeHtml((err && err.message) || String(err))}</code> — stats and map above are unaffected.</div>` +
        `</td></tr>`;
    }
  function renderTable(pageData) {
    if (pageData.length === 0) {
      // Empty state (Wave 3 PR B): say it, explain it, offer the way
      // out — a plain "No matching records" cell leaves the visitor
      // stuck with the filters that caused it.
      tableBody.innerHTML = `<tr><td colspan="8" class="empty-state-cell">
        <div class="empty-state-title">No matching records</div>
        <div class="empty-state-hint">Search matches English and देवनागरी names — try fewer letters, or loosen a filter.</div>
        <button class="btn btn-secondary btn-sm" id="reset-filters" type="button">Reset filters</button>
      </td></tr>`;
      const reset = document.getElementById('reset-filters');
      if (reset) {
        reset.addEventListener('click', () => {
          searchInput.value = '';
          provinceFilter.value = '';
          districtFilter.value = '';
          typeFilter.value = '';
          applyFilters();
        });
      }
    } else {
      tableBody.innerHTML = pageData.map(item => `
        <tr data-cbs="${item.cbsCode ?? ''}" data-lat="${item.lat ?? ''}" data-lng="${item.lng ?? ''}" data-name="${escapeHtml(item.name)}" tabindex="0" title="${item.lat != null ? 'Click to locate on map' : 'No coordinates available'}">
          <td>${bilingualName(item)}</td>
          <td>${typeBadge(item.type)}</td>
          <td>${item.districtNe ? `${escapeHtml(item.district)}<span class="name-ne" lang="ne">${escapeHtml(item.districtNe)}</span>` : escapeHtml(item.district)}</td>
          <td>${escapeHtml(item.province)}</td>
          <td>${item.cbsCode !== null ? `<code>${item.cbsCode}</code>` : '<span class="unverified">—</span>'}</td>
          <td>${tierBadge(item)}</td>
          <td>${item.isoCode ? `<code>${item.isoCode}</code>` : '—'}</td>
          <td>${item.wards != null ? `${item.wards}` : '<span class="unverified">—</span>'}</td>
        </tr>
      `).join('');
      // Row → map: click a mapped row to fly to its marker.
      tableBody.querySelectorAll('tr[data-lat]').forEach(row => {
        if (!row.dataset.lat || !row.dataset.lng) return;
        const go = () => focusMarker(parseFloat(row.dataset.lat), parseFloat(row.dataset.lng), row.dataset.name);
        row.style.cursor = 'pointer';
        row.addEventListener('click', go);
        row.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); go(); }
        });
      });
    }
  }
    const totalPages = Math.ceil(filteredData.length / pageSize);
    if (totalPages <= 1) {
      paginationEl.innerHTML = '';
      return;
    }

    let paginationHtml = '';
    if (currentPage > 1) {
      paginationHtml += `<button data-page="${currentPage - 1}">‹ Prev</button>`;
    }

    const maxVisible = 5;
    let startPage = Math.max(1, currentPage - Math.floor(maxVisible / 2));
    let endPage = Math.min(totalPages, startPage + maxVisible - 1);

    if (endPage - startPage + 1 < maxVisible) {
      startPage = Math.max(1, endPage - maxVisible + 1);
    }

    if (startPage > 1) {
      paginationHtml += `<button data-page="1">1</button>`;
      if (startPage > 2) paginationHtml += `<span class="ellipsis">…</span>`;
    }

    for (let i = startPage; i <= endPage; i++) {
      paginationHtml += `<button data-page="${i}" class="${i === currentPage ? 'active' : ''}"${i === currentPage ? ' aria-current="page"' : ''}>${i}</button>`;
    }

    if (endPage < totalPages) {
      if (endPage < totalPages - 1) paginationHtml += `<span class="ellipsis">…</span>`;
      paginationHtml += `<button data-page="${totalPages}">${totalPages}</button>`;
    }

    if (currentPage < totalPages) {
      paginationHtml += `<button data-page="${currentPage + 1}">Next ›</button>`;
    }

    paginationEl.innerHTML = paginationHtml;

    paginationEl.querySelectorAll('button[data-page]').forEach(btn => {
      btn.addEventListener('click', () => {
        currentPage = parseInt(btn.dataset.page, 10);
        render();
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });
    });
  }

  // Event listeners (escapeHtml is module-scope; see above)
  searchInput.addEventListener('input', debounce(applyFilters, 200));
  provinceFilter.addEventListener('change', applyFilters);
  districtFilter.addEventListener('change', applyFilters);
  typeFilter.addEventListener('change', applyFilters);

  // Figure-shown-on-the-map metric selector (wards / type / cbs / dots).
  const metricFilter = document.getElementById('metric-filter');
  if (metricFilter) {
    metricFilter.addEventListener('change', () => {
      setMapMetric(metricFilter.value);
      render();
      syncUrl();
    });
  }

  // "Share view": copies the deep link to the exact current view.
  const shareBtn = document.getElementById('share-view');
  if (shareBtn) {
    shareBtn.addEventListener('click', () => {
      const url = window.location.href;
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(url).then(
          () => showToast('Link copied — share this exact view'),
          () => showToast('Copy failed — copy the address bar URL')
        );
      } else {
        showToast('Copy this page URL from the address bar');
      }
    });
  }
}

function debounce(fn, delay) {
  let timeoutId;
  return (...args) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => fn.apply(null, args), delay);
  };
}

// ---- Centroid map (MapLibre GL + OSM Standard, no API key) ----
// Single tiles object so the basemap source is defined in exactly one place.
const MAP_TILES = {
  url: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  maxZoom: 19,
  attribution: '© <a href="https://www.openstreetmap.org/copyright" target="_blank" rel="noopener">OpenStreetMap</a> contributors',
};
// Type palette — one legend source: read live from the --map-* tokens in
// brand-tokens.css (v3) so dots, choropleth and page legend never drift
// apart. Falls back to the v3 hexes when CSS custom properties are
// unreachable (offline smoke harness, ancient browsers):
//   metro #B91C1C · sub-metro #D97706 · municipality #1D4ED8 · rural #15803D
function cssColor(name, fallback) {
  try {
    const v = getComputedStyle(document.documentElement).getPropertyValue(name).trim();
    return v || fallback;
  } catch (e) {
    return fallback;
  }
}
const TYPE_COLORS = {
  metropolitan: cssColor('--map-metro', '#B91C1C'),
  subMetropolitan: cssColor('--map-sub', '#D97706'),
  municipality: cssColor('--map-mun', '#1D4ED8'),
  ruralMunicipality: cssColor('--map-rural', '#15803D'),
};
let _map = null;
let _mapLibreReady = null; // engine script/css load promise
let _mapReady = null;      // engine + style load promise
// Save-Data (Wave 4-C): honor the OS/browser data-saver switch. Checked
// once, honored where a fetch or animation is optional polish — never for
// the data the page exists to show.
var SAVE_DATA = (function () {
  try {
    var c = navigator.connection;
    return !!(c && c.saveData);
  } catch (e) {
    return false;
  }
})();

// Wave R1 (map experience leap): MapLibre GL JS, pinned v5.6.0 — the
// last UMD build (v6 ships ESM-only, unusable from a plain script tag).
// Leaflet + markercluster retire: one engine, native GeoJSON clustering,
// same OSM raster basemap, same lazy arm, same overlay registry.
function loadMapLibre() {
  if (_mapLibreReady) return _mapLibreReady;
  _mapLibreReady = new Promise((resolve, reject) => {
    if (window.maplibregl) { resolve(); return; }
    const css = document.createElement('link');
    css.rel = 'stylesheet';
    css.href = 'https://unpkg.com/maplibre-gl@5.6.0/dist/maplibre-gl.css';
    document.head.appendChild(css);
    const s = document.createElement('script');
    s.src = 'https://unpkg.com/maplibre-gl@5.6.0/dist/maplibre-gl.js';
    s.defer = true;
    s.onload = () => resolve();
    s.onerror = () => reject(new Error('maplibre-gl failed to load'));
    document.head.appendChild(s);
  });
  return _mapLibreReady;
}

function emptyFC() {
  return { type: 'FeatureCollection', features: [] };
}

// Hover tooltip (the Leaflet-era .palika-tip) and the click popup both
// build at event time from source data. queryRenderedFeatures returns
// COPIES of the features — the __key property is the handle back to the
// joined row, so popups stay live: the elevation sentence lands even
// when its fetch resolves after render.
var _mapTipEl = null;
function mapTip() {
  if (_mapTipEl) return _mapTipEl;
  _mapTipEl = document.createElement('div');
  _mapTipEl.className = 'palika-tip';
  _mapTipEl.setAttribute('role', 'tooltip');
  _mapTipEl.style.display = 'none';
  const host = (_map && _map.getContainer()) || document.body;
  host.appendChild(_mapTipEl);
  return _mapTipEl;
}

function showMapTip(html, point) {
  const tip = mapTip();
  tip.innerHTML = html;
  tip.style.display = 'block';
  const host = _map.getContainer();
  const left = Math.min(point.x + 14, host.clientWidth - tip.offsetWidth - 8);
  tip.style.left = Math.max(8, left) + 'px';
  tip.style.top = Math.max(8, point.y - tip.offsetHeight - 12) + 'px';
}

function hideMapTip() {
  if (_mapTipEl) _mapTipEl.style.display = 'none';
}

var _mapPopup = null;
function showMapPopup(lngLat, html) {
  const maplibregl = window.maplibregl;
  if (!maplibregl || !_map) return;
  if (_mapPopup) { _mapPopup.remove(); _mapPopup = null; }
  _mapPopup = new maplibregl.Popup({ closeButton: true, closeOnClick: true, maxWidth: '320px' })
    .setLngLat(lngLat)
    .setHTML(html)
    .addTo(_map);
}

// Layer z-order contract: choropleth on the basemap, overlays frame it,
// dots and clusters ride on top. The dots layers are born at map load,
// so every overlay layer inserts before 'dots-clusters'.
function ensureMap() {
  const el = document.getElementById('map');
  if (!el || _mapReady) return _mapReady || Promise.resolve(_map);
  _mapReady = loadMapLibre().then(() => new Promise((resolve) => {
    const maplibregl = window.maplibregl;
    _map = new maplibregl.Map({
      container: 'map',
      style: {
        version: 8,
        sources: {
          osm: {
            type: 'raster',
            tiles: [MAP_TILES.url],
            tileSize: 256,
            maxzoom: MAP_TILES.maxZoom,
            attribution: MAP_TILES.attribution,
          },
        },
        layers: [{
          id: 'osm-tiles',
          type: 'raster',
          source: 'osm',
          minzoom: 4,
          maxzoom: MAP_TILES.maxZoom,
        }],
      },
      center: [84.12, 28.39],
      zoom: 7,
      attributionControl: { compact: true },
    });
    // Same UX law as the Leaflet era: the wheel only zooms once the map
    // canvas has focus — the page never hijacks scrolling on the way
    // past. (Tab to the map first.)
    _map.scrollZoom.disable();
    _map.getCanvas().addEventListener('focus', () => _map.scrollZoom.enable());
    _map.getCanvas().addEventListener('blur', () => _map.scrollZoom.disable());
    _map.on('error', (e) => { console.error('MapLibre:', e && e.error); });
    _map.on('load', () => {
      _map.addSource('palika', { type: 'geojson', data: emptyFC() });
      _map.addSource('dots', {
        type: 'geojson', data: emptyFC(),
        cluster: true, clusterMaxZoom: 12, clusterRadius: 48,
      });
      _map.addLayer({
        id: 'palika-fill', type: 'fill', source: 'palika',
        paint: {
          'fill-color': ['get', '__fill'],
          'fill-opacity': ['get', '__fo'],
          'fill-outline-color': ['get', '__stroke'],
        },
      });
      _map.addLayer({
        id: 'palika-line', type: 'line', source: 'palika',
        paint: { 'line-color': ['get', '__stroke'], 'line-width': ['get', '__sw'] },
      });
      _map.addLayer({
        id: 'dots-clusters', type: 'circle', source: 'dots',
        filter: ['has', 'point_count'],
        paint: {
          'circle-color': '#94a3b8', 'circle-opacity': 0.9,
          'circle-stroke-width': 2, 'circle-stroke-color': '#ffffff',
          'circle-radius': ['step', ['get', 'point_count'], 12, 10, 16, 25, 20, 50, 26],
        },
      });
      _map.addLayer({
        id: 'dots-points', type: 'circle', source: 'dots',
        filter: ['!', ['has', 'point_count']],
        paint: {
          'circle-radius': ['get', 'r'],
          'circle-color': ['get', 'color'],
          'circle-opacity': ['get', 'fo'],
          'circle-stroke-width': 2, 'circle-stroke-color': ['get', 'color'],
        },
      });
      wireMapEvents();
      initMapOverlays();
      initBoundaryDetailToggle();
      const status = document.getElementById('map-status');
      if (status) status.textContent = '';
      // Deep link: explorer.html?cbs=31304
      const cbs = new URLSearchParams(window.location.search).get('cbs');
      if (cbs && window.__explorerByCbs) {
        const hit = window.__explorerByCbs(cbs);
        if (hit && hit.lat != null) focusMarker(hit.lat, hit.lng, hit.name);
      }
      resolve(_map);
    });
  })).catch((err) => {
    console.error('Map failed to load:', err);
    _mapReady = null;
    const status = document.getElementById('map-status');
    if (status) status.textContent = 'Map unavailable offline — table still works.';
    return null;
  });
  return _mapReady;
}

function wireMapEvents() {
  // Choropleth boundaries: hover tooltip, click popup, pointer cursor.
  _map.on('mousemove', 'palika-fill', (e) => {
    const f = e.features && e.features[0];
    if (!f) return;
    const row = f.properties.__key ? _rowByKey.get(f.properties.__key) : null;
    showMapTip(boundaryTip({ properties: f.properties, __row: row }), e.point);
    _map.getCanvas().style.cursor = 'pointer';
  });
  _map.on('mouseleave', 'palika-fill', () => {
    hideMapTip();
    _map.getCanvas().style.cursor = '';
  });
  _map.on('click', 'palika-fill', (e) => {
    const f = e.features && e.features[0];
    if (!f) return;
    const row = f.properties.__key ? _rowByKey.get(f.properties.__key) : null;
    if (row) {
      showMapPopup(e.lngLat, itemPopupHtml(row));
    } else {
      showMapPopup(e.lngLat,
        '<strong>' + escapeHtmlAttr(f.properties.nameEn || 'Palika') + '</strong>' +
        '<br><span style="color:#64748b;font-size:12px">Boundary not matched to a table row</span>');
    }
  });
  // Centroid dots: click popup, pointer cursor.
  _map.on('click', 'dots-points', (e) => {
    const f = e.features && e.features[0];
    if (!f) return;
    const row = f.properties.__key ? _rowByKey.get(f.properties.__key) : null;
    if (row) showMapPopup(e.lngLat, itemPopupHtml(row));
  });
  _map.on('mousemove', 'dots-points', () => { _map.getCanvas().style.cursor = 'pointer'; });
  _map.on('mouseleave', 'dots-points', () => { _map.getCanvas().style.cursor = ''; });
  // Clusters: expand on click, count on hover.
  _map.on('click', 'dots-clusters', (e) => {
    const f = e.features && e.features[0];
    if (!f) return;
    _map.getSource('dots').getClusterExpansionZoom(f.properties.cluster_id)
      .then((z) => _map.easeTo({ center: f.geometry.coordinates, zoom: z }))
      .catch(() => { /* keep the current view */ });
  });
  _map.on('mousemove', 'dots-clusters', (e) => {
    const f = e.features && e.features[0];
    if (!f) return;
    showMapTip('<strong>' + f.properties.point_count + ' palikas</strong>', e.point);
    _map.getCanvas().style.cursor = 'pointer';
  });
  _map.on('mouseleave', 'dots-clusters', () => {
    hideMapTip();
    _map.getCanvas().style.cursor = '';
  });
}

// Bounding box of a FeatureCollection, as [[west, south], [east, north]].
function boundsOf(fc) {
  let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
  function walk(coords) {
    if (typeof coords[0] === 'number') {
      if (coords[0] < minX) minX = coords[0];
      if (coords[0] > maxX) maxX = coords[0];
      if (coords[1] < minY) minY = coords[1];
      if (coords[1] > maxY) maxY = coords[1];
      return;
    }
    for (const c of coords) walk(c);
  }
  for (const f of fc.features) {
    if (f.geometry) walk(f.geometry.coordinates);
  }
  if (minX === Infinity) throw new Error('no geometry to bound');
  return [[minX, minY], [maxX, maxY]];
}

function markerColor(item) {
  return TYPE_COLORS[item.type] || '#78716C';
}

// ---- Figure shown on the map: palika boundary choropleth ----
// Boundary geometry: nepali-geo-pro-max (MIT) at a pinned commit, served
// same-origin first from the vendored docs/palika-boundaries.geojson
// (generated by tool/generate_palika_boundaries.dart - regenerated from
// the pinned source, never hand-edited), with the pinned CDN copies as
// fallbacks. If boundaries cannot load, the selector falls back to the
// dot map, so the explorer always keeps a working figure.
var PALIKA_BOUNDARIES_URLS = [
  'palika-boundaries.geojson?v=1',
  'https://cdn.jsdelivr.net/gh/l3lackcurtains/nepali-geo-pro-max@117fd0f3d2dabae3bd86bfe9e4c57098ffe56669/src/geo/local-units.geo.ts',
  'https://raw.githubusercontent.com/l3lackcurtains/nepali-geo-pro-max/117fd0f3d2dabae3bd86bfe9e4c57098ffe56669/src/geo/local-units.geo.ts',
];
// Higher-detail variant (~77k vertices, ~3 MB) for the optional "High detail"
// toggle. Off by default: the simplified layer (16k vertices) keeps the
// initial load fast. Loading this swaps the figure's boundary layer.
var PALIKA_BOUNDARIES_HIGH_URLS = [
  'palika-boundaries-highres-mid.geojson?v=1',
];
// data.json rows carry district NAMES; boundary properties carry districtId
// keys (P#.D##). This map bridges the two. Derived from the boundary data
// itself (unique-name votes per districtId, cross-checked against row
// isoCode provinces): 77/77 districts, zero mismatches.
var DISTRICT_ID_BY_NAME = {
  Achham: 'P7.D01', Arghakhanchi: 'P5.D01', Baglung: 'P4.D01', Baitadi: 'P7.D02',
  Bajhang: 'P7.D03', Bajura: 'P7.D04', Banke: 'P5.D02', Bara: 'P2.D01',
  Bhaktapur: 'P3.D01', Bhojpur: 'P1.D01', Chitwan: 'P3.D02', Dadeldhura: 'P7.D05',
  Dailekh: 'P6.D01', Dang: 'P5.D04', Darchula: 'P7.D06', Dhading: 'P3.D03',
  Dhankuta: 'P1.D02', Dhanusha: 'P2.D02', Dolakha: 'P3.D04', Dolpa: 'P6.D02',
  Doti: 'P7.D07', Gorkha: 'P4.D02', Gulmi: 'P5.D06', Humla: 'P6.D03',
  Ilam: 'P1.D03', Jajarkot: 'P6.D04', Jhapa: 'P1.D04', Jumla: 'P6.D05',
  Kailali: 'P7.D08', Kalikot: 'P6.D06', Kanchanpur: 'P7.D09', Kapilvastu: 'P5.D07',
  Kaski: 'P4.D03', Kathmandu: 'P3.D05', Kavrepalanchok: 'P3.D06', Khotang: 'P1.D05',
  Lalitpur: 'P3.D07', Lamjung: 'P4.D04', Mahottari: 'P2.D03', Makwanpur: 'P3.D08',
  Manang: 'P4.D05', Morang: 'P1.D06', Mugu: 'P6.D07', Mustang: 'P4.D06',
  Myagdi: 'P4.D07', Nawalpur: 'P4.D08', Nuwakot: 'P3.D09', Okhaldhunga: 'P1.D07',
  Palpa: 'P5.D08', Panchthar: 'P1.D08', 'Parasi (Nawalparasi West)': 'P5.D09',
  Parbat: 'P4.D09', Parsa: 'P2.D04', Pyuthan: 'P5.D10', Ramechhap: 'P3.D10',
  Rasuwa: 'P3.D11', Rautahat: 'P2.D05', Rolpa: 'P5.D11', 'Rukum East': 'P5.D05',
  'Rukum West': 'P6.D10', Rupandehi: 'P5.D12', Salyan: 'P6.D08',
  Sankhuwasabha: 'P1.D09', Saptari: 'P2.D06', Sarlahi: 'P2.D07',
  Sindhuli: 'P3.D12', Sindhupalchok: 'P3.D13', Siraha: 'P2.D08',
  Solukhumbu: 'P1.D10', Sunsari: 'P1.D11', Surkhet: 'P6.D09', Syangja: 'P4.D10',
  Tanahun: 'P4.D11', Taplejung: 'P1.D12', Terhathum: 'P1.D13', Udayapur: 'P1.D14',
};
// What the figure encodes. Wards use the v3 blue ramp (brand green is
// 1.97:1 on white — fill only, never data-by-text). CBS confidence follows
// the trust rules: verified is scoped blue, single-source neutral stone,
// unverified amber.
var MAP_METRICS = {
  wards: {
    label: 'Wards per local level',
    entries: [
      { label: '5–9', color: '#DBEAFE' },
      { label: '10–14', color: '#93C5FD' },
      { label: '15–19', color: '#3B82F6' },
      { label: '20–24', color: '#1D4ED8' },
      { label: '25+', color: '#1E3A8A' },
      { label: 'n/a', color: '#E7E5E4' },
    ],
  },
  type: {
    label: 'Local level type',
    // Single source: same palette object the dots and the table use.
    entries: [
      { label: 'Metro', color: TYPE_COLORS.metropolitan },
      { label: 'Sub-metro', color: TYPE_COLORS.subMetropolitan },
      { label: 'Municipality', color: TYPE_COLORS.municipality },
      { label: 'Rural', color: TYPE_COLORS.ruralMunicipality },
    ],
  },
  cbs: {
    label: 'CBS code confidence',
    entries: [
      { label: '✓ Verified', color: '#1D4ED8' },
      { label: '~ Single source', color: '#A8A29E' },
      { label: '— No code', color: '#D97706' },
    ],
  },
  elevation: {
    // Terrain band ramp (amber 100 → 800): Terai yellow to high-Himalaya
    // brown, one district-wide figure per palika (its district's mean).
    label: 'District mean elevation (GLO-30)',
    entries: [
      { label: '< 500 m', color: '#FDE68A' },
      { label: '500–1,500 m', color: '#FCD34D' },
      { label: '1,500–2,500 m', color: '#F59E0B' },
      { label: '2,500–3,500 m', color: '#B45309' },
      { label: '3,500+ m', color: '#7C2D12' },
      { label: 'n/a', color: '#E7E5E4' },
    ],
  },
};
var DOTS_LEGEND_HTML =
  '<span class="legend-chip"><i class="dot dot-metro"></i>Metro</span>' +
  '<span class="legend-chip"><i class="dot dot-sub"></i>Sub-metro</span>' +
  '<span class="legend-chip"><i class="dot dot-mun"></i>Municipality</span>' +
  '<span class="legend-chip"><i class="dot dot-rural"></i>Rural</span>' +
  '<span class="legend-chip"><i class="dot dot-unverified"></i>Unverified</span>';
var _mapMetric = 'type';
var _boundaries = null;        // parsed FeatureCollection (753 palikas)
var _boundariesReady = null;   // in-flight load promise
var _boundaryDetailHigh = (localStorage.getItem('boundaryDetail') === 'high');
var _lastMapItems = null;     // last items passed to syncMap, for detail swaps
var _boundaryByKey = null;     // districtId|normName -> feature
var _rowByKey = new Map();    // __key -> row (rendered feature copies need the join back)
var _boundaryDataAdded = false;
var _activeRows = new Set();
var _districtElev = null;      // district -> {elevMin, elevMean, elevMax}
var _districtElevReady = null; // in-flight load promise

// District elevation bands (Copernicus GLO-30-derived, 77 districts):
// a lazy-loaded artifact, fetched only when the terrain metric (or a
// popup that quotes it) is first needed. A failed or malformed fetch
// resolves null and the map degrades to the n/a grey — never an error.
function ensureDistrictElevation() {
  if (_districtElevReady) return _districtElevReady;
  _districtElevReady = fetch('district-elevation.json?v=1')
    .then(function (res) { return res.ok ? res.json() : null; })
    .then(function (data) {
      if (!Array.isArray(data) || !data.length ||
          typeof data[0].elevMean !== 'number') return null;
      var map = {};
      for (var i = 0; i < data.length; i++) {
        map[data[i].district] = data[i];
      }
      _districtElev = map;
      return map;
    })
    .catch(function () { return null; });
  return _districtElevReady;
}

var MAP_OVERLAYS = [
  // K2 — protected areas. The 20 core units on the official DNPWC roster
  // (12 national parks, 6 conservation areas, Koshi Tappu Wildlife
  // Reserve, Dhorpatan Hunting Reserve). Geometry: WDPA (UNEP-WCMC &
  // IUCN) via the WWF Nepal Biodiversity Areas dataset, server-side
  // simplified (~150 m tolerance) and vendored same-origin. Buffer
  // zones, Ramsar sites and post-roster proposals (Bara, Phulchoki)
  // are intentionally out of scope for this phase. Off by default:
  // context on top of the figure, never a competitor to it.
  // K1 — national outline. Nepal's official चुच्चे (chuche) map as
  // published May 2020: includes Kalapani, Lipulekh and Limpiyadhura
  // (Darchula, Sudurpashchim). Geometry shipped unchanged from
  // Acesmndr/nepal-geojson (MIT) — same source family as the palika
  // boundary layer. Off by default, outline-only (no fill) so it
  // frames the figure instead of competing with it. Note: no
  // local-level units exist inside the Kalapani–Lipulekh–Limpiyadhura
  // pocket yet, so the outline intentionally extends beyond the
  // palika layer in the northwest.
  {
    id: 'national-outline',
    label: 'National outline (चुच्चे)',
    urls: ['national-outline.geojson?v=1'],
    enabledByDefault: false,
    style: { color: '#1D4ED8', weight: 1.5, opacity: 0.9, fill: false },
    tooltip: () => 'Nepal — official चुच्चे (chuche) map',
    popup: () =>
      '<strong>Nepal — official चुच्चे map (May 2020)</strong>' +
      '<br>Includes Kalapani · Lipulekh · Limpiyadhura (Darchula)' +
      '<br><span style="color:#64748b;font-size:12px">Geometry: Acesmndr/nepal-geojson (MIT) — shipped unchanged</span>',
  },
  {
    id: 'protected-areas',
    label: 'Protected areas (20)',
    urls: ['protected-areas.geojson?v=1'],
    enabledByDefault: false,
    style: { color: '#4FD166', weight: 1.2, opacity: 0.9, fillColor: '#4FD166', fillOpacity: 0.12 },
    tooltip: (feature) => {
      const p = feature.properties || {};
      let html = '<strong>' + escapeHtmlAttr(p.name || 'Protected area') + '</strong>';
      if (p.desig || p.areaKm2) {
        html += '<br><span style="font-size:11px;color:#64748b">' + escapeHtmlAttr(p.desig || '');
        if (p.areaKm2) html += ' · ' + escapeHtmlAttr(String(p.areaKm2)) + ' km²';
        html += '</span>';
      }
      return html;
    },
    popup: (feature) => {
      const p = feature.properties || {};
      let html = '<strong>' + escapeHtmlAttr(p.name || 'Protected area') + '</strong>';
      html += '<br>' + escapeHtmlAttr(p.desig || '');
      if (p.est) html += ' · est. ' + escapeHtmlAttr(String(p.est));
      if (p.areaKm2) html += '<br>' + escapeHtmlAttr(String(p.areaKm2)) + ' km²';
      if (p.iucn && p.iucn !== 'Not Reported') html += ' · IUCN ' + escapeHtmlAttr(p.iucn);
      html += '<br><span style="color:#64748b;font-size:12px">Boundary: WDPA (UNEP-WCMC &amp; IUCN) via WWF</span>';
      return html;
    },
  },
  // H1 — NH01, the Mahendra (Hulaki) Highway: the DoR's primary
  // east–west corridor, Kakarbhitta (Jhapa) to Bhim Datta (Kanchanpur).
  // Extracted from OSM route relations (ref=NH01) by
  // tool/extract_nh01.cjs, whose structural gates fail the extract
  // loudly (>= 50 member ways, both termini near Kakarbhitta/Bhim Datta,
  // length inside the 800–1,300 km corridor); the vendored artifact's
  // metadata member carries the relation IDs, the exact Overpass
  // queries, the extract date and the ODbL 1.0 attribution. Off by
  // default: an amber line — context, never a competitor to the figure.
  {
    id: 'nh01-highway',
    label: 'Mahendra Highway (NH01)',
    urls: ['nh01-highway.geojson?v=1'],
    enabledByDefault: false,
    style: { color: '#B45309', weight: 2, opacity: 0.85, fill: false },
    tooltip: () => '<strong>NH01 — Mahendra (Hulaki) Highway</strong>',
    popup: () =>
      '<strong>Mahendra Highway (NH01)</strong>' +
      '<br>Kakarbhitta (Jhapa) — Bhim Datta (Kanchanpur) · ~1,047 km' +
      '<br><span style="color:#64748b;font-size:12px">Geometry: OpenStreetMap (ODbL 1.0) — © OpenStreetMap contributors</span>',
  },
  // Wave 3 PR B — district boundaries. All 77 districts from the official
  // portal district boundary export (Survey Department of Nepal /
  // National Geoportal lineage, WGS 84), vendored same-origin as
  // docs/district-boundaries.geojson — the same geometry the Dart
  // package tests against (tool/generate_district_boundaries.dart
  // re-derives lib/src/geo/district_boundaries.dart from it). Off by
  // default: dashed stone lines — administrative context above the
  // figure, never a competitor to it. Tooltips and popups quote the
  // GLO-30 elevation bands when the elevation artifact has landed.
  {
    id: 'district-boundaries',
    label: 'District boundaries (77)',
    urls: ['district-boundaries.geojson?v=1'],
    enabledByDefault: false,
    style: { color: '#57534E', weight: 1.2, opacity: 0.85, fill: false, dashArray: '4 3' },
    tooltip: (feature) => districtBoundaryTip(feature),
    popup: (feature) => districtBoundaryPopup(feature),
  },
];
var _overlayLayers = {};  // id -> { def, layer, loaded, visible, ready }
var _overlaysInited = false;

// ---- Map overlays: context layers above the figure ----
// Overlays (protected areas, the national outline, highways, ...) are
// context, not data: they render in a dedicated pane above the
// choropleth/dots, persist across metric switches, and toggle
// independently. Data PRs append entries to MAP_OVERLAYS and vendor the
// GeoJSON beside palika-boundaries.geojson. Entry shape:
//   { id, label, urls: [same-origin first, then fallbacks],
//     enabledByDefault: bool, style: object | fn(feature) -> path options,
//     tooltip: fn(feature) -> html (pre-escaped), popup: fn(feature) -> html }
// The loader below uses the same fallback-chain pattern as
// PALIKA_BOUNDARIES_URLS; an unfetchable overlay never breaks the map —
// R2 lazy overlays: an unloaded overlay is a checked-away, retryable
// toggle (its fetch re-arms on the next ask), never a boot-time cost.

function setMapMetric(metric) {
  if (metric !== 'dots' && !MAP_METRICS[metric]) return;
  _mapMetric = metric;
  renderMapLegend();
  if (metric === 'elevation') {
    // The bands arrive async; once they land, restyle whatever is on
    // screen so switching metrics never shows a stale n/a grey map.
    ensureDistrictElevation().then(function () {
      if (_mapMetric !== 'elevation') return;
      if (_map && _boundaryDataAdded) restyleBoundaryLayer();
    });
  }
  if (_map && _boundaryDataAdded) restyleBoundaryLayer();
}

// Join keys normalize both scripts: lowercase, fold dashes, keep [a-z0-9]
// and Devanagari, drop official-type suffixes, then collapse spaces so
// "Kumakh Malika" === "Kumakhmalika". Validated against the boundary
// source: 592 name joins + 154 point-in-polygon joins = 746/753.
function normPalikaName(s) {
  return String(s == null ? '' : s).toLowerCase()
    .replace(/[\u2013\u2014]/g, '-')
    .replace(/[^a-z0-9\u0900-\u097F]+/g, ' ')
    .trim()
    .replace(/ (rural municipality|municipality|sub metropolis|sub metropolitan city|metropolitan city|metropolis|gaunpalika|nagarpalika|upamahanagarpalika|mahanagarpalika)$/g, '')
    .replace(/ /g, '');
}

function districtIdFor(item) {
  return DISTRICT_ID_BY_NAME[item.district] || '';
}

function pointInRing(x, y, ring) {
  var inside = false;
  for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    var xi = ring[i][0], yi = ring[i][1];
    var xj = ring[j][0], yj = ring[j][1];
    if (((yi > y) !== (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) inside = !inside;
  }
  return inside;
}

function pointInGeometry(x, y, geom) {
  if (!geom) return false;
  var polys = geom.type === 'Polygon' ? [geom.coordinates]
    : geom.type === 'MultiPolygon' ? geom.coordinates : [];
  for (var p = 0; p < polys.length; p++) {
    var poly = polys[p];
    if (pointInRing(x, y, poly[0])) {
      var inHole = false;
      for (var h = 1; h < poly.length; h++) {
        if (pointInRing(x, y, poly[h])) { inHole = true; break; }
      }
      if (!inHole) return true;
    }
  }
  return false;
}

// Boundary geometry ships either as vendored GeoJSON (same-origin
// palika-boundaries.geojson) or as the pinned TS module (export const
// ... = {...} as const;): try plain JSON first, then for the TS module
// slice the object literal out and strip the trailing commas the TS
// style permits.
function parseBoundaryModule(text) {
  try {
    var asJson = JSON.parse(text);
    if (asJson && asJson.type === 'FeatureCollection' && asJson.features) {
      return asJson;
    }
  } catch (err) {
    // Not JSON - the TS-module path below handles it.
  }
  var eq = text.indexOf('=');
  var start = text.indexOf('{', eq);
  var end = text.lastIndexOf('}');
  if (eq < 0 || start < 0 || end <= start) {
    throw new Error('boundary module shape not recognized');
  }
  return JSON.parse(text.slice(start, end + 1).replace(/,\s*([\]}])/g, '$1'));
}

// Feature copies handed back by queryRenderedFeatures carry properties
// only — __key is the handle back to the joined row at event time.
function stampBoundaryKey(f, row) {
  const p = f.properties || (f.properties = {});
  p.__key = (districtIdFor(row) || '') + '|' + normPalikaName(row.name);
  _rowByKey.set(p.__key, row);
}

function buildBoundaryIndex(rows) {
  if (!_boundaries) return;
  if (!_boundaryByKey) {
    _boundaryByKey = new Map();
    for (const f of _boundaries.features) {
      const p = f.properties || {};
      const key = (p.districtId || '') + '|' + normPalikaName(p.nameEn);
      if (!_boundaryByKey.has(key)) _boundaryByKey.set(key, f);
    }
  }
  // 1) name join within the district
  for (const r of rows) {
    if (r.__feature) continue;
    const f = _boundaryByKey.get((districtIdFor(r) || '') + '|' + normPalikaName(r.name));
    if (f && !f.__row) { r.__feature = f; f.__row = r; stampBoundaryKey(f, r); }
  }
  // 2) centroid-in-own-polygon fallback, same district first
  for (const r of rows) {
    if (r.__feature || r.lat == null || r.lng == null) continue;
    const did = districtIdFor(r) || '';
    let hit = null;
    for (const f of _boundaries.features) {
      if (f.__row) continue;
      if (did && (f.properties || {}).districtId !== did) continue;
      if (pointInGeometry(r.lng, r.lat, f.geometry)) { hit = f; break; }
    }
    if (!hit) {
      for (const f of _boundaries.features) {
        if (f.__row) continue;
        if (pointInGeometry(r.lng, r.lat, f.geometry)) { hit = f; break; }
      }
    }
    if (hit) { r.__feature = hit; hit.__row = r; stampBoundaryKey(hit, r); }
  }
}

function loadBoundaries() {
  if (_boundaries) return Promise.resolve(_boundaries);
  if (_boundariesReady) return _boundariesReady;
  const urls = _boundaryDetailHigh ? PALIKA_BOUNDARIES_HIGH_URLS : PALIKA_BOUNDARIES_URLS;
  _boundariesReady = (async () => {
    let lastErr = null;
    for (const url of urls) {
      try {
        const res = await fetch(url);
        if (!res.ok) throw new Error('HTTP ' + res.status + ' loading boundaries');
        const text = await res.text();
        const fc = parseBoundaryModule(text);
        if (!fc || !Array.isArray(fc.features) || !fc.features.length) {
          throw new Error('boundary payload parsed to 0 features');
        }
        _boundaries = fc;
        return fc;
      } catch (err) {
        lastErr = err;
      }
    }
    _boundariesReady = null;
    throw lastErr || new Error('palika boundaries unavailable');
  })();
  return _boundariesReady;
}

function resetBoundaryState() {
  _boundaries = null;
  _boundariesReady = null;
  _boundaryByKey = null;
  _rowByKey = new Map();
  _boundaryDataAdded = false;
  if (_map && _map.getSource('palika')) _map.getSource('palika').setData(emptyFC());
}

function setBoundaryDetail(high) {
  if (high === _boundaryDetailHigh) return;
  _boundaryDetailHigh = !!high;
  try { localStorage.setItem('boundaryDetail', _boundaryDetailHigh ? 'high' : 'low'); } catch (e) { /* ignore */ }
  resetBoundaryState();
  const items = _lastMapItems || (window.__explorerAll && window.__explorerAll()) || [];
  syncMap(items);
}

// District overlay (Wave 3 PR B): quiet stone lines with bilingual
// tooltips and a popup that quotes the roster (HQ, province) plus the
// GLO-30 elevation bands when they have landed.
function districtBoundaryTip(feature) {
  const p = feature.properties || {};
  let html = '<strong>' + escapeHtmlAttr(p.nameEn || '') + '</strong>';
  if (p.nameNe) html += '<span class="popup-ne" lang="ne">' + escapeHtmlAttr(p.nameNe) + '</span>';
  return html;
}

function districtBoundaryPopup(feature) {
  const p = feature.properties || {};
  let html = '<strong>' + escapeHtmlAttr(p.nameEn || 'District') + '</strong>';
  if (p.nameNe) html += '<span class="popup-ne" lang="ne">' + escapeHtmlAttr(p.nameNe) + '</span>';
  if (p.hq) html += '<br>HQ: ' + escapeHtmlAttr(p.hq);
  if (p.provinceCode) html += ' · Province ' + escapeHtmlAttr(String(p.provinceCode));
  const elev = _districtElev && _districtElev[p.nameEn];
  if (elev) {
    html += '<br><span style="color:#64748b;font-size:12px">Rises from ' +
      elev.elevMin.toLocaleString('en-US') + ' m to ' +
      elev.elevMax.toLocaleString('en-US') +
      ' m above sea level (mean ~' +
      elev.elevMean.toLocaleString('en-US') +
      ' m · Copernicus GLO-30)</span>';
  }
  html += '<br><span style="color:#64748b;font-size:12px">Boundary: Survey Department of Nepal / National Geoportal</span>';
  return html;
}

// Shared popup for boundaries and dots, so both views tell the same story.
function itemPopupHtml(item) {
  const cbs = item.cbsCode != null ? '<code>' + item.cbsCode + '</code>' : '—';
  const wards = item.wards != null ? item.wards + ' wards' : 'wards n/a';
  const tier = confidenceMeta(item);
  const tierShort = { verified: '✓ verified', singleSource: '~ single-source', unverified: '— no code' }[tier.cls];
  let html = '<strong>' + escapeHtmlAttr(item.name) + '</strong>';
  if (item.nameNe) html += '<span class="popup-ne" lang="ne">' + escapeHtmlAttr(item.nameNe) + '</span><br>';
  else html += '<br>';
  html += escapeHtmlAttr(item.district) + ', ' + escapeHtmlAttr(item.province) + '<br>';
  html += 'CBS: ' + cbs + ' (' + tierShort + ') · ' + wards;
  const elev = _districtElev && _districtElev[item.district];
  if (elev) {
    html += '<br><span style="color:#64748b;font-size:12px">Rises from ' +
      elev.elevMin.toLocaleString('en-US') + ' m to ' +
      elev.elevMax.toLocaleString('en-US') +
      ' m above sea level (mean ~' +
      elev.elevMean.toLocaleString('en-US') +
      ' m · Copernicus GLO-30)</span>';
  }
  if (item.lat != null && item.lng != null) {
    html += '<br><span style="color:#64748b;font-size:12px">' +
      item.lat.toFixed(3) + ', ' + item.lng.toFixed(3) + ' · ' +
      escapeHtmlAttr(item.geoSource || 'compiled') + '</span>';
  }
  return html;
}

function metricColorFor(item) {
  if (_mapMetric === 'type') {
    return TYPE_COLORS[item.type] || '#78716C';
  }
  if (_mapMetric === 'cbs') {
    const tier = confidenceMeta(item);
    return tier.cls === 'verified' ? '#1D4ED8' : tier.cls === 'singleSource' ? '#A8A29E' : '#D97706';
  }
  if (_mapMetric === 'elevation') {
    const e = _districtElev && _districtElev[item.district];
    if (!e) return '#E7E5E4';
    const m = e.elevMean;
    if (m >= 3500) return '#7C2D12';
    if (m >= 2500) return '#B45309';
    if (m >= 1500) return '#F59E0B';
    if (m >= 500) return '#FCD34D';
    return '#FDE68A';
  }
  var w = item.wards;
  if (w == null) return '#E7E5E4';
  if (w >= 25) return '#1E3A8A';
  if (w >= 20) return '#1D4ED8';
  if (w >= 15) return '#3B82F6';
  if (w >= 10) return '#93C5FD';
  return '#DBEAFE';
}

// Wave R1: Leaflet restyled layer handles; MapLibre paints from data.
// Every metric/filter change re-stamps __fill/__stroke/__sw/__fo on the
// in-memory features and hands the collection back to the source — the
// layer paints are pure ['get', ...] expressions, nothing drifts.
function paintBoundaryFeatures() {
  for (const f of _boundaries.features) {
    const row = f.__row;
    const active = row && _activeRows.has(row);
    const p = f.properties || (f.properties = {});
    if (!row || !active) {
      // Filtered out (or not matched to a row): dim instead of hide, so
      // the national figure keeps its context.
      p.__fill = '#d6d3d1'; p.__fo = 0.08;
      p.__stroke = '#a8a29e'; p.__sw = 0.5;
    } else {
      p.__fill = metricColorFor(row); p.__fo = 0.85;
      p.__stroke = '#57534e'; p.__sw = 0.8;
    }
  }
}

function restyleBoundaryLayer() {
  if (!_map || !_boundaries || !_map.getSource('palika')) return;
  paintBoundaryFeatures();
  _map.getSource('palika').setData(_boundaries);
}

function boundaryTip(feature) {
  const p = feature.properties || {};
  const row = feature.__row;
  let html = '<strong>' + escapeHtmlAttr(p.nameEn || '') + '</strong>';
  if (p.nameNe) html += '<span class="popup-ne" lang="ne">' + escapeHtmlAttr(p.nameNe) + '</span>';
  if (row) {
    html += '<br>' + escapeHtmlAttr(row.district);
    if (row.wards != null) html += ' · ' + row.wards + ' wards';
    const tier = confidenceMeta(row);
    html += '<br><span style="font-size:11px;color:#64748b">' + escapeHtmlAttr(tier.label) + '</span>';
  }
  return html;
}

function initBoundaryDetailToggle() {
  const box = document.getElementById('boundary-detail-toggle');
  if (!box) return;
  box.checked = _boundaryDetailHigh;
  box.addEventListener('change', () => setBoundaryDetail(box.checked));
}

function initMapOverlays() {
  if (_overlaysInited) return;
  _overlaysInited = true;
  // R2 (arm-chain diet): overlays no longer preload at engine boot —
  // five off-by-default GeoJSONs (~2.5 MB: outline, parks, NH01,
  // districts, provinces) used to ride the arm chain, fetching and
  // parsing on the main thread while the figure itself was still
  // loading. The toggles wire now; each overlay fetches on its first
  // ask (see updateOverlayToggles). enabledByDefault entries excepted.
  updateOverlayToggles();
  for (const def of MAP_OVERLAYS) {
    if (def.enabledByDefault) loadOverlay(def);
  }
}

function loadOverlay(def, opts) {
  const state = _overlayLayers[def.id];
  if (state) return state.ready;
  const visible = (opts && opts.visible) || !!def.enabledByDefault;
  const s = { def: def, layer: null, loaded: false, visible: visible, ready: null };
  _overlayLayers[def.id] = s;
  s.ready = (async () => {
    let lastErr = null;
    for (const url of def.urls) {
      try {
        const res = await fetch(url);
        if (!res.ok) throw new Error('HTTP ' + res.status + ' loading overlay ' + def.id);
        const fc = JSON.parse(await res.text());
        if (!fc || !Array.isArray(fc.features) || !fc.features.length) {
          throw new Error('overlay ' + def.id + ' parsed to 0 features');
        }
        // The map may still be booting (overlay fetches start first);
        // wait for it, then add the source + layers above the
        // choropleth and below the dots.
        await ensureMap();
        if (!_map || !_map.getSource('palika')) {
          throw new Error('map unavailable for overlay ' + def.id);
        }
        const srcId = 'overlay-' + def.id;
        if (!_map.getSource(srcId)) _map.addSource(srcId, { type: 'geojson', data: fc });
        for (const layer of overlayLayersFor(def)) {
          if (!_map.getLayer(layer.id)) {
            layer.layout = { visibility: s.visible ? 'visible' : 'none' };
            _map.addLayer(layer, 'dots-clusters');
            wireOverlayEvents(def, layer.id);
          }
        }
        s.layer = true; // MapLibre: source + layers live on the map
        s.loaded = true;
        updateOverlayToggles();
        return s;
      } catch (err) {
        lastErr = err;
      }
    }
    delete _overlayLayers[def.id];
    console.error('Overlay unavailable:', def.id, lastErr);
    updateOverlayToggles();
    return null;
  })();
  return s.ready;
}

// Leaflet-era path options in MAP_OVERLAYS style entries translate to
// MapLibre paint properties here — the registry keeps its old shape.
function overlayLayersFor(def) {
  const st = def.style || {};
  const layers = [];
  if (st.fill !== false) {
    layers.push({
      id: 'overlay-' + def.id + '-fill',
      type: 'fill',
      source: 'overlay-' + def.id,
      paint: {
        'fill-color': st.fillColor || st.color || '#3388ff',
        'fill-opacity': st.fillOpacity != null ? st.fillOpacity : 0.2,
      },
    });
  }
  const line = {
    id: 'overlay-' + def.id + '-line',
    type: 'line',
    source: 'overlay-' + def.id,
    paint: {
      'line-color': st.color || '#3388ff',
      'line-width': st.weight != null ? st.weight : 2,
      'line-opacity': st.opacity != null ? st.opacity : 1,
    },
  };
  if (st.dashArray) {
    line.paint['line-dasharray'] = st.dashArray.split(' ').map((x) => parseFloat(x));
  }
  layers.push(line);
  return layers;
}

function wireOverlayEvents(def, layerId) {
  if (def.tooltip) {
    _map.on('mousemove', layerId, (e) => {
      const f = e.features && e.features[0];
      if (!f) return;
      const tip = def.tooltip({ properties: f.properties });
      if (tip) {
        showMapTip(tip, e.point);
        _map.getCanvas().style.cursor = 'pointer';
      }
    });
    _map.on('mouseleave', layerId, () => {
      hideMapTip();
      _map.getCanvas().style.cursor = '';
    });
  }
  if (def.popup) {
    _map.on('click', layerId, (e) => {
      const f = e.features && e.features[0];
      if (!f) return;
      showMapPopup(e.lngLat, def.popup({ properties: f.properties }));
    });
  }
}

function setOverlayVisible(id, visible) {
  const s = _overlayLayers[id];
  if (!s || !s.loaded || !_map) return;
  s.visible = visible;
  for (const layer of overlayLayersFor(s.def)) {
    if (_map.getLayer(layer.id)) {
      _map.setLayoutProperty(layer.id, 'visibility', visible ? 'visible' : 'none');
    }
  }
}

function overlayToggleLabel(def) {
  const s = _overlayLayers[def.id];
  // R2 (lazy overlays): an unloaded overlay is TOGGLEABLE, not
  // unavailable — asking for it starts its fetch. "Loading…" shows only
  // while an ask is in flight.
  if (s && !s.loaded) return def.label + ' (loading\u2026)';
  return def.label;
}

function updateOverlayToggles() {
  const el = document.getElementById('map-overlays');
  if (!el) return;
  el.innerHTML = '';
  if (!MAP_OVERLAYS.length) { el.hidden = true; return; }
  el.hidden = false;
  const title = document.createElement('span');
  title.className = 'legend-title';
  title.textContent = 'Overlays';
  el.appendChild(title);
  for (const def of MAP_OVERLAYS) {
    const s = _overlayLayers[def.id];
    const label = document.createElement('label');
    label.className = 'overlay-toggle' + (s && !s.loaded ? ' overlay-loading' : '');
    const box = document.createElement('input');
    box.type = 'checkbox';
    box.id = 'overlay-' + def.id;
    if (s && s.loaded) {
      box.checked = s.visible;
      box.addEventListener('change', () => setOverlayVisible(def.id, box.checked));
    } else if (s) {
      // First ask in flight: checked per its intent, inert until it lands.
      box.checked = s.visible;
      box.disabled = true;
    } else {
      // R2 (lazy overlays): the toggle IS the loader — the fetch starts
      // on the first ask, never at engine boot.
      box.addEventListener('change', () => {
        if (!box.checked) return;
        box.disabled = true;
        loadOverlay(def, { visible: true });
        updateOverlayToggles();
      });
    }
    const text = document.createElement('span');
    text.textContent = overlayToggleLabel(def);
    label.appendChild(box);
    label.appendChild(text);
    el.appendChild(label);
  }
}

function renderMapLegend() {
  const el = document.getElementById('map-legend');
  if (!el) return;
  if (_mapMetric === 'dots') { el.innerHTML = DOTS_LEGEND_HTML; return; }
  const m = MAP_METRICS[_mapMetric];
  if (!m) return;
  let html = '<span class="legend-title">' + m.label + '</span>';
  for (const e of m.entries) {
    html += '<span class="legend-chip"><i class="legend-swatch" style="background:' + e.color + '"></i>' + e.label + '</span>';
  }
  el.innerHTML = html;
}

function updateChoroplethStatus(items) {
  const status = document.getElementById('map-status');
  if (!status || !_boundaries) return;
  let joined = 0, shaded = 0;
  for (const f of _boundaries.features) {
    if (f.__row) {
      joined++;
      if (_activeRows.has(f.__row)) shaded++;
    }
  }
  let text = shaded + ' of ' + items.length + ' shaded on the map · ' + joined + '/753 boundaries joined';
  if (items.length > shaded) text += ' · rest table-only (no coordinates or unmatched name)';
  status.textContent = text;
}

function syncChoropleth(items) {
  if (!document.getElementById('map')) return;
  _activeRows = new Set(items);
  const status = document.getElementById('map-status');
  if (status && !_boundaryDataAdded) status.textContent = 'Loading palika boundaries…';
  mapEngineReady()
    .then(() => {
      if (!_map) return null;
      // Data half (R2): the basemap is up; the boundary fetch + parse +
      // name join + setData run in the first idle slot after it, so
      // their long tasks never stack on the engine boot.
      return new Promise((resolve) => { scheduleIdle(() => resolve()); })
        .then(() => (_map ? loadBoundaries() : null));
    })
    .then((fc) => {
      if (!fc || !_map || !_map.getSource('palika')) return;
      buildBoundaryIndex((window.__explorerAll && window.__explorerAll()) || items);
      paintBoundaryFeatures();
      _map.getSource('palika').setData(_boundaries);
      _boundaryDataAdded = true;
      _map.setLayoutProperty('palika-fill', 'visibility', 'visible');
      _map.setLayoutProperty('palika-line', 'visibility', 'visible');
      _map.setLayoutProperty('dots-clusters', 'visibility', 'none');
      _map.setLayoutProperty('dots-points', 'visibility', 'none');
      renderMapLegend();
      if (!_map.__fitted) {
        _map.__fitted = true;
        try { _map.fitBounds(boundsOf(_boundaries), { padding: 24 }); } catch (e) { /* keep default view */ }
      }
      updateChoroplethStatus(items);
    })
    .catch((err) => {
      // Boundaries unfetchable: keep the explorer useful — classic dots.
      console.error('Boundary load failed:', err);
      const sel = document.getElementById('metric-filter');
      if (sel) sel.value = 'dots';
      _mapMetric = 'dots';
      renderMapLegend();
      syncDotsMap(items);
      const st = document.getElementById('map-status');
      if (st) st.textContent = 'Boundaries unavailable — showing centroid dots.';
    });
}

// Wave 4-C (lazy figure): booting the map engine + boundary geometry at
// DOMContentLoaded put CDN scripts, a 476 KB fetch and long main-thread
// tasks inside the LCP window (Explorer measured 4573ms mobile). The
// figure sits below the fold; it now arms when its section approaches
// the viewport — immediately for deep links (?cbs= / ?metric=), which
// target the map by definition. Until armed, syncMap just keeps the
// latest rows; filtering stays free.
var _mapArmed = false;
var _mapArmIo = null;
var _mapArmIdle = false; // R2: a scroll-arm defers the engine half to the first idle slot

// R2 (arm-chain split, walking the budgets toward the law): the arm
// chain is now two halves, scheduled separately.
//   engine half: the maplibre-gl stylesheet (render-blocking while it
//     loads), the 758 KB UMD script, its parse and the WebGL context
//     init — the R1 TBT whale;
//   data half: the 476 KB boundary fetch, the parse, the name join and
//     setData.
// A scroll-arm boots the engine in the FIRST idle slot after the arm,
// so the render-blocking stylesheet link and the long parse land after
// the initial paint — the hero subtitle is the LCP element and it must
// win that race (R1 verdicts: LCP 4789/4784ms, TBT 2373/2509ms). The
// rIC timeout keeps the boot bounded on a busy main thread; setTimeout
// is the fallback where rIC is missing. Deep links (?cbs= / ?metric=)
// target the map by definition (the W4-C contract): they boot the
// engine immediately. The data half always idles once more AFTER the
// basemap is up: the raster basemap paints first, the choropleth fills
// in a beat later, and neither half ever stacks on the boot.
function scheduleIdle(fn) {
  if (typeof requestIdleCallback === 'function') {
    requestIdleCallback(fn, { timeout: 1500 });
    return;
  }
  setTimeout(fn, 0);
}

function mapEngineReady() {
  if (_mapArmIdle && !_mapReady) {
    return new Promise((resolve) => {
      scheduleIdle(() => { ensureMap().then(resolve, resolve); });
    });
  }
  return ensureMap();
}

function renderArmedMap() {
  if (!_lastMapItems) return;
  if (_mapMetric === 'dots') { syncDotsMap(_lastMapItems); return; }
  syncChoropleth(_lastMapItems);
}

function syncMap(items) {
  if (!document.getElementById('map')) return;
  _lastMapItems = items;
  if (_mapArmed) { renderArmedMap(); return; }
  const params = new URLSearchParams(window.location.search);
  if (params.get('cbs') || params.get('metric')) {
    _mapArmed = true;
    _mapArmIdle = false; // deep link: the map IS the destination — engine now (W4-C)
    renderArmedMap();
    return;
  }
  if (_mapArmIo) return;
  _mapArmIo = new IntersectionObserver(function (entries) {
    for (let i = 0; i < entries.length; i++) {
      if (!entries[i].isIntersecting) continue;
      _mapArmIo.disconnect();
      _mapArmIo = null;
      _mapArmed = true;
      _mapArmIdle = true; // scroll-arm: engine half defers to the first idle slot (R2)
      renderArmedMap();
    }
  }, { rootMargin: '300px 0px' });
  _mapArmIo.observe(document.getElementById('map'));
}

function syncDotsMap(items) {
  if (!document.getElementById('map')) return;
  mapEngineReady().then(() => {
    if (!_map || !_map.getSource('dots')) return;
    _map.setLayoutProperty('palika-fill', 'visibility', 'none');
    _map.setLayoutProperty('palika-line', 'visibility', 'none');
    _map.setLayoutProperty('dots-clusters', 'visibility', 'visible');
    _map.setLayoutProperty('dots-points', 'visibility', 'visible');
    const pts = items.filter(d => d.lat != null && d.lng != null);
    const features = pts.map((item) => ({
      type: 'Feature',
      geometry: { type: 'Point', coordinates: [item.lng, item.lat] },
      properties: {
        r: item.type === 'metropolitan' ? 9 : item.type === 'sub-metropolitan' ? 8 : 6,
        color: markerColor(item),
        fo: item.cbsCode != null ? 0.85 : 0.2,
        __key: 'pt|' + (item.cbsCode != null ? item.cbsCode : (item.district + '/' + item.name)),
      },
    }));
    for (const item of pts) {
      _rowByKey.set('pt|' + (item.cbsCode != null ? item.cbsCode : (item.district + '/' + item.name)), item);
    }
    const fc = { type: 'FeatureCollection', features: features };
    _map.getSource('dots').setData(fc);
    const status = document.getElementById('map-status');
    if (status) {
      const total = items.length;
      status.textContent = pts.length + ' of ' + total + ' shown on map' +
        (total - pts.length > 0 ? ' (' + (total - pts.length) + ' without coordinates — table only)' : '');
    }
    if (pts.length > 0 && !_map.__fitted) {
      _map.__fitted = true;
      try { _map.fitBounds(boundsOf(fc), { padding: 24 }); } catch (e) { /* keep default view */ }
    }
  });
}

function focusMarker(lat, lng, name) {
  ensureMap().then(() => {
    if (!_map) return;
    const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    _map.flyTo({ center: [lng, lat], zoom: Math.max(_map.getZoom(), 10), duration: reduced ? 0 : 800, essential: false });
    showMapPopup([lng, lat], '<strong>' + escapeHtmlAttr(name || 'Selected') + '</strong>');
    document.getElementById('map')?.scrollIntoView({ behavior: reduced ? 'auto' : 'smooth', block: 'nearest' });
  });
}

function escapeHtmlAttr(text) {
  return String(text ?? '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

// Module scope: typeBadge() (table rows) and map popups both need this.
// (A previous version defined escapeHtml only inside initExplorer(),
// which threw `escapeHtml is not defined` from module-scope callers.)
function escapeHtml(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
}

// Floating pill header on scroll (passive listener, rAF-throttled).
function initHeaderScroll() {
  const header = document.querySelector('.header');
  if (!header) return;
  const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  let ticking = false;
  const update = () => {
    ticking = false;
    header.classList.toggle('scrolled', window.scrollY > 8);
  };
  update();
  window.addEventListener('scroll', () => {
    if (reduced) { update(); return; }
    if (!ticking) {
      ticking = true;
      requestAnimationFrame(update);
    }
  }, { passive: true });
}

// Wave 2.5: count-up hero stats when they enter the viewport ("motion
// that explains"). Reduced-motion or no IntersectionObserver: the text
// stays exactly as authored. The numbers are read from the DOM itself,
// so the source HTML keeps the exact needle strings.
function initCountUp() {
  const stats = document.querySelector('.hero-stats');
  if (!stats || typeof IntersectionObserver === 'undefined') return;
  const targets = stats.querySelectorAll('.stat-value');
  if (!targets.length) return;
  const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  // Wave 4-C: Save-Data visitors keep the authored numbers — no frames
  // spent on counting.
  if (SAVE_DATA) return;
  const animate = (el) => {
    if (reduced) return;
    const finalText = el.textContent || '';
    const num = parseInt(finalText.replace(/,/g, ''), 10);
    if (!Number.isFinite(num) || num <= 0) return;
    const duration = 700; // Emil ceiling: well under 1000ms
    const started = performance.now();
    const fmt = (v) => v.toLocaleString('en-US');
    const tick = (now) => {
      const t = Math.min(1, (now - started) / duration);
      const eased = 1 - Math.pow(1 - t, 3); // ease-out cubic
      el.textContent = fmt(Math.round(num * eased));
      if (t < 1) requestAnimationFrame(tick);
      else el.textContent = fmt(num);
    };
    requestAnimationFrame(tick);
  };
  const io = new IntersectionObserver((entries, obs) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) { animate(entry.target); obs.unobserve(entry.target); }
    });
  }, { threshold: 0.4 });
  targets.forEach((el) => io.observe(el));
}

// Wave 2.5: bento entrance stagger — cells rise 12px and fade in, offset
// by the --nb-motion-stagger token (40ms) per cell. Opt-in: JS adds
// reveal-ready first (no-JS visitors see a fully rendered grid), then
// in-view triggers the rise. Reduced-motion collapses it via CSS media.
function initBentoReveal() {
  const grid = document.querySelector('.features-grid');
  if (!grid || typeof IntersectionObserver === 'undefined') return;
  grid.classList.add('reveal-ready');
  const io = new IntersectionObserver((entries, obs) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) { grid.classList.add('in-view'); obs.disconnect(); }
    });
  }, { threshold: 0.15 });
  io.observe(grid);
}

// Initialize theme + nav + header on load
document.addEventListener('DOMContentLoaded', () => {
  initTheme();
  initNav();
  initHeaderScroll();
  initCountUp();
  initBentoReveal();
});

// API docs nav highlighting
if (document.querySelector('.api-nav')) {
  const sections = document.querySelectorAll('.api-section[id]');
  const navLinks = document.querySelectorAll('.api-nav a[href^="#"]');

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        navLinks.forEach(link => {
          link.classList.toggle('active', link.getAttribute('href') === '#' + entry.target.id);
        });
      }
    });
  }, { rootMargin: '-100px 0px -66%' });

  sections.forEach(section => observer.observe(section));
}


