# Website — Nepal Administrative Data by namunaONE

Static documentation site deployed via GitHub Pages from `docs/`.

- **Live:** https://namunaone.github.io/nGeo/
- **Pages:** `index.html` (bento landing), `api.html` (reference),
  `explorer.html` (interactive table + metric-selector map over
  `data.json`), `brand.html` (Design System showcase over
  `brand-tokens.css`)
- **Assets:** `logo.svg` (icon), `logo-full.svg` (icon + wordmark),
  `favicon.svg`, `styles.css`, `app.js`, `data.json`,
  `brand-tokens.css` (generated), `fonts.css` + `fonts/` (self-hosted),
  `district-elevation.json` (lazy), vendored GeoJSON overlays.
- **Cache policy:** asset URLs carry `?v=N` (bump on every visual/data
  change; `DATA_URL` in `app.js` likewise) so returning visitors never
  run mixed old/new bundles after a deploy. Every cache-bust bumps its
  `docs/smoke.cjs` pins.
- **No build step.** Pure HTML/CSS/JS. `.nojekyll` disables Jekyll.

## Design system (generated tokens)

Design truth starts in `brand/tokens.json`. `tool/generate_design_tokens.dart` emits `docs/brand-tokens.css` (the CSS
custom properties the site consumes) and the Dart token bindings — one
source, two platforms, drift-checked in CI so web and Flutter can never
disagree. Generated files are never hand-edited; change the JSON, rerun
the generator, commit both together.

`styles.css` consumes those tokens (and adds component styles):

1. **Primitive tokens** — palette scales from the generated tokens
   (`--slate-*`, `--nepal-*`, status scales). Never used directly in
   components.
2. **Semantic tokens** — `--color-primary`, `--color-bg`,
   `--color-text`, `--color-border`,
   `--color-success/warning/danger/info`; dark-mode variants.
3. **Fluid typography + spacing** — `--text-*` and `--space-*` use
   `clamp()` (rem anchors + vw interpolation); no breakpoint-jumps.
4. **Layout primitives** — `.stack`, `.cluster`, `.grid-auto`; card
   grids and bento tiles use container queries
   (`container-type: inline-size`).
5. **Iconography** — `--icon-xs`…`--icon-xl` (14/16/20/24/32px),
   `currentColor` stroke icons, `.theme-icon` sun/moon swap.
6. **Components** — `.btn` (+primary/secondary/ghost/danger/sm/lg),
   `.badge`, `.card`, `.alert-*`, `.code-block`,
   `.explorer-table` (sticky header + scroll-shadow hint),
   `.pagination`, `.toast`, `.maintainer-badge`.
7. **Nav** — sticky blurred header, floating pill on scroll (`.scrolled`,
   passive rAF listener), hamburger panel ≤860px (aria-expanded,
   Escape/outside-click close), 44px touch targets.
8. **Badges** — explicit `TYPE_META` map (class + short label +
   full-name tooltip); `.type-unknown` fallback. Never derive chip
   classes via chained string replaces.
9. **Motion** — motion tokens in the generated set; reveal animations
   honor `prefers-reduced-motion`; count-up animations on landing stats.

Dark mode: `html.dark` class (JS toggle + `localStorage`), with
`prefers-color-scheme` as first-visit default. Print styles included.
`Save-Data` is honored (heavy fetches are skipped for visitors who
ask for less).

## Fonts (self-hosted)

`fonts.css` declares exactly four `@font-face` families, all served
same-origin from `fonts/`: Inter variable (latin), Noto Sans Devanagari
400 + 600, and JetBrains Mono 400. No third-party font CDN — no Google
Fonts request, no privacy leak, no render-blocking external fetch. The
total font payload is capped by `tool/fetch_fonts.dart` (CI gate:
`docs/fonts/` must stay within the declared byte budget). Devanagari
text on every page uses Noto Sans Devanagari, never a Latin fallback.

## Map (MapLibre GL)

The explorer map runs on **MapLibre GL JS v5.6.0** (pinned via `app.js` —
the last UMD build; a pinned version is a load-time guarantee, not a
"latest" request). It is lazy-loaded and only on `explorer.html`:

- **Arm chain** — the map is an idle-time arm, not critical path:
  `scheduleIdle` → `mapEngineReady` → `_mapArmIdle` split the work so
  the engine script, tiles and data never block first paint or the
  table. Clean TBT stays under the 1900 ratchet (last verdicts
  1615/1819).
- **Metrics** — `MAP_METRICS` in `app.js` drives the figure selector:
  local level type (default), wards per local level, CBS code
  confidence, and district elevation (`district-elevation.json`, itself
  lazy-loaded only when that metric is selected), plus the classic
  centroid dot view.
- **Data** — 753 palika boundaries vendored same-origin
  (`palika-boundaries.geojson`), joined to `data.json`; the join is
  pinned by a CI gate (`tool/check_boundary_join.dart`). Filters dim
  non-matching palikas instead of hiding them, so the national figure
  keeps its context.
- **Overlays** — `MAP_OVERLAYS` in `app.js` is the registry: a new
  context layer is a data PR, not a code PR. Vendor the GeoJSON, add
  the registry entry, and the loader, toggles and graceful
  "(unavailable)" degradation come for free. All overlays are off by
  default — the toggle is the loader.
