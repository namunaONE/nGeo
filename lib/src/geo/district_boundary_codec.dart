// lib/src/geo/district_boundary_codec.dart
//
// Decoder and typed access for the district boundary strings generated into
// district_boundaries.dart (format version 1, identical to palika
// boundaries).
//
// Districts are a strict subset of the palika boundary format (one polygon
// per district), so we reuse PalikaBoundary's decode and point-in-polygon
// logic rather than duplicating it.

import 'district_boundaries.dart';
import 'palika_boundary_codec.dart';

/// A decoded district boundary. Alias of [PalikaBoundary] — same format,
/// same decode, same containment test.
typedef DistrictBoundary = PalikaBoundary;

/// Lookups over the generated district boundary tables.
abstract final class DistrictBoundaries {
  /// Boundary for a district by geometry id (e.g. 'P3.D05'), or null when
  /// not present. Case-insensitive.
  static DistrictBoundary? byDistrictId(String id) {
    final key = _ciKey(kDistrictBoundaries.keys, id);
    if (key == null) return null;
    return _decode(key);
  }

  /// Boundary for a district by roster name (e.g. 'Kathmandu'),
  /// case-insensitive, or null when not present.
  static DistrictBoundary? byName(String name) {
    final key = _nameKey(name);
    if (key == null) return null;
    return _decode(key);
  }

  /// Whether the geometry table covers this district id or name.
  ///
  /// Cheaper than [byDistrictId]: no decoding happens.
  static bool hasBoundary(String districtIdOrName) {
    return _ciKey(kDistrictBoundaries.keys, districtIdOrName) != null ||
        _nameKey(districtIdOrName) != null;
  }

  /// All 77 district boundaries, decoded, in district-id order.
  static List<DistrictBoundary> get all => <DistrictBoundary>[
        for (final key in kDistrictBoundaries.keys) _decode(key),
      ];

  /// Everything as one GeoJSON FeatureCollection (RFC 7946, WGS84).
  static Map<String, Object?> toGeoJsonFeatureCollection() {
    return <String, Object?>{
      'type': 'FeatureCollection',
      'features': <Object?>[for (final b in all) b.toGeoJsonFeature()],
    };
  }

  static DistrictBoundary _decode(String key) {
    return DistrictBoundary.decode(
      districtName: kDistrictBoundaryNames[key] ?? '',
      districtId: key,
      encoded: kDistrictBoundaries[key]!,
    );
  }

  static String? _nameKey(String name) {
    final lower = name.toLowerCase();
    for (final e in kDistrictBoundaryNames.entries) {
      if (e.value.toLowerCase() == lower) return e.key;
    }
    return null;
  }

  static String? _ciKey(Iterable<String> keys, String target) {
    final t = target.toLowerCase();
    for (final k in keys) {
      if (k.toLowerCase() == t) return k;
    }
    return null;
  }
}
