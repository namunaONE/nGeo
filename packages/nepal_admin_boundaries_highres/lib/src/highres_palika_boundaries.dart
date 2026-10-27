// lib/src/highres_palika_boundaries.dart
//
// Lookups over the high-resolution boundary tables shipped by this package.
//
// Mirrors nepal_admin_api's `PalikaBoundaries` API, but backed by the
// ~75k-vertex high-resolution geometry (Douglas-Peucker eps 0.001 deg)
// instead of the ~17k-vertex simplified set in the core package.
//
// Boundaries are decoded on demand, never cached.

import 'package:nepal_admin_api/nepal_admin_api.dart';

import 'highres_boundaries_data.dart';

/// Lookups over the high-resolution palika boundary tables.
abstract final class HighResPalikaBoundaries {
  /// Boundary for a roster palika, or null when the geometry source does not
  /// cover it or the district/name pair is unknown.
  ///
  /// Lookups are case-insensitive; names use the roster spelling.
  static PalikaBoundary? byName(String districtName, String localBodyName) {
    final district = _findDistrict(districtName);
    if (district == null) return null;
    final palikas = kHighResPalikaBoundaries[district]!;
    String? key = palikas.containsKey(localBodyName)
        ? localBodyName
        : _ciKey(palikas.keys, localBodyName);
    if (key == null) return null;
    return PalikaBoundary.decode(
      districtName: district,
      localBodyName: key,
      encoded: palikas[key]!,
    );
  }

  /// Whether the high-resolution geometry source covers this district/name pair.
  static bool hasBoundary(String districtName, String localBodyName) {
    final district = _findDistrict(districtName);
    if (district == null) return false;
    final palikas = kHighResPalikaBoundaries[district]!;
    return palikas.containsKey(localBodyName) ||
        _ciKey(palikas.keys, localBodyName) != null;
  }

  /// All high-resolution boundaries joined to roster entries, in roster order.
  static List<PalikaBoundary> get all => <PalikaBoundary>[
        for (final district in kHighResPalikaBoundaries.entries)
          for (final palika in district.value.entries)
            PalikaBoundary.decode(
              districtName: district.key,
              localBodyName: palika.key,
              encoded: palika.value,
            ),
      ];

  /// The features that failed the join (empty on current data).
  static List<PalikaBoundary> get unmatched {
    final out = <PalikaBoundary>[];
    for (final e in kHighResUnmatchedPalikaBoundaries.entries) {
      out.add(decodeUnmatchedEntry(e.key, e.value));
    }
    return out;
  }

  /// Decodes one unmatched entry keyed `districtId|sourceName`.
  static PalikaBoundary decodeUnmatchedEntry(String key, String encoded) {
    final i = key.indexOf('|');
    return PalikaBoundary.decode(
      districtId: key.substring(0, i),
      localBodyName: key.substring(i + 1),
      encoded: encoded,
    );
  }

  /// Everything as one GeoJSON FeatureCollection (RFC 7946, WGS84).
  static Map<String, Object?> toGeoJsonFeatureCollection({
    bool includeUnmatched = false,
  }) {
    return <String, Object?>{
      'type': 'FeatureCollection',
      'features': <Object?>[
        for (final b in all) b.toGeoJsonFeature(),
        if (includeUnmatched)
          for (final b in unmatched) b.toGeoJsonFeature(),
      ],
    };
  }

  static String? _findDistrict(String name) {
    if (kHighResPalikaBoundaries.containsKey(name)) return name;
    return _ciKey(kHighResPalikaBoundaries.keys, name);
  }

  static String? _ciKey(Iterable<String> keys, String target) {
    final t = target.toLowerCase();
    for (final k in keys) {
      if (k.toLowerCase() == t) return k;
    }
    return null;
  }
}

/// Boundary access directly on a [LocalBody], high-resolution variant.
extension LocalBodyHighResBoundaryX on LocalBody {
  /// This palika's high-resolution boundary polygon, or null when the geometry
  /// source does not cover it. Decoded on access.
  PalikaBoundary? get boundaryHighRes =>
      HighResPalikaBoundaries.byName(districtName, name);

  /// Whether the high-resolution geometry source covers this palika.
  bool get hasHighResBoundary =>
      HighResPalikaBoundaries.hasBoundary(districtName, name);
}
