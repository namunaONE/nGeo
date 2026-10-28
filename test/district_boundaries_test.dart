// Pins the district boundary layer (77 districts, official portal export):
//  - structural counts of the generated tables,
//  - lookups by geometry id and by roster name,
//  - full coverage: all 77 districts decode, sit inside Nepal and
//    contain verified ground-truth points,
//  - GeoJSON export of the whole collection.

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:test/test.dart';

void main() {
  test('district boundary constants are self-consistent', () {
    expect(kDistrictBoundaryFormatVersion, '1');
    expect(kDistrictBoundaryFeatureCount, 77);
    expect(kDistrictBoundaries.length, 77);
    expect(kDistrictBoundaryNames.length, 77);
    for (final key in kDistrictBoundaries.keys) {
      expect(kDistrictBoundaryNames, contains(key));
    }
  });

  test('districts resolve by geometry id and by name', () {
    final byId = DistrictBoundaries.byDistrictId('P3.D05');
    expect(byId, isNotNull);
    expect(byId!.districtName, 'Kathmandu');
    expect(byId.districtId, 'P3.D05');
    final byName = DistrictBoundaries.byName('Kathmandu');
    expect(byName, isNotNull);
    expect(byName!.districtId, 'P3.D05');
    // Case-insensitive in both directions.
    expect(DistrictBoundaries.byDistrictId('p3.d05'), isNotNull);
    expect(DistrictBoundaries.byName('kAthmAndu'), isNotNull);
    // Unknowns of every shape.
    expect(DistrictBoundaries.byDistrictId('P3.D99'), isNull);
    expect(DistrictBoundaries.byDistrictId('Atlantis'), isNull);
    expect(DistrictBoundaries.byName('Atlantis'), isNull);
    expect(DistrictBoundaries.byName(''), isNull);
  });

  test('the API surface mirrors the codec lookups', () {
    final b = NepalAdminApi.getDistrictBoundary('P3.D05');
    expect(b, isNotNull);
    expect(b!.districtName, 'Kathmandu');
    // Name arm of the same method.
    expect(NepalAdminApi.getDistrictBoundary('chitwan')!.districtName,
        'Chitwan');
    expect(NepalAdminApi.getDistrictBoundary('Bharatpur'), isNull);
    expect(NepalAdminApi.hasDistrictBoundary('P3.D05'), isTrue);
    expect(NepalAdminApi.hasDistrictBoundary('kathmandu'), isTrue);
    expect(NepalAdminApi.hasDistrictBoundary('P3.D99'), isFalse);
    expect(NepalAdminApi.hasDistrictBoundary('Atlantis'), isFalse);
    expect(NepalAdminApi.getAllDistrictBoundaries().length, 77);
  });

  test('getAllDistrictBoundaries returns all 77, in id order', () {
    final all = NepalAdminApi.getAllDistrictBoundaries();
    expect(all.length, 77);
    expect(DistrictBoundaries.all.length, 77);
    final ids = <String>[
      for (final b in all) b.districtId,
    ];
    final sorted = <String>[...ids]..sort();
    expect(ids, orderedEquals(sorted));
    for (final b in all) {
      expect(b.polygonCount, greaterThan(0), reason: b.districtName);
      expect(b.coordinateCount, greaterThan(0), reason: b.districtName);
      expect(b.districtName, isNotEmpty);
    }
  });

  test('district boundaries sit inside the Nepal bounding box', () {
    for (final b in NepalAdminApi.getAllDistrictBoundaries()) {
      final box = b.bbox;
      expect(box['minLat']!, greaterThanOrEqualTo(26.0),
          reason: b.districtName);
      expect(box['maxLat']!, lessThanOrEqualTo(31.0), reason: b.districtName);
      expect(box['minLng']!, greaterThanOrEqualTo(80.0),
          reason: b.districtName);
      expect(box['maxLng']!, lessThanOrEqualTo(89.0), reason: b.districtName);
      // A point far outside Nepal is inside no district.
      expect(b.containsPoint(0, 0), isFalse, reason: b.districtName);
    }
  });

  test('verified ground-truth points fall inside their own district', () {
    // Kathmandu city centre -> Kathmandu (P3.D05).
    final ktm = NepalAdminApi.getDistrictBoundary('P3.D05');
    expect(ktm!.containsPoint(27.7172, 85.3240), isTrue);
    // Bharatpur -> Chitwan (P3.D02), via the name arm.
    final chitwan = NepalAdminApi.getDistrictBoundary('Chitwan');
    expect(chitwan!.districtId, 'P3.D02');
    expect(chitwan.containsPoint(27.6857, 84.4333), isTrue);
    // Pokhara -> Kaski (P4.D03).
    final kaski = NepalAdminApi.getDistrictBoundary('Kaski');
    expect(kaski!.containsPoint(28.2096, 83.9856), isTrue);
    // The far-west Limpiyadhura corner -> Darchula (P7.D06): both the
    // Lipulekh pass and Kalapani sit inside the district polygon.
    final darchula = NepalAdminApi.getDistrictBoundary('Darchula');
    expect(darchula!.districtId, 'P7.D06');
    expect(darchula.containsPoint(30.222, 81.023), isTrue);
    expect(darchula.containsPoint(30.20, 80.95), isTrue);
  });

  test('districtBoundariesGeoJson emits a full FeatureCollection', () {
    final fc = NepalAdminApi.districtBoundariesGeoJson();
    expect(fc['type'], 'FeatureCollection');
    expect((fc['features'] as List).length, 77);
    final codec = DistrictBoundaries.toGeoJsonFeatureCollection();
    expect(codec['type'], 'FeatureCollection');
    expect((codec['features'] as List).length, 77);
    for (final feature in codec['features'] as List) {
      final geometry = (feature as Map)['geometry'] as Map;
      expect(geometry['type'], anyOf('Polygon', 'MultiPolygon'));
    }
  });
}