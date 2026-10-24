// lib/src/geo/palika_boundary_codec.dart
//
// Decoder and typed access for the palika boundary strings generated into
// palika_boundaries.dart (format version 1).
//
// Format v1, in one screenful:
//  - alphabet: standard base64 index 0..63
//    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
//  - every non-negative integer is a VLQ: 5-bit little-endian groups with a
//    continuation bit (0x20) set on all but the last digit
//  - signed deltas are zigzagged: v >= 0 ? 2 * v : -2 * v - 1
//  - coordinates are quantised to 1e-4 degrees (~11 m at Nepal's latitude)
//  - a palika string is VLQ(polygonCount), then per polygon
//    VLQ(ringCount), then per ring VLQ(vertexCount) followed by vertexCount
//    (lat, lng) pairs. The first pair of the palika is absolute; every later
//    pair is a delta from the previous vertex, chained across rings and
//    polygons.
//  - rings are stored open; the decoder re-appends the first vertex to close
//    each ring (RFC 7946). The quantised round trip is bit-exact.
//
// The whole 753-palika layer costs ~68 KB of encoded geometry; the
// generated file stays under the 100 KB budget pinned in tests.

import 'palika_boundaries.dart';

/// A decoded boundary polygon set for one local body (palika).
///
/// Constructed lazily by [decode] — never stored decoded, so the package
/// payload stays at its encoded size until a caller actually asks for
/// geometry.
class PalikaBoundary {
  /// Roster district name, e.g. `'Chitwan'`.
  ///
  /// Empty when this boundary could not be joined to a roster entry
  /// (see [isUnmatched]); the source [districtId] is set instead.
  final String districtName;

  /// Roster local-body name, e.g. `'Bharatpur'`, or the geometry source's
  /// English name when [isUnmatched].
  final String localBodyName;

  /// Geometry-source district id, e.g. `'P5.D03'`.
  ///
  /// Empty for boundaries matched to the roster.
  final String districtId;

  /// Polygons as `[polygon][ring][vertex]`, each vertex `[lng, lat]`
  /// (GeoJSON order, WGS84). Rings are closed: first vertex == last vertex.
  final List<List<List<List<double>>>> polygons;

  const PalikaBoundary._({
    required this.districtName,
    required this.localBodyName,
    required this.districtId,
    required this.polygons,
  });

  /// Whether this boundary failed both the name join and the
  /// point-in-polygon join against the canonical roster.
  bool get isUnmatched => districtName.isEmpty;

  /// Number of polygons (1 for a simple palika, more for disjoint areas).
  int get polygonCount => polygons.length;

  /// Total ring count across all polygons (outer rings plus holes).
  int get ringCount =>
      polygons.fold<int>(0, (n, p) => n + p.length);

  /// Total coordinate count, ring closures included.
  int get coordinateCount => polygons.fold<int>(
        0,
        (n, p) =>
            n + p.fold<int>(0, (m, r) => m + r.length),
      );

  /// Whether this palika is drawn as one polygon without holes.
  bool get isSimple => polygonCount == 1 && polygons[0].length == 1;

  /// Bounding box as `{'minLat', 'maxLat', 'minLng', 'maxLng'}`.
  Map<String, double> get bbox {
    var minLat = 90.0, maxLat = -90.0, minLng = 180.0, maxLng = -180.0;
    for (final rings in polygons) {
      for (final ring in rings) {
        for (final v in ring) {
          final lat = v[1], lng = v[0];
          if (lat < minLat) minLat = lat;
          if (lat > maxLat) maxLat = lat;
          if (lng < minLng) minLng = lng;
          if (lng > maxLng) maxLng = lng;
        }
      }
    }
    return {
      'minLat': minLat,
      'maxLat': maxLat,
      'minLng': minLng,
      'maxLng': maxLng,
    };
  }