- **Sync** — filters/search restyle the choropleth or rebuild dots;
  table-row click/Enter flies to the palika. The URL is the shareable
  explorer state: `?q=`, `?province=`, `?district=`, `?type=`,
  `?metric=` and `?cbs=` apply on load, and every filter change
  rewrites the address bar via `history.replaceState`.

### Context overlays (registry entries)

- **National outline (K1):** Nepal's official चुच्चे (chuche) map as
  published May 2020 — includes Kalapani, Lipulekh and Limpiyadhura
  (Darchula, Sudurpashchim). Outline-only, off by default. Geometry
  shipped unchanged from Acesmndr/nepal-geojson (MIT). A smoke gate
  pins the map: ring resolution > 1,000 points and point-in-polygon
  asserts for Lipulekh Pass, Kalapani and Kathmandu, so a pre-2020
  outline cannot pass CI.
- **Protected areas (K2):** the 20 core units on the official DNPWC
  roster — 12 national parks, 6 conservation areas, Koshi Tappu
  Wildlife Reserve and Dhorpatan Hunting Reserve — vendored same-origin
  (`protected-areas.geojson`), green fill-only, off by default.
  Geometry: WDPA (UNEP-WCMC & IUCN) via the WWF Nepal Biodiversity
  Areas dataset, server-side simplified (~150 m); completeness pinned
  by a smoke gate. Buffer zones and Ramsar sites stay out of scope.
- **NH01 highway (H1):** Mahendra / Hulaki Highway, Kakarbhitta (Jhapa)
  to Bhim Datta (Kanchanpur) — vendored same-origin
  (`nh01-highway.geojson`) as an optional amber overlay, off by
  default. Geometry extracted from OSM route relations by
  `tool/extract_nh01.cjs` with structural gates (≥ 50 member ways,
  both termini present, corridor length 800–1,300 km); a smoke gate
  re-checks the artifact.
- **District boundaries:** the 77-district layer, vendored
  same-origin, off by default.

Overlays are context, not data — their styling must never compete with
the choropleth figure.

## AI docs (llms.txt)

- `llms.txt` — spec-compliant index (single H1, ≤50-word blockquote
  summary, H2 sections, absolute-URL links with descriptions). Served at
  site root; footer-linked from every page.
- `llms-full.txt` — complete documentation in one file for deep ingestion.
  Hand-maintained alongside releases (install, quickstart, full API
  signatures, code formats, verification stats, known gaps, links).
  Update both when the API, coverage numbers, or version change.

## Regenerating generated files

Generated files are never hand-edited. From the repo root:

```bash
# data/nepal_local_levels.json → docs/data.json (753 rows)
dart run tool/generate_explorer_data.dart

# brand/tokens.json → docs/brand-tokens.css + Dart token bindings
dart run tool/generate_design_tokens.dart

# everything (merge steps + codegen + bindings), aborts on first failure
dart run tool/pipeline.dart

# verify the site's truth needles (cache-busts, pins, structure)
node docs/smoke.cjs
```

Commit the source and every generated file together; CI fails if any of
them drift apart.

## Documentation principles

- **Docs live with code** — a behavior change and the doc describing it
  land in the same PR. Stale docs are bugs.
- **One canonical source per fact** — counts and codes come from the
  package or CI-generated strings, never retyped into prose;
  `tool/check_site_truth.dart` + `docs/smoke.cjs` enforce the site side.
- **Question-shaped headings** — write the section title as the question
  the reader arrives with; the first paragraph answers it.
- **Examples are runnable** — every snippet assumes the repo as shipped,
  and CI or smoke exercises what it describes where practical.
- **Say what a thing is *for*, not just what it is** — "the toggle is the
  loader" style rules prevent the next reader from re-deriving the
  design intent.

## Logo

- `logo.svg` — double-pennon mark: Nepal crimson `#DC143C`,
  Nepal blue `#003893`, white moon/sun/Himalaya, 7 province dots.
- `logo-full.svg` — mark + "Nepal Administrative Data" +
  "7 provinces · 77 districts · 753 palikas" + "BY namunaONE".
- `favicon.svg` — 64px rounded version for browsers.
- `logo-full-dark.svg` — dark-mode wordmark (light text); swapped by JS
  via `data-logo-light`/`data-logo-dark` because SVG `<img>` cannot read
  page classes. `logo-full.svg` also carries a `prefers-color-scheme`
  media fallback for no-JS.
- Header uses `logo.svg` + stacked wordmark; hero uses `logo-full.svg`;
  footer reuses `logo.svg`.
- The logo is unchanged by design — the double-pennon crimson
  `#DC143C` × Nepal blue `#003893` is national symbolism, not the
  product palette.

## Local preview

```bash
cd docs
python -m http.server 8000
# open http://localhost:8000/index.html
```

## Smoke test (no browser, no npm deps)

`node docs/smoke.cjs` loads the real `app.js` in Node with minimal DOM
stubs and runs the full explorer flow (fetch → filters → stats → table →
pagination) against the real `data.json`. It catches ReferenceError/scope
bugs that `node --check` (syntax-only) misses — e.g. the `escapeHtml is
not defined` outage, where a module-scope caller used an
initExplorer-scoped helper. Runs in CI before Pages deploy.

Maintained by **namunaONE** under **HyaMuji** and **Taire Bhai**.
