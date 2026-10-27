# nepal_admin_boundaries_highres

High-resolution boundary polygons for Nepal's 753 local bodies (palikas), as an
optional add-on to [`nepal_admin_api`](https://pub.dev/packages/nepal_admin_api).

## Why a separate package?

The core `nepal_admin_api` ships simplified boundaries (~17k vertices, ~100 KB)
so the package stays small and tree-shakeable. This package ships the same 753
palikas at ~4x the vertex count (~75k vertices, ~300 KB) for callers that need
smoother polygons (choropleth rendering, print maps, spatial analysis) and can
afford the larger download.

Both come from the same source (`sthaniya.gov.np` via Acesmndr/nepal-geojson,
MIT) and use the identical codec, so the two are interchangeable drop-ins.

## Install

```yaml
dependencies:
  nepal_admin_api: ^2.9.0
  nepal_admin_boundaries_highres: ^0.1.0
```

## Usage

```dart
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_boundaries_highres/nepal_admin_boundaries_highres.dart';

final b = HighResPalikaBoundaries.byName('Chitwan', 'Bharatpur');
print(b?.coordinateCount); // ~4x the core package

// Or via the LocalBody extension:
final lb = NepalAdminApi.getLocalBodyByCbs(31304)!;
print(lb.boundaryHighRes?.coordinateCount);
```

## Constants

- `kHighResPalikaBoundaryFeatureCount` — 753
- `kHighResPalikaBoundaryVertexCount` — ~75 305
- `kHighResPalikaBoundaryMatchedCount` — 753
- `kHighResPalikaBoundaries` — the encoded map (district → palika → string)
- `kHighResUnmatchedPalikaBoundaries` — empty on current data

## Honesty notes

- Same provenance as the core package: source is `sthaniya.gov.np` via
  Acesmndr/nepal-geojson (MIT). No geometry is invented.
- Simplified with Douglas-Peucker (eps 0.001 deg) from the 39 MB high-resolution
  source; the round trip is bit-exact.
- Coverage is 753/753 roster palikas, identical to the core package.

## Regenerating

```bash
dart run tool/generate_palika_boundaries_highres_package.dart
```

from the monorepo root.
