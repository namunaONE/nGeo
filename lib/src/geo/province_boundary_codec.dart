// lib/src/geo/province_boundary_codec.dart
//
// Decoder and typed access for the provincial boundary strings generated into
// province_boundaries.dart (format version 1, identical to palika boundaries).
//
// Provinces are a strict subset of the palika boundary format (one polygon
// per province, no holes in practice), so we reuse PalikaBoundary's decode
// and point-in-polygon logic rather than duplicating it.

import 'palika_boundary_codec.dart';
import 'province_boundaries.dart';

/// A decoded provincial boundary. Alias of [PalikaBoundary] — same format,
/// same decode, same containment test.
typedef ProvinceBoundary = PalikaBoundary;

/// Lookups over the generated provincial boundary tables.
abstract final class ProvinceBoundaries {
  /// Boundary for a province by ISO code (e.g. 'NP-P1' or 'NP-P3'), or null
  /// when not present.
  static ProvinceBoundary? byIso(String iso) {
    final enc = kProvinceBoundaries[iso];
    if (enc == null) return null;
    final code = int.tryParse(iso.replaceAll(RegExp(r'[^0-9]'), ''));
    final name = code != null ? (kProvinceBoundaryNames[code] ?? '') : '';
    return ProvinceBoundary.decode(
      districtName: '',
      localBodyName: name,
      encoded: enc,
    );
  }

  /// Boundary for a province by its 1-based code (1..7), or null.
  static ProvinceBoundary? byCode(int code) => byIso('NP-P$code');

  /// Whether the geometry table covers this ISO code.
  static bool hasBoundary(String iso) => kProvinceBoundaries.containsKey(iso);

  /// All provincial boundaries, decoded, in province-code order.
  static List<ProvinceBoundary> get all => <ProvinceBoundary>[
        for (final e in kProvinceBoundaries.entries)
          ProvinceBoundary.decode(
            districtName: '',
            localBodyName: kProvinceBoundaryNames[
                    int.tryParse(e.key.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0] ??
                '',
            encoded: e.value,
          ),
      ];

  /// Everything as one GeoJSON FeatureCollection (RFC 7946, WGS84).
  static Map<String, Object?> toGeoJsonFeatureCollection() {
    return <String, Object?>{
      'type': 'FeatureCollection',
      'features': <Object?>[for (final b in all) b.toGeoJsonFeature()],
    };
  }
}
