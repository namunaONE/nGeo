# Roadmap

> Working forward plan — last updated 2026-11-01. Shipped work lives in
> [CHANGELOG.md](CHANGELOG.md); this file only looks forward. Every item ships
> as its own small PR series under the standing laws below — one verified step
> per session, budgets and accessibility gates green on every merge.

## Where we are

Waves 0–4 and R1–R2 are shipped: one generated design system
(`brand/tokens.json` → `tool/generate_design_tokens.dart` →
`docs/brand-tokens.css`, drift-gated so web and Flutter can never disagree on
tokens), self-hosted fonts (no third-party CDN), WCAG 2.2 AA with a11y 100 on
all four pages, a bento homepage with motion tokens, a MapLibre GL explorer
(pinned v5.6.0, arm-chain idle split: clean TBT 1615/1819 vs the 1900
ratchet), a payload diet (heavy artifacts ride GitHub Releases + PMTiles),
truth gates (`tool/check_site_truth.dart` + `docs/smoke.cjs`), an RFC 7946
geometry conformance gate, and CI-generated version/stat strings.

## Next up (sequenced)

| # | Item | Why | Size |
|---|------|-----|------|
| 1 | **Agentic discovery upgrade** — llms.txt v2 conformance: per-page markdown alternates + `rel="alternate" type="text/markdown"` / `rel="describedby"` links; evaluate an `ard.json` + `<link rel="ard">` once the ARD v0.91 spec home is confirmed | Lighthouse already runs `llms-txt` audits; agents are now routine consumers of these docs; GitHub Pages project sites are an explicitly supported v2 case | 1–2 sessions |
| 2 | **Devanagari-first नेपाली toggle** — persisted preference like the theme toggle, `lang` swap, smoke pins | The flagship identity move: the site already promises bilingual; this makes it structural | 1–2 sessions |
| 3 | **AEO content pass** — question-form headings for the top real questions; FAQPage JSON-LD optional | Extraction-friendly docs for answer engines; note Google limits FAQ *rich results* to government/health sites — the markup is plumbing, not a visible win | 1 session |
| 4 | **Container-query depth** — device-support spike on target Android WebViews first; then style queries for map-metric theming and scroll-state queries for the sticky header (replaces a JS listener) | Components adapt to where they sit, not just the viewport; scroll-state is a TBT lever | 1–2 sessions |
| 5 | **Dark basemap + dark-glass popups** | Completes the dark-mode story the tokens already encode | 1–2 sessions |
| 6 | **Bento 2.0 explorer components** — legend, popup and metric cards self-adapt via container queries | The homepage logic carried through the app | 1–2 sessions |
| 7 | **चुच्चे hero + scroll storytelling** — self-drawing national-outline hero (`stroke-dashoffset`) and/or `animation-timeline: view()` behind `@supports`; static under reduced-motion | The authored signature moment; one bold thing per view | 1–2 sessions |
| 8 | **Self-host the MapLibre engine** | Removes the last third-party runtime fetch; identified LCP lever from the R2 verdicts | 1 session |
| 9 | **Wave 5: Flutter token unification** — `--flutter` generator output → `nepal_admin_widgets` ThemeData + golden tests | One token source provably drives both platforms | 2 sessions |
| 10 | **Data depth** — COD-AB upstream regen (needs the local toolchain; Release-asset channel, not Pages); ward-layer hunt stays blocked pending a licence verdict | Better geometry improves the map with zero UI changes | owner decision |

Sequencing note: 1–3 are documentation/machine-surface moves with no
interaction with the map arm chain; 4–7 touch the explorer and share the
device-support spike; 8 can land any time after 4; 9 is independent.

## Standing laws (every PR)

- **One PR = one purpose**, squash-merged.
- **Budgets interpolate, never hand-pin** — Lighthouse CI ratchets are walked
  from fresh verdicts; runner noise gets retried, not excused.
- **A11y 100 or no merge** — WCAG 2.2 AA, axe in CI.
- **The nGeo Design Test** gates every UI change (one bold thing per view?
  motion communicates state? Devanagari respected? subtract-first?).
- **Every cache-bust bumps its smoke pins** — audit all `v=` asserts in
  `docs/smoke.cjs` on every wave.
- **Smoke pins structure, not values** — thresholds live in exactly one gate tool; string-asserts in tests may pin wiring, never numbers, so a ratchet walk is a one-file change (learned in PR #42).
- **Generated files are never hand-edited** — `brand-tokens.css`,
  `data.json`, `district-elevation.json`, bindings, emitted Dart.
- **New platform features land behind `@supports`** with a tested fallback
  (view transitions, scroll-driven animation, container-query kinds).
- Motion honors `prefers-reduced-motion`; Save-Data honored; print works.
- **Docs change in the same PR as the behavior they describe** — stale docs
  are bugs.

## Parked decisions

- Default language for the नेपाली toggle (Devanagari-first vs follow-the-browser) — maintainer call.
- Offline service worker for the docs site — recommendation: **no**; HTTP caching suffices.
- Whether `ard.json` ships before or after its spec reaches 1.0 — tracked with item 1.
