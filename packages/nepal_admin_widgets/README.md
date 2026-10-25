# nepal_admin_widgets

Flutter widgets for Nepal's administrative divisions — **7 provinces,
77 districts, 753 local bodies** — bilingual (English + Devanagari), entirely
offline, and backed by the verified [`nepal_admin_api`][api] dataset.

No network calls, no asset loading, no location permissions: the data is
compiled into the app.

## Install

```yaml
dependencies:
  nepal_admin_api: ^2.7.0
  nepal_admin_widgets: ^0.2.0
```

## The widget set

| Widget | What it does |
|---|---|
| `AdministrativePickerCard` | The drop-in composition: cascading dropdowns + bilingual search + a live summary card, with a clear-selection action. |
| `AdministrativeDropdown` | Three dependent Province → District → Palika dropdowns, each disabled until its parent is chosen. |
| `LocalBodySearchField` | Debounced bilingual search scoped to the cascade, every result labelled with its district. |
| `AdministrativeSummaryCard` | One palika at a glance: bilingual name, type chip, trust badge, CBS code, wards and the district → province breadcrumb — with an honest empty state. |
| `LocalBodyTypeChip` | The palika type as a colour-coded chip (full name or 'RM'-style abbreviation), accents derived from ColorScheme roles. |
| `TrustBadge` | The evidence tier behind a CBS code — doubly attested / single source / not coded — per Design System v3 trust rules. |
| `AdministrativeCascade` | The widget-free `ChangeNotifier` behind all of it: state transitions and label rules, unit-testable. |

### The fastest start

```dart
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

AdministrativePickerCard(
  onChanged: (selection) {
    if (selection.isComplete) save(selection.localBody!);
  },
);
```

Or wire the parts yourself:

```dart
final cascade = AdministrativeCascade();

AdministrativeDropdown(
  cascade: cascade,
  onChanged: (selection) {
    if (selection.isComplete) save(selection.localBody!);
  },
);
```

Read the cascade back from a descendant with
`AdministrativeDropdown.cascadeOf(context)`.

## The cascade

`AdministrativeCascade` is a plain `ChangeNotifier` with no widget dependency.
It holds the state transitions and the label rules — the parts worth testing —
so you can drive any UI you like.

```dart
final cascade = AdministrativeCascade()
  ..selectProvince(province)
  ..selectDistrict(district);

cascade.availableLocalBodies;      // scoped to that district
cascade.search('tokha');           // exact → prefix → substring → alphabetical
cascade.selection.isComplete;      // a body, not just a province
```

### Why the cascade rules are what they are

**Local-body names are not unique across Nepal.** `Sunkoshi` names four
different rural municipalities; there are only 719 distinct names across 753
local bodies. So the district is part of any answer, and two rules follow:

* Choosing a province clears the district and body beneath it.
* Choosing a district clears the body beneath it.

A stale child can never outlive the parent that made it meaningful.
`selectLocalBody` is authoritative — it reconciles the levels above it — so a
search hit from any district selects a coherent chain and a body can never be
selected under a district it does not belong to.

For the same reason `availableLocalBodies` is **empty until a province or
district is chosen**: listing all 753 would drop the district out of the answer.

## Labels

```dart
AdministrativeCascade.formatLocalBody(body);                    // "Tokha · टोखा"
AdministrativeCascade.formatLocalBody(body, style: LabelStyle.english);
AdministrativeCascade.formatLocalBodyDisambiguated(body);       // "…, Kathmandu"
```

`LabelStyle.both` falls back to whichever single script is attested, so a label
never ends in a dangling separator — 22 of the 753 palikas have no attested
Devanagari name. `formatLocalBodyDisambiguated` is unique across all 753.

## Theming

Every visual component derives its colours from
`Theme.of(context).colorScheme` roles — metropolitan chips take the primary
role, municipalities the secondary, sub-metropolitan the tertiary, rural a
neutral — so they theme correctly in light and dark with zero configuration
and stay in harmony with whatever seed colour the host app uses.

`TrustBadge` implements Design System v3's trust rules
([`doc/brand-system.md`](../../doc/brand-system.md)): a verification claim must
never look stronger than the evidence behind it, and "verified" renders as
scoped information in the action colour — never success green. A palika
without a code renders as a documented fact, not an error. Seed the host app
with brand blue `#3B82F6` for the intended harmony.

## Gallery — every widget, runnable

`example/lib/main.dart` is a light/dark gallery over the real dataset: the
picker, every palika type, every CBS confidence tier, the summary cards and
their empty states, and live national statistics.

Following this repo's convention (see the `flutter-example` CI job),
`example/` is deliberately not a package — it ships no `pubspec.yaml`, so it
never disturbs dependency resolution. The gallery is still compile-checked
on every push: the `flutter-widgets` CI job analyzes `lib`, `test` and
`example` together. To run it interactively, drop `example/lib/main.dart`
into any Flutter app that depends on `nepal_admin_widgets` — or into a
scratch package with a path dependency on this one — and `flutter run`.

## Verification

```
flutter analyze     # clean
flutter test
```

The suite runs against the real dataset, not fixtures. The core suite asserts
that the cascade cannot produce a body outside its roster, that clearing a
selection never leaves a stale child, that every label style is non-empty for
all 753 records, that the disambiguated label is unique for all 753, and that
no search result contradicts the chosen district. The 0.2.0 component suite
pins the display widgets the same way: one real palika per CBS tier, every
type chip, the empty states, and the clear action reporting an empty
selection.

CI runs `flutter analyze --fatal-infos` and `flutter test` on every push in the
`flutter-widgets` job; the widget code is not covered by the Dart package's own
analysis.

## Status

The package depends on the hosted [`nepal_admin_api`][api] (`^2.7.2`) and
carries no `publish_to: none` marker — it can be published to pub.dev
as-is. Note that CI's `publish-dry-run` job covers the root `nepal_admin_api`
package only, so publish this package manually when you cut a release.

## License

MIT, matching [`nepal_admin_api`][api].

[api]: https://pub.dev/packages/nepal_admin_api