  /// Point-in-polygon test against the outer rings, holes respected.
  ///
  /// Boundary points are not guaranteed either way (ray casting on a
  /// quantised ring); use this for 'which palika is this inside', not for
  /// edge-exact surveying.
  bool containsPoint(double lat, double lng) {
    for (final rings in polygons) {
      if (rings.isEmpty) continue;
      if (_pointInRing(lat, lng, rings.first)) {
        var inHole = false;
        for (var i = 1; i < rings.length; i++) {
          if (_pointInRing(lat, lng, rings[i])) {
            inHole = true;
            break;
          }
        }
        if (!inHole) return true;
      }
    }
    return false;
  }

  /// This boundary as a GeoJSON feature (RFC 7946, WGS84).
  ///
  /// Geometry is a `Polygon` when there is exactly one polygon, a
  /// `MultiPolygon` otherwise. Properties carry the roster names, plus
  /// `districtId` and `nameEn` for unmatched features.
  Map<String, Object?> toGeoJsonFeature() => <String, Object?>{
        'type': 'Feature',
        'properties': <String, Object?>{
          'district': districtName,
          'localBody': localBodyName,
          if (isUnmatched) 'districtId': districtId,
          'matched': !isUnmatched,
        },
        'geometry': <String, Object?>{
          'type': polygonCount == 1 ? 'Polygon' : 'MultiPolygon',
          'coordinates':
              polygonCount == 1 ? polygons.first : polygons,
        },
      };

  @override
  String toString() {
    final who = isUnmatched
        ? '$localBodyName ($districtId, unmatched)'
        : '$localBodyName, $districtName';
    return 'PalikaBoundary($who, '
        '$polygonCount polygon(s), $coordinateCount coordinates)';
  }

  /// Decodes one palika boundary string (format version 1).
  ///
  /// All name parameters are optional so unmatched features can be decoded
  /// with only their source identifiers; `encoded` is required.
  static PalikaBoundary decode({
    String districtName = '',
    String localBodyName = '',
    String districtId = '',
    required String encoded,
  }) {
    final r = _Reader(encoded);
    final nPolys = r.vlq();
    final polys = <List<List<List<double>>>>[];
    var curLat = 0, curLng = 0;
    var anchored = false;
    for (var p = 0; p < nPolys; p++) {
      final nRings = r.vlq();
      final rings = <List<List<double>>>[];
      for (var g = 0; g < nRings; g++) {
        final n = r.vlq();
        final ring = <List<double>>[];
        for (var i = 0; i < n; i++) {
          if (anchored) {
            curLat += r.zigzagVlq();
            curLng += r.zigzagVlq();
          } else {
            curLat = r.zigzagVlq();
            curLng = r.zigzagVlq();
            anchored = true;
          }
          ring.add([curLng / 1e4, curLat / 1e4]);
        }
        if (ring.isEmpty) {
          throw FormatException('Empty ring in boundary string', encoded);
        }
        // Close the ring (RFC 7946); the encoder dropped this vertex.
        ring.add([ring.first[0], ring.first[1]]);
        rings.add(ring);
      }
      polys.add(rings);
    }
    if (r.remaining != 0) {
      throw FormatException(
        'Boundary string has ${r.remaining} trailing character(s)',
        encoded,
      );
    }
    return PalikaBoundary._(
      districtName: districtName,
      localBodyName: localBodyName,
      districtId: districtId,
      polygons: polys,
    );
  }

  static bool _pointInRing(double lat, double lng, List<List<double>> ring) {
    var inside = false;
    for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
      final xi = ring[i][0], yi = ring[i][1];
      final xj = ring[j][0], yj = ring[j][1];
      if ((yi > lat) != (yj > lat) &&
          lng < (xj - xi) * (lat - yi) / (yj - yi) + xi) {
        inside = !inside;
      }
    }
    return inside;
  }
}

