// Pins the palika boundary layer (added in 2.8.0):
//  - structural counts of the generated tables,
//  - the 100 KB package-size budget,
//  - metro coverage and Nepal bbox sanity,
//  - losslessness of the decode against the source GeoJSON.
//
// The lossless test reads docs/palika-boundaries.geojson, which .pubignore
// excludes from the *published* package but the repository checkout (and
// therefore CI) always has. The test is skipped when the file is absent.

import 'dart:convert';
import 'dart:io';

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:test/test.dart';

/// GeoJSON coordinates as `[polygon][ring][vertex]`, vertex `[lng, lat]`.
List<List<List<List<double>>>> _asPolys(dynamic coordinates, String type) {
  final rawPolys =
      type == 'Polygon' ? <dynamic>[coordinates] : coordinates as List;
  return [
    for (final poly in rawPolys)
      [
        for (final ring in poly as List)
          [
            for (final v in ring as List)
              [
                ((v as List)[0] as num).toDouble(),
                (v[1] as num).toDouble(),
              ],
          ],
      ],
  ];
}

/// Whether two normalized polygon sets are equal vertex-for-vertex, with
/// coordinates compared at the codec's 1e-9 round-trip tolerance.
bool _polysEqual(
  List<List<List<List<double>>>> a,
  List<List<List<List<double>>>> b,
) {
  if (a.length != b.length) return false;
  for (var p = 0; p < a.length; p++) {
    if (a[p].length != b[p].length) return false;
    for (var g = 0; g < a[p].length; g++) {
      if (a[p][g].length != b[p][g].length) return false;
      for (var v = 0; v < a[p][g].length; v++) {
        if ((a[p][g][v][0] - b[p][g][v][0]).abs() > 1e-9 ||
            (a[p][g][v][1] - b[p][g][v][1]).abs() > 1e-9) {
          return false;
        }
      }
    }
  }
  return true;
}

