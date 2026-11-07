// docs/sources-panel.js — "Data & sources" panel (Phase 0 provenance UI).
//
// Renders docs/sources.json — the machine-readable provenance manifest
// for the explorer's remote map layers — into #data-sources-panel.
// The panel is the honest half of the map: source, license, date
// policy and known limits for every layer, ON the page.
//
// Classic script, no app.js dependencies (srcPanel* namespace, so the
// smoke.cjs appSrc assertions are untouched). The manifest fetches on
// FIRST OPEN only — nothing on the boot path; LCP/TBT unchanged and
// Save-Data visitors pay nothing unless they ask.
(function () {
  'use strict';

  var POLICY_META = {
    'live-daily': { label: 'Live · daily', cls: 'policy-live' },
    'continuous': { label: 'Continuously updated', cls: 'policy-continuous' },
    'undated-mosaic': { label: 'Undated mosaic', cls: 'policy-undated' },
    'frozen': { label: 'Frozen snapshot', cls: 'policy-frozen' },
  };

  function srcPanelEsc(text) {
    return String(text == null ? '' : text)
      .replace(/&/g, '&amp;').replace(/</g, '&lt;')
      .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }

  function srcPanelBadge(policy) {
    var meta = POLICY_META[policy] || { label: policy || 'unknown', cls: 'policy-unknown' };
    return '<span class="src-badge ' + meta.cls + '">' + srcPanelEsc(meta.label) + '</span>';
  }

  function srcPanelRow(term, value) {
    if (!value) return '';
    return '<div class="src-row"><dt>' + srcPanelEsc(term) + '</dt><dd>' + srcPanelEsc(value) + '</dd></div>';
  }

  function srcPanelLayer(l) {
    return '<details class="src-item"><summary><span class="src-name">' +
      srcPanelEsc(l.id) + '</span>' + srcPanelBadge(l.datePolicy) + '</summary><dl>' +
      srcPanelRow('Provider', l.provider) +
      srcPanelRow('License', l.license) +
      srcPanelRow('Attribution', l.attribution) +
      srcPanelRow('Date policy', l.dateDetail) +
      srcPanelRow('Known limits', l.knownLimits) +
      srcPanelRow('Tiles / data', l.url) +
      '</dl></details>';
  }

  function srcPanelFirstParty(l) {
    return '<details class="src-item"><summary><span class="src-name">' +
      srcPanelEsc(l.file) + '</span><span class="src-badge policy-firstparty">First-party</span></summary><dl>' +
      srcPanelRow('Provenance', l.provenance) +
      srcPanelRow('CI gate', l.gate) +
      '</dl></details>';
  }

  function srcPanelStat(s) {
    return '<details class="src-item"><summary><span class="src-name">' +
      srcPanelEsc(s.file) + '</span><span class="src-badge policy-frozen">Derived</span></summary><dl>' +
      srcPanelRow('Source', s.source) +
      srcPanelRow('Provenance', s.provenance) +
      srcPanelRow('Validation anchors', s.validationAnchors) +
      '</dl></details>';
  }

  function srcPanelGroup(title, itemsHtml) {
    return '<h4 class="src-group">' + title + '</h4>' + itemsHtml;
  }

  function srcPanelRender(manifest, panel) {
    var html = '';
    if (Array.isArray(manifest.layers) && manifest.layers.length) {
      html += srcPanelGroup('Basemaps, imagery &amp; terrain',
        manifest.layers.map(srcPanelLayer).join(''));
    }
    var fp = manifest.firstPartyGeojson;
    if (fp && Array.isArray(fp.layers) && fp.layers.length) {
      html += srcPanelGroup('Official boundaries &amp; overlays',
        fp.layers.map(srcPanelFirstParty).join(''));
    }
    if (Array.isArray(manifest.derivedStats) && manifest.derivedStats.length) {
      html += srcPanelGroup('Derived statistics',
        manifest.derivedStats.map(srcPanelStat).join(''));
    }
    var eng = manifest.engine;
    if (eng) {
      html += '<p class="src-foot">Engine: ' + srcPanelEsc(eng.name + ' ' + eng.version) +
        ' (' + srcPanelEsc(eng.license) + ') · Manifest generated ' + srcPanelEsc(manifest.generated) +
        ' · Full package provenance lives in data/SOURCES.md.</p>';
    }
    var empty = panel.querySelector('.sources-panel-empty');
    if (empty) empty.remove();
    var body = document.createElement('div');
    body.className = 'sources-panel-body';
    body.innerHTML = html;
    panel.appendChild(body);
  }

  function srcPanelFail(panel) {
    var empty = panel.querySelector('.sources-panel-empty');
    if (empty) {
      empty.textContent = 'Layer provenance could not load — see data/SOURCES.md in the repository.';
    }
  }

  function srcPanelLoad(panel) {
    fetch('sources.json?v=1')
      .then(function (r) { if (!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function (manifest) { srcPanelRender(manifest, panel); })
      .catch(function () { srcPanelFail(panel); });
  }

  function srcPanelInit() {
    var btn = document.getElementById('data-sources-toggle');
    var panel = document.getElementById('data-sources-panel');
    if (!btn || !panel) return;
    var loaded = false;
    btn.addEventListener('click', function () {
      var opening = panel.hasAttribute('hidden');
      if (opening) {
        panel.removeAttribute('hidden');
        btn.setAttribute('aria-expanded', 'true');
        if (!loaded) { loaded = true; srcPanelLoad(panel); }
      } else {
        panel.setAttribute('hidden', '');
        btn.setAttribute('aria-expanded', 'false');
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', srcPanelInit);
  } else {
    srcPanelInit();
  }
})();
