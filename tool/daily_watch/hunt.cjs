#!/usr/bin/env node
// tool/daily_watch/hunt.cjs
//
// The "hunt" phase of the daily watch: probe every palika website recorded in
// the dataset, and mine each reachable site for its own Devanagari name.
//
// Rationale: a rural municipality's own official website is the most
// authoritative public source for ITS OWN name — the name is literally on the
// building, the letterhead and the <title> tag. Harvesting it gives:
//   - a third Devanagari attestation vote (after abinrimal and sagautam5),
//   - CANDIDATES for the 22 palikas whose nameNe is still null,
//   - site-liveness signals for the `website` field (single-source, MoFAGA).
//
// Politeness: at most 8 concurrent requests, 12s timeout each, one request
// per site per run, standard identifying User-Agent. Nothing is scraped
// beyond the document head; no personal data is collected.
//
// Exit codes: 0 = clean / informational only; 1 = actionable finding (a
// plausible Devanagari candidate surfaced for a palika whose nameNe is null);
// 2 = configuration error.
//
// Rules honoured:
//   - absence is not drift: an unreachable site says nothing about names.
//   - the hunt never writes the dataset: candidates are review material for
//     the merge pipeline, human-adjudicated.

'use strict';

const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.resolve(__dirname, '..', '..');
const OUT_DIR = path.join(ROOT, 'watch');
const USER_AGENT =
  'ngeo-daily-watch/1.0 (https://namunaone.github.io/nGeo/; scheduled source verification)';

const CONCURRENCY = 8;
const TIMEOUT_MS = 12000;
const MAX_BYTES = 60000; // only the document head is needed for <title>/meta

// ---------------------------------------------------------------------------
// Devanagari name handling
// ---------------------------------------------------------------------------

const DEVA_RUN = /[\u0900-\u097F]+(?:\s*[\u0900-\u097F]+)*/g;

const NE_SUFFIXES = [
  'महानगरपालिका', 'उपमहानगरपालिका', 'सब-महानगरपालिका',
  'गाउँपालिका', 'गाउपालिका', 'गापा', 'नगरपालिका', 'नपा', 'पालिका',
];

function normalizeNe(raw) {
  if (!raw) return '';
  let s = String(raw).replace(/[\u200B-\u200D\uFEFF]/g, '');
  s = s.replace(/[\u0964\u0965]/g, ' ');
  for (const suf of NE_SUFFIXES) s = s.split(suf).join(' ');
  s = s.replace(/\s+/g, '');
  return s.trim();
}

function extractDevaRuns(text) {
  const runs = [];
  let m;
  const re = new RegExp(DEVA_RUN);
  while ((m = re.exec(text)) !== null) {
    const t = m[0].trim();
    if (t.length >= 2) runs.push(t);
    if (runs.length > 40) break;
  }
  return runs;
}

function htmlHead(text) {
  // We only care about <title> and og:site_name; stop at </head> when present.
  const end = text.toLowerCase().indexOf('</head>');
  return end > 0 ? text.slice(0, end) : text.slice(0, MAX_BYTES);
}

