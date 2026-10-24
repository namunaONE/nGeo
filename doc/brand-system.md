# Design System v3 — Himalayan Trust × Everest Growth

> **Status:** active proposal · **Supersedes:** Brand System v2 (navy #002C6D × green #4FD166)
> **Owner:** Design + Engineering (namunaONE) · **Last reviewed:** 2026-10-24
>
> **Rules:** this file · **Web tokens:** `docs/brand-tokens.css` · **Flutter theme:** `example/brand_theme.dart` · **Showcase:** `docs/brand.html`

The system's job is the same as v2's — one visual language across the
package, the docs site, and Flutter apps built on `nepal_admin_widgets` —
with two upgrades: **measured contrast pairs** for every
foreground/background combination, and **trust semantics** so attestation
claims ("CBS code, doubly-attested") can never look stronger than the
evidence behind them.

## 1. What changed from v2

| Job | v2 | v3 | Why |
|---|---|---|---|
| Primary action / links / focus | navy #475D92 (M3 tone 40 of #002C6D) | **accessible blue #1D4ED8** | 6.70:1 with white — AA normal text |
| Secondary / success | green #006E27 | **accessible green #15803D** | 5.02:1 with white — AA |
| Brand accent fills | navy #002C6D + green #4FD166 | **brand blue #3B82F6** + brand green #4FD166 | identity kept, demoted to fills/graphics only |
| Tertiary | plum #725572 | brand blue #3B82F6 with ink text | one hue family; plum removed |
| Surfaces | blue-tinted neutrals | **stone** #FAFAF9 → #0C0A09 | calm canvas; text contrast first |
| Text on brand-blue fill | white (3.68:1 fails) | **ink #0B1220** (5.09:1) | white on #3B82F6 fails AA |
| "Verified" badge | green + checkmark | **blue scoped label** (icon + text + scope + date) | verified is scoped information, not success |

## 2. Brand colors and measured contrast

| Foreground | Background | Ratio | Verdict |
|---|---|---:|---|
| #1D4ED8 | #FFFFFF | 6.70:1 | AA normal text |
| #FFFFFF | #1D4ED8 | 6.70:1 | AA normal text |
| #15803D | #FFFFFF | 5.02:1 | AA normal text |
| #3B82F6 | #FFFFFF | 3.68:1 | large text / UI only |
| #0B1220 | #3B82F6 | 5.09:1 | AA (ink on brand-blue fill) |
| #4FD166 | #FFFFFF | 1.97:1 | **fail — never text on white** |
| #052E16 | #4FD166 | 7.56:1 | AA (ink on brand-green fill) |
| #92400E | #FFFBEB | 6.84:1 | AA (warning pair) |
| #B91C1C | #FEF2F2 | 5.91:1 | AA (danger pair) |
| #1D4ED8 | #EFF6FF | 6.16:1 | AA (info pair) |

Brand blue and brand green are the identity; the accessible blue and
accessible green are the product tokens. Related, not identical.

## 3. Token architecture

Primitive → Semantic → Component.

- **Primitives** are ramps (`--blue-*`, `--green-*`, `--stone-*`, status)
  — used only by design-system internals, never in feature markup/widgets.
- **Semantic tokens** name a job, not a hue (`--nb-action-primary`,
  `--nb-trust-verified`, `space.4`) — what components consume.
- **Component tokens** alias a semantic token for one component family.

In CSS the naming is `--nb-<role>`. In Dart the equivalents are
`NbPrimitives` (primitives), `NbSemanticColors` (a `ThemeExtension`),
`NbSpacing`, and `NbShape`.

## 4. Semantic roles — light

- Actions: primary `#1D4ED8` / foreground `#FFFFFF`; hover `#1E40AF`;
  subtle `#EFF6FF`. Secondary `#15803D` (white) / subtle `#F0FDF4`.
- Accents: brand blue `#3B82F6` with ink `#0B1220`; brand green
  `#4FD166` with `#052E16`.
- Surfaces: canvas `#FAFAF9`, raised `#FFFFFF`, subtle `#F5F5F4`,
  muted `#E7E5E4`.
- Text: primary `#1C1917`, secondary `#57534E`, tertiary `#6B655F`.
- Borders: default `#E7E5E4`, strong `#A8A29E`, focus `#1D4ED8`.
- Status: success `#15803D` / container `#F0FDF4`; warning `#92400E` /
  `#FFFBEB`; danger `#B91C1C` / `#FEF2F2`; info `#1D4ED8` / `#EFF6FF`.
- Trust: verified `#1D4ED8` / `#EFF6FF`; ownerStated `#57534E` /
  `#F5F5F4`; pending `#92400E` / `#FFFBEB`; expired `#57534E`; revoked
  `#B91C1C`.

## 5. Semantic roles — dark

Dark is built separately, never inverted: primary `#93C5FD` with ink
text, secondary `#86EFAC` with ink text, brand accent `#60A5FA`, canvas
`#0C0A09`, raised `#1C1917`, borders `#44403C`, focus `#93C5FD`,
success text `#86EFAC`, warning `#FCD34D`, danger `#FCA5A5`,
trust.verified `#93C5FD`. Trust semantics stay identical across themes.

## 6. Material 3 mapping

`ColorScheme.fromSeed` converts the seed to HCT, builds tonal palettes,
and picks tones per role; the generated `primary` is a tone of the seed,
not the seed itself. v3 seeds with **#3B82F6** for harmony, then overrides:

| M3 role | Light | Dark |
|---|---|---|
| primary / onPrimary | #1D4ED8 / #FFFFFF | #93C5FD / #0B1220 |
| primaryContainer | #EFF6FF / #1E3A8A | #1E3A8A / #DBEAFE |
| secondary ★ | #15803D / #FFFFFF | #86EFAC / #0B1220 |
| secondaryContainer ★ | #F0FDF4 / #14532D | #14532D / #DCFCE7 |
| tertiary (brand accent) | #3B82F6 / #0B1220 | #60A5FA / #0B1220 |
| error | #B91C1C / #FFFFFF | #FCA5A5 / #0B1220 |
| surface | #FAFAF9 / #1C1917 | #0C0A09 / #FAFAF9 |
| surface containers (5 steps) | #FFFFFF → #D6D3D1 | #0C0A09 → #57534E |
| outline / outlineVariant | #A8A29E / #E7E5E4 | #78716C / #44403C |
| inverseSurface / inversePrimary | #1C1917 / #93C5FD | #FAFAF9 / #1D4ED8 |

★ = brand override. `tertiary` is a brand accent, **not** a warning role —
warning and danger live in semantic tokens (`NbSemanticColors` /
`--nb-*`), which Material does not model.

## 7. Typography

- Latin: **Plus Jakarta Sans** (400/600/700). Devanagari: **Noto Sans
  Devanagari** (bundle both; never depend on runtime download).
- Set the fallback once on the base style, not per widget:
  `TextStyle(fontFamily: 'PlusJakartaSans', fontFamilyFallback: ['NotoSansDevanagari'])`
  — see `nbTextTheme` in `example/brand_theme.dart`.
- Bilingual rules: no uppercase or letter-spacing on Devanagari; looser
  line heights for Nepali (matras need vertical room); emphasis via weight,
  never italic; design buttons and cards for two-line Nepali labels.

## 8. Spacing, radius, elevation, motion

- Spacing: 4-pt base, 8-pt rhythm (4/8/12/16/20/24/32/40/48/64).
- Radius: 8 inputs · 12 buttons/fields · 16 cards/dialogs · 24 sheets ·
  999 reserved for chips/avatars.
- Elevation: prefer tonal surfaces + borders over heavy shadows — cheap on
  low-end devices and keeps text contrast stable. Shadow opacity stays low.
- Motion: 150 / 200 / 300 ms, standard easing, respect reduce-motion, no
  infinite decorative animation.
- Touch targets: 48 recommended, 44 absolute minimum.

## 9. Component rules

- **Buttons**: primary = accessible blue, one per view; secondary = green
  or outlined surface; destructive confirms and names the object; minimum
  height 48; labels are verbs; loading keeps the label readable.
- **Deep card** (`.card-premium`): raised surface + 1px `outlineVariant`
  border + soft glow; title ≤ 2 lines; facts wrap, never truncate.
- **Chips**: 32 visual height, 48 tap target; selected state = color +
  icon + text.
- **Trust badges**: icon + text + scope + date. Never a bare checkmark,
  never seal/medal styling, never green for "verified". Verified is blue
  (scoped info); owner-stated is neutral.
- **Inputs**: label above the field (never placeholder-only), min height
  52, focus ring 2px `--nb-border-focus`, error replaces helper text
  without layout shift.
- **Tables**: tabular figures, right-aligned numeric columns; status as
  icon + text, never color alone.

## 10. Status and trust color rules

1. Never color as the only signal — pair with icon and text.
2. "Verified" is scoped information, not automatically "success".
3. No green badge implying data is guaranteed.
4. Pending is amber, not red.
5. Expired is neutral, not danger.
6. Owner-stated claims are neutral, never success green.
7. Brand green is never used for errors or warnings.
8. Brand blue is never used for success.
9. Disabled is exempt from contrast but must remain readable.
10. Re-check every pair after any value change.

## 11. Governance

- Rules: this file. Web values: `docs/brand-tokens.css`. Flutter:
  `example/brand_theme.dart`. No third token table in a feature doc.
- Token changes require a contrast re-check and a changelog entry.
- Deprecate with a migration note; do not silently rename.
- Next step: `brand/tokens.json` as the single source, generating Dart and
  CSS with a CI drift check (mirrors the data-bindings pipeline).

## 12. Migration notes (v2 → v3)

- **Flutter**: class names kept (`NepalBrandSeeds`, `NepalBrandScheme`,
  `NepalBrandTheme`). `NepalBrandSeeds.navy` and `.green` are
  deprecated aliases — no API break for existing users. New APIs:
  `NbPrimitives`, `NbSemanticColors`, `NbSpacing`, `NbShape`.
- **CSS**: all `--md-*` variables and helper class names kept; values
  remapped. `.badge-verified` is now the blue scoped-trust treatment
  (was green) per §10.
- **Docs site**: `styles.css` semantic tokens remapped (crimson →
  accessible blue, success → #15803D); primitives, class names, and layout
  unchanged; asset cache versions bumped to `?v=5`.
- **Logo**: unchanged by design — the double-pennon mark is national
  symbolism (Nepal crimson + Nepal blue), not the product palette.

## 13. Open items

- [ ] `brand/tokens.json` + generators + CI drift check
- [ ] Devanagari webfont for the docs site (Inter has no Devanagari)
- [ ] Adopt the v3 theme in `packages/nepal_admin_widgets` + golden tests
- [ ] Dark-mode device test of the full site
- [ ] Recompute the contrast table after any value change