/// Lookups over the generated boundary tables.
///
/// Boundaries are decoded on demand, never cached: decoding a palika is a
/// microsecond-scale operation and callers that iterate everything can
/// keep their own copy of [PalikaBoundary].
abstract final class PalikaBoundaries {
  /// Boundary for a roster palika, or null when the geometry source does
  /// not cover it (7 of 753) or the district/name pair is unknown.
  ///
  /// Lookups are case-insensitive; names use the roster spelling, e.g.
  /// `PalikaBoundaries.byName('Chitwan', 'Bharatpur')`.
  static PalikaBoundary? byName(
    String districtName,
    String localBodyName,
  ) {
    final district = _findDistrict(districtName);
    if (district == null) return null;
    final palikas = kPalikaBoundaries[district]!;
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

  /// Whether the geometry source covers this district/name pair.
  ///
  /// Cheaper than [byName]: no decoding happens.
  static bool hasBoundary(String districtName, String localBodyName) {
    final district = _findDistrict(districtName);
    if (district == null) return false;
    final palikas = kPalikaBoundaries[district]!;
    return palikas.containsKey(localBodyName) ||
        _ciKey(palikas.keys, localBodyName) != null;
  }

  /// All boundaries joined to roster entries (746 of 753), in roster order.
  static List<PalikaBoundary> get all => <PalikaBoundary>[
        for (final district in kPalikaBoundaries.entries)
          for (final palika in district.value.entries)
            PalikaBoundary.decode(
              districtName: district.key,
              localBodyName: palika.key,
              encoded: palika.value,
            ),
      ];

  /// The features that failed both the name join and the
  /// point-in-polygon join (7 of 753), in `districtId` order.
  ///
  /// These are spelling variants between the geometry source and the
  /// roster (e.g. 'Narphu' vs 'Naraphu'); they are published under their
  /// source names rather than guessed.
  static List<PalikaBoundary> get unmatched => <PalikaBoundary>[
        for (final e in kUnmatchedPalikaBoundaries.entries)
          PalikaBoundary.decode(
            districtId: e.key.substring(0, e.key.indexOf('|')),
            localBodyName: e.key.substring(e.key.indexOf('|') + 1),
            encoded: e.value,
          ),
      ];

  /// Everything as one GeoJSON FeatureCollection (RFC 7946, WGS84).
  ///
  /// With [includeUnmatched] the unjoined features are appended with
  /// their source `districtId` and `nameEn`, so no geometry is lost.
  static Map<String, Object?> toGeoJsonFeatureCollection({
    bool includeUnmatched = false,
  }) =>
      <String, Object?>{
        'type': 'FeatureCollection',
        'features': <Object?>[
          for (final b in all) b.toGeoJsonFeature(),
          if (includeUnmatched)
            for (final b in unmatched) b.toGeoJsonFeature(),
        ],
      };

  static String? _findDistrict(String name) {
    if (kPalikaBoundaries.containsKey(name)) return name;
    return _ciKey(kPalikaBoundaries.keys, name);
  }

  static String? _ciKey(Iterable<String> keys, String target) {
    final t = target.toLowerCase();
    for (final k in keys) {
      if (k.toLowerCase() == t) return k;
    }
    return null;
  }
}

/// Cursor over one encoded palika string.
class _Reader {
  final String _s;
  var _pos = 0;

  _Reader(this._s);

  int get remaining => _s.length - _pos;

  /// Reads one VLQ integer (non-negative).
  int vlq() {
    var result = 0;
    var shift = 0;
    int digit;
    do {
      if (_pos >= _s.length) {
        throw const FormatException('Truncated VLQ');
      }
      digit = _digit(_s.codeUnitAt(_pos++));
      result += (digit & 31) << shift;
      shift += 5;
      if (shift > 50) {
        throw const FormatException('VLQ longer than 50 bits');
      }
    } while (digit & 32 != 0);
    return result;
  }

  /// Reads one VLQ integer and un-zigzags it into a signed delta.
  int zigzagVlq() {
    final u = vlq();
    return (u & 1) == 1 ? -((u + 1) >> 1) : u >> 1;
  }

  static int _digit(int unit) {
    if (unit >= 65 && unit <= 90) return unit - 65; // A-Z
    if (unit >= 97 && unit <= 122) return unit - 97 + 26; // a-z
    if (unit >= 48 && unit <= 57) return unit - 48 + 52; // 0-9
    if (unit == 43) return 62; // +
    if (unit == 47) return 63; // /
    throw const FormatException('Invalid VLQ character');
  }
}