function pageTitle(head) {
  const m = /<title[^>]*>([\s\S]*?)<\/title>/i.exec(head);
  if (m) return m[1];
  const og = /<meta[^>]+property=["']og:site_name["'][^>]+content=["']([^"']*)["']/i.exec(head);
  if (og) return og[1];
  return '';
}

// ---------------------------------------------------------------------------
// Dataset
// ---------------------------------------------------------------------------

function loadDataset() {
  const raw = JSON.parse(
    fs.readFileSync(path.join(ROOT, 'data', 'nepal_local_levels.json'), 'utf8'));
  const rows = [];
  const districtNe = {};
  for (const p of raw.provinces) {
    for (const d of p.districts) {
      districtNe[d.name] = d.nameNe || '';
      for (const lb of d.localBodies) {
        rows.push({
          name: lb.name,
          nameNe: lb.nameNe === undefined ? null : lb.nameNe,
          type: lb.type,
          district: d.name,
          districtNe: d.nameNe || '',
          province: p.name,
          website: lb.website === undefined ? null : lb.website,
        });
      }
    }
  }
  return { rows, districtNe };
}

function normalizeUrl(u) {
  let s = String(u).trim();
  if (!s) return null;
  if (!/^https?:\/\//i.test(s)) s = 'http://' + s;
  return s;
}

// ---------------------------------------------------------------------------
// Fetch pool
// ---------------------------------------------------------------------------

async function fetchSite(url) {
  const ctrl = new AbortController();
  const t = setTimeout(() => ctrl.abort(), TIMEOUT_MS);
  try {
    const res = await fetch(url, {
      signal: ctrl.signal,
      headers: { 'User-Agent': USER_AGENT, 'Accept': 'text/html,*/*' },
      redirect: 'follow',
    });
    const reader = res.body ? res.body.getReader() : null;
    let text = '';
    if (reader) {
      const dec = new TextDecoder('utf-8');
      let received = 0;
      for (;;) {
        const { done, value } = await reader.read();
        if (done) break;
        received += value.length;
        text += dec.decode(value, { stream: true });
        if (received >= MAX_BYTES) break;
      }
      text += dec.decode();
    }
    return { ok: res.ok, status: res.status, finalUrl: res.url || url, text };
  } finally {
    clearTimeout(t);
  }
}

async function runPool(items, worker, concurrency) {
  const results = new Array(items.length);
  let next = 0;
  async function lane() {
    for (;;) {
      const i = next++;
      if (i >= items.length) return;
      try {
        results[i] = await worker(items[i], i);
      } catch (err) {
        results[i] = { error: String((err && err.message) || err) };
      }
    }
  }
  await Promise.all(Array.from({ length: Math.min(concurrency, items.length) }, lane));
  return results;
}

// ---------------------------------------------------------------------------
// Hunt
// ---------------------------------------------------------------------------

async function hunt(rows) {
  const targets = rows
    .map(r => ({ row: r, url: normalizeUrl(r.website) }))
    .filter(t => t.url);
  const out = {
    probed: targets.length,
    reachable: 0,
    dead: [],
    moved: [],
    nameNeAgree: 0,
    nameNeDiffer: [],
    candidates: [], // Devanagari candidates for null nameNe
    errors: 0,
  };

  const results = await runPool(targets, async (t) => {
    try {
      const r = await fetchSite(t.url);
      if (!r.ok) return { status: r.status, finalUrl: r.finalUrl, text: r.text, reachable: false };
      return { status: r.status, finalUrl: r.finalUrl, text: r.text, reachable: true };
    } catch (e) {
      return { error: String((e && e.message) || e), reachable: false };
    }
  }, CONCURRENCY);

  for (let i = 0; i < targets.length; i++) {
    const t = targets[i];
    const r = results[i] || {};
    const label = `${t.row.name} [${t.row.district}] ${t.url}`;
    if (!r.reachable) {
      if (r.error) out.errors++;
      out.dead.push(`${label} — ${r.error ? r.error : 'HTTP ' + r.status}`);
      continue;
    }
    out.reachable++;
    const finalNoSlash = String(r.finalUrl).replace(/\/+$/, '');
    const origNoSlash = String(t.url).replace(/\/+$/, '');
    if (finalNoSlash !== origNoSlash) {
      out.moved.push(`${label} —> ${r.finalUrl}`);
    }
    const head = htmlHead(r.text || '');
    const title = pageTitle(head);
    if (!title) continue;
    const runs = extractDevaRuns(title);
    if (!runs.length) continue;
    // The site's own name is the longest Devanagari run in its title that is
    // not the generic type word or the district name.
    const districtNeNorm = normalizeNe(t.row.districtNe);
    const scored = runs
      .map(run => ({ run, len: normalizeNe(run).length }))
      .filter(x => x.len > 0 && normalizeNe(x.run) !== districtNeNorm)
      .sort((a, b) => b.len - a.len);
    if (!scored.length) continue;
    const siteNameNe = scored[0].run.trim();
    const siteNorm = normalizeNe(siteNameNe);
    if (t.row.nameNe) {
      if (siteNorm === normalizeNe(t.row.nameNe)) out.nameNeAgree++;
      else if (out.nameNeDiffer.length < 50) {
        out.nameNeDiffer.push(
          `${t.row.name} [${t.row.district}]: ours="${t.row.nameNe}" site="${siteNameNe}" (title="${title.slice(0, 80)}")`);
      }
    } else if (siteNorm.length >= 2 && siteNorm.length <= 40) {
      // A candidate for a null nameNe. Sanity: it must not equal any other
      // palika's Devanagari name in the same district (that would usually be
      // a logo/menu item bleeding into the title).
      const siblingNames = rows
        .filter(x => x.district === t.row.district && x.nameNe)
        .map(x => normalizeNe(x.nameNe));
      if (!siblingNames.includes(siteNorm)) {
        out.candidates.push({
          palika: t.row.name, district: t.row.district,
          candidate: siteNameNe, source: title.slice(0, 120), url: t.url,
        });
      }
    }
  }
  return out;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

async function main() {
  const startedUtc = new Date().toISOString();
  let dataset;
  try {
    dataset = loadDataset();
  } catch (err) {
    console.error('Could not read data/nepal_local_levels.json: ' + err.message);
    process.exit(2);
  }
  const withSite = dataset.rows.filter(r => r.website);
  const nameNeNullWithSite = withSite.filter(r => !r.nameNe).length;
  console.log(`Hunting ${withSite.length} palika websites (${nameNeNullWithSite} of them have nameNe == null)...`);

  const h = await hunt(dataset.rows);
  const actionable = h.candidates.length > 0;

  const lines = [];
  lines.push('# Palika website hunt');
  lines.push('');
  lines.push(`- Run (UTC): ${startedUtc}`);
  lines.push(`- Sites probed: ${h.probed} · reachable: ${h.reachable} · unreachable: ${h.dead.length} · fetch errors: ${h.errors}`);
  lines.push(`- Devanagari name agreement with our \`nameNe\`: ${h.nameNeAgree} sites`);
  lines.push(`- Orthography differences (informational, like the 281 documented intra-roster cases): ${h.nameNeDiffer.length}`);
  lines.push('');
  if (h.candidates.length) {
    lines.push(`## Candidates for null \`nameNe\` (${h.candidates.length}) — actionable, route through the merge pipeline`);
    lines.push('');
    for (const c of h.candidates) {
      lines.push(`- **${c.palika} [${c.district}]** ~> "${c.candidate}" — from <title>: "${c.source}" (${c.url})`);
    }
  } else {
    lines.push('## Candidates for null `nameNe`');
    lines.push('');
    lines.push('- None surfaced this run.');
  }
  lines.push('');
  if (h.moved.length) {
    lines.push(`## Sites that moved (redirected, informational — the \`website\` field is single-source MoFAGA) (${h.moved.length})`);
    lines.push('');
    for (const m of h.moved.slice(0, 60)) lines.push('- ' + m);
    if (h.moved.length > 60) lines.push(`- … ${h.moved.length - 60} more`);
    lines.push('');
  }
  if (h.dead.length) {
    lines.push(`## Unreachable sites (informational — never evidence about names) (${h.dead.length})`);
    lines.push('');
    for (const d of h.dead.slice(0, 80)) lines.push('- ' + d);
    if (h.dead.length > 80) lines.push(`- … ${h.dead.length - 80} more`);
    lines.push('');
  }
  if (h.nameNeDiffer.length) {
    lines.push('## Orthography differences vs our `nameNe` (informational)');
    lines.push('');
    for (const d of h.nameNeDiffer) lines.push('- ' + d);
    lines.push('');
  }

  fs.mkdirSync(OUT_DIR, { recursive: true });
  fs.writeFileSync(path.join(OUT_DIR, 'hunt-report.md'), lines.join('\n'));
  fs.writeFileSync(path.join(OUT_DIR, 'hunt-report.json'), JSON.stringify({
    startedUtc, summary: {
      probed: h.probed, reachable: h.reachable,
      dead: h.dead.length, moved: h.moved.length,
      nameNeAgree: h.nameNeAgree, nameNeDiffer: h.nameNeDiffer.length,
    },
    candidates: h.candidates,
    moved: h.moved, dead: h.dead, nameNeDiffer: h.nameNeDiffer,
  }, null, 2));

  console.log('');
  console.log(lines.join('\n'));
  console.log('Report written to watch/hunt-report.md and watch/hunt-report.json');
  process.exit(actionable ? 1 : 0);
}

main().catch(err => {
  console.error('hunt crashed: ' + (err && err.stack ? err.stack : err));
  process.exit(2);
});
