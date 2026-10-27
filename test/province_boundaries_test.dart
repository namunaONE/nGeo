// Pins the provincial boundary layer added with the high-res boundary
// upgrade (National Geoportal source):
//  - structural counts of the generated tables,
//  - lookups by ISO code, numeric code and roster id,
//  - full coverage: all seven provinces decode, sit inside Nepal and
//    contain roster centroids,
//  - GeoJSON export of the whole collection.

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:test/test.dart';

void main() {
  test('province boundary constants are self-consistent', () {
    expect(kProvinceBoundaryFormatVersion, '1');
    expect(kProvinceBoundaryFeatureCount, 7);
    expect(kProvinceBoundaries.length, 7);
    expect(kProvinceBoundaryNames.length, 7);
  });

  test('all seven provinces resolve by ISO code and by numeric code', () {
    for (var code = 1; code <= 7; code++) {
      final byIso = NepalAdminApi.getProvinceBoundary('NP-P$code');
      expect(byIso, isNotNull, reason: 'NP-P$code has no boundary');
      final byCode = NepalAdminApi.getProvinceBoundary('$code');
      expect(byCode, isNotNull, reason: '$code has no boundary');
      expect(byIso!.localBodyName, kProvinceBoundaryNames[code]);
      expect(byCode!.localBodyName, kProvinceBoundaryNames[code]);
      expect(NepalAdminApi.hasProvinceBoundary('NP-P$code'), isTrue);
      expect(NepalAdminApi.hasProvinceBoundary('$code'), isTrue);
    }
  });

  test('province lookups are case-insensitive and null for unknowns', () {
    expect(NepalAdminApi.getProvinceBoundary('np-p3'), isNotNull);
    expect(NepalAdminApi.getProvinceBoundary('3')!.localBodyName,
        kProvinceBoundaryNames[3]);
    // The roster arm: resolve by province id, then join via the CBS code.
    expect(NepalAdminApi.getProvinceBoundary('bagmati'), isNotNull);
    expect(NepalAdminApi.hasProvinceBoundary('bagmati'), isTrue);
    // Unknowns of every shape.
    expect(NepalAdminApi.getProvinceBoundary('Atlantis'), isNull);
    expect(NepalAdminApi.getProvinceBoundary('8'), isNull);
    expect(NepalAdminApi.getProvinceBoundary('0'), isNull);
    expect(NepalAdminApi.getProvinceBoundary(''), isNull);
    expect(NepalAdminApi.hasProvinceBoundary('Atlantis'), isFalse);
    expect(NepalAdminApi.hasProvinceBoundary('8'), isFalse);
    // The codec level: direct table lookups.
    expect(ProvinceBoundaries.byIso('NP-P9'), isNull);
    expect(ProvinceBoundaries.byCode(9), isNull);
    expect(ProvinceBoundaries.hasBoundary('NP-P9'), isFalse);
    expect(ProvinceBoundaries.hasBoundary('NP-P3'), isTrue);
  });

  test('getAllProvinceBoundaries returns all seven, in code order', () {
    final all = NepalAdminApi.getAllProvinceBoundaries();
    expect(all.length, 7);
    expect(ProvinceBoundaries.all.length, 7);
    final names = <String>[
      for (final b in all) b.localBodyName,
    ];
    final expected = <String>[
      for (var code = 1; code <= 7; code++) kProvinceBoundaryNames[code]!,
    ];
    expect(names, expected);
    for (final b in all) {
      expect(b.polygonCount, greaterThan(0), reason: b.localBodyName);
      expect(b.coordinateCount, greaterThan(0), reason: b.localBodyName);
    }
  });

  test('decoded provincial boundaries sit inside the Nepal bounding box',
    () {
    for (final b in NepalAdminApi.getAllProvinceBoundaries()) {
      final box = b.bbox;
      expect(box['minLat']!, greaterThanOrEqualTo(26.0),
          reason: b.localBodyName);
      expect(box['maxLat']!, lessThanOrEqualTo(31.0), reason: b.localBodyName);
      expect(box['minLng']!, greaterThanOrEqualTo(80.0),
          reason: b.localBodyName);
      expect(box['maxLng']!, lessThanOrEqualTo(89.0), reason: b.localBodyName);
      // A point far outside Nepal is inside no province.
      expect(b.containsPoint(0, 0), isFalse, reason: b.localBodyName);
    }
  });

  test('roster centroids fall inside their own province boundary', () {
    const cases = <int, String>{
      31304: 'NP-P3', // Bharatpur, Chitwan -> Bagmati
      40504: 'NP-P4', // Pokhara, Kaski -> Gandaki
    };
    for (final entry in cases.entries) {
      final lb = NepalAdminApi.getLocalBodyByCbs(entry.key);
      expect(lb, isNotNull, reason: '${entry.key} missing from the roster');
      final b = NepalAdminApi.getProvinceBoundary(entry.value);
      expect(b, isNotNull, reason: '${entry.value} has no boundary');
      expect(b!.containsPoint(lb!.lat!, lb.lng!), isTrue,
          reason: '${entry.value} should contain ${lb.name}');
    }
  });

  test('provinceBoundariesGeoJson emits a full FeatureCollection', () {
    final fc = NepalAdminApi.provinceBoundariesGeoJson();
    expect(fc['type'], 'FeatureCollection');
    expect((fc['features'] as List).length, 7);
    final codec = ProvinceBoundaries.toGeoJsonFeatureCollection();
    expect(codec['type'], 'FeatureCollection');
    expect((codec['features'] as List).length, 7);
    for (final feature in codec['features'] as List) {
      final geometry = (feature as Map)['geometry'] as Map;
      expect(geometry['type'], anyOf('Polygon', 'MultiPolygon'));
    }
  });
}