void main() {
  test('boundary constants are self-consistent', () {
    expect(kPalikaBoundaryFormatVersion, '1');
    expect(kPalikaBoundaryFeatureCount, 753);
    final matchedEntries =
        kPalikaBoundaries.values.fold<int>(0, (n, m) => n + m.length);
    expect(matchedEntries, kPalikaBoundaryMatchedCount);
    expect(
      matchedEntries + kUnmatchedPalikaBoundaries.length,
      kPalikaBoundaryFeatureCount,
      reason: 'matched + unmatched must cover every source feature',
    );
  });

  test('boundary data stays under the 100 KB budget', () {
    final f = File('lib/src/geo/palika_boundaries.dart');
    expect(f.existsSync(), isTrue, reason: 'generated data file is missing');
    expect(
      f.lengthSync(),
      lessThan(100 * 1024),
      reason: 'the pure-Dart boundary payload must stay under 100 KB',
    );
  });

  test('all six metros have boundary polygons', () {
    final metros =
        NepalAdminApi.getLocalBodiesByType(LocalBodyType.metropolitan);
    expect(metros.length, 6);
    for (final m in metros) {
      expect(m.hasBoundary, isTrue, reason: '${m.name} has no boundary');
      expect(m.boundary, isNotNull, reason: '${m.name} failed to decode');
    }
  });

  test('Bharatpur: decode, centroid containment, GeoJSON', () {
    final b = NepalAdminApi.getLocalBodyBoundary('Chitwan', 'Bharatpur');
    expect(b, isNotNull);
    final lb = NepalAdminApi.getLocalBodyByCbs(31304);
    expect(b!.containsPoint(lb!.lat!, lb.lng!), isTrue);
    final feature = b.toGeoJsonFeature();
    expect(feature['type'], 'Feature');
    final geometry = feature['geometry'] as Map<String, Object?>;
    expect(geometry['type'], anyOf('Polygon', 'MultiPolygon'));
  });

  test('lookups are case-insensitive and null for unknown names', () {
    expect(
        NepalAdminApi.getLocalBodyBoundary('chitwan', 'bharatpur'), isNotNull);
    expect(NepalAdminApi.getLocalBodyBoundary('Chitwan', 'Nowhere'), isNull);
    expect(
      NepalAdminApi.getLocalBodyBoundary('Atlantis', 'Bharatpur'),
      isNull,
    );
  });

  test('decoded boundaries sit inside the Nepal bounding box', () {
    for (final b in NepalAdminApi.getAllLocalBodyBoundaries()) {
      final box = b.bbox;
      expect(box['minLat']!, greaterThanOrEqualTo(26.0),
          reason: b.localBodyName);
      expect(box['maxLat']!, lessThanOrEqualTo(31.0), reason: b.localBodyName);
      expect(box['minLng']!, greaterThanOrEqualTo(80.0),
          reason: b.localBodyName);
      expect(box['maxLng']!, lessThanOrEqualTo(89.0), reason: b.localBodyName);
    }
  });

  test('all 753 boundaries decode without leftover characters', () {
    var count = 0;
    for (final b in [
      ...NepalAdminApi.getAllLocalBodyBoundaries(),
      ...NepalAdminApi.getUnmatchedLocalBodyBoundaries(),
    ]) {
      // decode() throws FormatException on truncated or trailing data, so
      // reaching a decoded boundary with coordinates is the assertion.
      expect(b.coordinateCount, greaterThan(0), reason: '$b');
      count++;
    }
    expect(count, 753);
  });

  test('decode is lossless against the source GeoJSON', () {
    final f = File('docs/palika-boundaries.geojson');
    if (!f.existsSync()) {
      // Published-package runs cannot see docs/; the repo checkout has it.
      return;
    }
    final gj = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;

    // A summary signature (ring count, vertex count, first vertex) is not
    // a unique key on this dataset: three pairs of palikas split from the
    // same former VDC (Chaubise/Sangurigadhi, Jantedhunga/Khotehang and
    // Molung/Sunkoshi) share all three values, so a signature-keyed map
    // paired them with each other's geometry. The same coarse key is kept
    // as a bucket, but the match itself is exact (1e-9 per vertex) and
    // consumes the source feature, so each decoded boundary maps to its
    // own geometry.
    final byBucket = <String, List<List<List<List<List<double>>>>>>{};
    for (final raw in (gj['features'] as List).cast<Map<String, dynamic>>()) {
      final geom = raw['geometry'] as Map<String, dynamic>;
      final polys = _asPolys(geom['coordinates'], geom['type'] as String);
      var rings = 0;
      var coords = 0;
      for (final ringsOfPoly in polys) {
        for (final ring in ringsOfPoly) {
          rings++;
          coords += ring.length;
        }
      }
      final first = polys.first.first.first;
      final key = '$rings:$coords:${first[0]}:${first[1]}';
      byBucket.putIfAbsent(key, () => []).add(polys);
    }

    var checked = 0;
    for (final b in [
      ...NepalAdminApi.getAllLocalBodyBoundaries(),
      ...NepalAdminApi.getUnmatchedLocalBodyBoundaries(),
    ]) {
      var rings = 0;
      var coords = 0;
      for (final ringsOfPoly in b.polygons) {
        for (final ring in ringsOfPoly) {
          rings++;
          coords += ring.length;
        }
      }
      final first = b.polygons.first.first.first;
      final key = '$rings:$coords:${first[0]}:${first[1]}';
      final bucket = byBucket[key];
      expect(
        bucket,
        isNotNull,
        reason: 'no source feature matches ${b.localBodyName}',
      );
      final candidates = bucket!;
      final i = candidates.indexWhere((s) => _polysEqual(s, b.polygons));
      expect(
        i,
        greaterThanOrEqualTo(0),
        reason: 'decoded geometry of ${b.localBodyName} matches no source '
            'feature',
      );
      candidates.removeAt(i);
      checked++;
    }
    expect(checked, 753);
  });

  test('boundariesGeoJson emits a full FeatureCollection', () {
    final fc = NepalAdminApi.boundariesGeoJson(includeUnmatched: true);
    expect(fc['type'], 'FeatureCollection');
    expect((fc['features'] as List).length, 753);
    expect(
      (NepalAdminApi.boundariesGeoJson()['features'] as List).length,
      kPalikaBoundaryMatchedCount,
    );
  });

  test('polygon, ring and vertex accounting respects holes', () {
    final simple = NepalAdminApi.getLocalBodyBoundary('Chitwan', 'Bharatpur');
    expect(simple, isNotNull);
    expect(simple!.isSimple, isTrue);
    expect(simple.polygonCount, 1);
    expect(simple.ringCount, 1);
    expect(simple.containsPoint(0, 0), isFalse);

    final holed =
        NepalAdminApi.getLocalBodyBoundary('Rupandehi', 'Lumbini Sanskritik');
    expect(holed, isNotNull);
    expect(holed!.isSimple, isFalse);
    expect(holed.ringCount, 2);
    // The roster centroid is inside the shell and outside the hole.
    expect(holed.containsPoint(27.469, 83.247), isTrue);
    // A point inside the hole is inside no palika of this boundary.
    expect(holed.containsPoint(27.4813, 83.2761), isFalse);
  });

  test('decode rejects malformed boundary strings', () {
    const bad = <String>[
      '*', // not in the VLQ alphabet
      'g', // continuation bit set, then end of string
      'ggggggggggg', // 11 groups: past the 50-bit limit
      'AA', // zero polygons, one trailing character
      'BBA', // one polygon, one ring, zero vertices
    ];
    for (final s in bad) {
      expect(
        () => PalikaBoundary.decode(encoded: s),
        throwsFormatException,
      );
    }
  });

  test('every roster palika has boundary geometry since the centroid fix', () {
    // The 2026-10-26 centroid completion let the point-in-polygon
    // fallback join the last seven upstream spelling variants, so
    // Naraphu — the long-standing honest-null example — now decodes.
    expect(NepalAdminApi.getLocalBodyBoundary('Manang', 'Naraphu'), isNotNull);
    final missing =
        NepalAdminApi.getAllLocalBodies().where((b) => !b.hasBoundary).toList();
    expect(missing.length, 0);
  });
}
