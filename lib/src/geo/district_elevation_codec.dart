// lib/src/geo/district_elevation_codec.dart
//
// Typed access for the district elevation stats generated into
// district_elevation.dart (format version 1).
//
// Each row is 'nameEn|nameNe|elevMin|elevMean|elevMax' in integer metres,
// computed from Copernicus GLO-30 (30 m, frozen 2021 release) zonal
// statistics over the official district polygons. The DEM itself is not
// redistributed — only these per-district statistics are. See NOTICE for
// the required attribution.

import 'district_elevation.dart';

/// Elevation statistics for one district, in integer metres.
typedef DistrictElevationStats = ({
  String districtId,
  String nameEn,
  String nameNe,
  int elevMin,
  int elevMean,
  int elevMax,
});

/// Lookups over the generated district elevation table.
abstract final class DistrictElevations {
  /// Elevation stats for a district by geometry id (e.g. 'P3.D05'), or
  /// null when not present. Case-insensitive.
  static DistrictElevationStats? byDistrictId(String id) {
    final key = _ciKey(kDistrictElevations.keys, id);
    if (key == null) return null;
    return _decode(key);
  }

  /// Elevation stats for a district by roster name (e.g. 'Kathmandu'),
  /// case-insensitive, or null when not present.
  static DistrictElevationStats? byName(String name) {
    final key = _nameKey(name);
    if (key == null) return null;
    return _decode(key);
  }

  /// Whether the elevation table covers this district id or name.
  static bool hasStats(String districtIdOrName) {
    return _ciKey(kDistrictElevations.keys, districtIdOrName) != null ||
        _nameKey(districtIdOrName) != null;
  }

  /// All 77 district elevation records, in district-id order.
  static List<DistrictElevationStats> get all => <DistrictElevationStats>[
        for (final key in kDistrictElevations.keys) _decode(key),
      ];

  /// Everything as one GeoJSON FeatureCollection (RFC 7946, WGS84),
  /// mirroring bindings/geojson/districts.elevation.geojson feature for
  /// feature (geometry null).
  static Map<String, Object?> toGeoJsonFeatureCollection() {
    return <String, Object?>{
      'type': 'FeatureCollection',
      'features': <Object?>[for (final s in all) _toFeature(s)],
    };
  }

  static DistrictElevationStats _decode(String key) {
    final row = kDistrictElevations[key]!;
    final parts = row.split('|');
    return (
      districtId: key,
      nameEn: parts[0],
      nameNe: parts[1],
      elevMin: int.parse(parts[2]),
      elevMean: int.parse(parts[3]),
      elevMax: int.parse(parts[4]),
    );
  }

  static Map<String, Object?> _toFeature(DistrictElevationStats s) {
    return <String, Object?>{
      'type': 'Feature',
      'geometry': null,
      'properties': <String, Object?>{
        'districtId': s.districtId,
        'nameEn': s.nameEn,
        'nameNe': s.nameNe,
        'elevMin': s.elevMin,
        'elevMean': s.elevMean,
        'elevMax': s.elevMax,
      },
    };
  }

  static String? _nameKey(String name) {
    final lower = name.toLowerCase();
    for (final e in kDistrictElevations.entries) {
      if (e.value.split('|')[0].toLowerCase() == lower) return e.key;
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
