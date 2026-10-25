# Changelog

## 0.2.0

Expanded into a full component library over the verified dataset, with a
runnable gallery.

### Added
- `LocalBodyTypeChip` — the palika type as a themed, colour-coded chip
  (full name or dataset abbreviation). Accents derive from `ColorScheme`
  roles, so the chip re-themes with the app in light and dark with zero
  configuration.
- `TrustBadge` — renders the evidence tier behind a CBS code (`verified` /
  `singleSource` / `unverified`) per Design System v3 trust rules: verified
  is scoped information in the action colour, never success green, and "not
  coded" is a published fact, not an error state. Compact icon-only mode for
  dense tables; tooltips and semantics carry the full story.
- `AdministrativeSummaryCard` — a self-contained visual summary of one
  palika: bilingual name, type chip, trust badge, CBS code, ward count and
  the district → province breadcrumb, with an honest empty state.
- `AdministrativePickerCard` — the drop-in composition: cascading
  dropdowns, bilingual search and a live summary card in one card, with a
  clear-selection action that reports an empty selection.
- Component gallery in `example/` — every widget runnable in light and dark
  over the real dataset, with live national statistics. The example now
  ships its own `pubspec.yaml`, so `flutter run` works out of the box.
- Component test suite — chips, badges, cards and the picker card tested
  against the real dataset: one real palika per CBS tier, every type, the
  empty states, and the clear action.

### Changed
- Package version 0.2.0; description updated from "dropdowns" to "widgets".
- `uses-material-design: true` declared in `pubspec.yaml` (the package has
  always used Material icons).

Requires `nepal_admin_api` 2.7.2 or later (hosted constraint).

## 0.1.0

Initial release.

- `AdministrativeCascade` — a widget-free `ChangeNotifier` holding the
  province → district → local body state transitions and the bilingual label
  rules. Scoped, search, `selectAll`, `clear`, and an immutable
  `AdministrativeSelection` that distinguishes same-named bodies in different
  districts.
- `AdministrativeDropdown` — three dependent dropdowns, each disabled until
  its parent is chosen, with a helper line reporting how many options are
  available. Exposes its cascade to descendants via `cascadeOf`.
- `LocalBodySearchField` — debounced bilingual search scoped to the cascade,
  every result labelled with its district.
- `LabelStyle` (`english` / `devanagari` / `both`) with single-script fallback,
  so a label never ends in a dangling separator for the 22 local bodies that
  have no attested Devanagari name.

Requires `nepal_admin_api` 2.7.2 or later (hosted constraint).
