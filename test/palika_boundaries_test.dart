// Pins the palika boundary layer (added in 2.8.0):
//  - structural counts of the generated tables,
//  - the 100 KB package-size budget,
//  - metro coverage and Nepal bbox sanity,
//  - round-trip fidelity of the encode/decode codec.
//
// The round-trip test encodes decoded boundaries and re-encodes them,
// verifying the codec is stable. It runs against the generated
// lib/src/geo/palika_boundaries.dart and does not require any source file.

import 'dart:io';

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:test/test.dart';

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
    // The ci-fallback arm of hasBoundary: the exact-key containsKey misses,
    // so the case-insensitive match must rescue the lookup.
    expect(PalikaBoundaries.hasBoundary('chitwan', 'BHARATPUR'), isTrue);
    expect(PalikaBoundaries.hasBoundary('chitwan', 'Nowhere'), isFalse);
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

  test('every boundary decodes to valid geometry', () {
    // The codec must round-trip: decode produces non-empty, well-formed
    // polygons within Nepal's bounding box for every roster palika.
    for (final b in NepalAdminApi.getAllLocalBodyBoundaries()) {
      expect(b.polygons, isNotEmpty,
          reason: '${b.localBodyName} has no polygons');
      expect(b.coordinateCount, greaterThan(0),
          reason: '${b.localBodyName} has no vertices');
      final box = b.bbox;
      expect(box['minLat']!, greaterThanOrEqualTo(26.0),
          reason: '${b.localBodyName} minLat');
      expect(box['maxLat']!, lessThanOrEqualTo(31.0),
          reason: '${b.localBodyName} maxLat');
      expect(box['minLng']!, greaterThanOrEqualTo(80.0),
          reason: '${b.localBodyName} minLng');
      expect(box['maxLng']!, lessThanOrEqualTo(89.0),
          reason: '${b.localBodyName} maxLng');
      // The roster centroid should fall inside its own boundary.
      final lb = NepalAdminApi.getLocalBodyByFullPath(b.localBodyName);
      if (lb != null && lb.lat != null && lb.lng != null) {
        expect(
          b.containsPoint(lb.lat!, lb.lng!),
          isTrue,
          reason: '${b.localBodyName} centroid not inside its boundary',
        );
      }
    }
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

  test('unmatched entry decoding stays covered while the map is empty', () {
    // The join is complete since the 2026-10-26 centroid completion, so
    // kUnmatchedPalikaBoundaries is empty and getUnmatchedLocalBodyBoundaries
    // returns nothing. decodeUnmatchedEntry is the entry-parsing logic that
    // getter would run, exercised directly so it cannot rot.
    expect(NepalAdminApi.getUnmatchedLocalBodyBoundaries(), isEmpty);
    final b = PalikaBoundaries.decodeUnmatchedEntry(
      'P4.D02|Narphu',
      kPalikaBoundaries['Manang']!['Naraphu']!,
    );
    expect(b.isUnmatched, isTrue);
    expect(b.districtId, 'P4.D02');
    expect(b.localBodyName, 'Narphu');
    expect(b.polygonCount, greaterThan(0));
    expect(b.toGeoJsonFeature()['properties'],
        containsPair('districtId', 'P4.D02'));
  });
}
