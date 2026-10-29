// Pins the district elevation layer (77 districts, Copernicus GLO-30):
//  - structural counts and row shape of the generated table,
//  - lookups by geometry id and by roster name,
//  - monotonicity (min <= mean <= max) and sanity bounds for every row,
//  - measured anchors against known ground truth,
//  - the join to the roster and the boundary layer in both directions,
//  - GeoJSON export of the whole collection.

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:test/test.dart';

void main() {
  test('district elevation constants are self-consistent', () {
    expect(kDistrictElevationFormatVersion, '1');
    expect(kDistrictElevationFeatureCount, 77);
    expect(kDistrictElevations.length, 77);
    // Every row carries exactly five fields.
    for (final row in kDistrictElevations.values) {
      expect(row.split('|').length, 5, reason: row);
    }
  });

  test('elevations resolve by geometry id and by name', () {
    final byId = DistrictElevations.byDistrictId('P3.D05');
    expect(byId, isNotNull);
    expect(byId!.nameEn, 'Kathmandu');
    expect(byId.nameNe, 'काठमाडौं');
    expect(byId.elevMin, 1169);
    expect(byId.elevMean, 1575);
    expect(byId.elevMax, 2705);
    final byName = DistrictElevations.byName('Kathmandu');
    expect(byName, isNotNull);
    expect(byName!.districtId, 'P3.D05');
    // Case-insensitive in both directions.
    expect(DistrictElevations.byDistrictId('p3.d05'), isNotNull);
    expect(DistrictElevations.byName('kAthmAndu'), isNotNull);
    // Unknowns of every shape.
    expect(DistrictElevations.byDistrictId('P3.D99'), isNull);
    expect(DistrictElevations.byDistrictId('Atlantis'), isNull);
    expect(DistrictElevations.byName('Atlantis'), isNull);
    expect(DistrictElevations.byName(''), isNull);
  });

  test('the API surface mirrors the codec lookups', () {
    final s = NepalAdminApi.getDistrictElevationStats('P3.D05');
    expect(s, isNotNull);
    expect(s!.nameEn, 'Kathmandu');
    // Name arm of the same method.
    final solukhumbu = NepalAdminApi.getDistrictElevationStats('solukhumbu');
    expect(solukhumbu!.elevMax, greaterThanOrEqualTo(8700));
    // A palika name is not a district.
    expect(NepalAdminApi.getDistrictElevationStats('Bharatpur'), isNull);
    expect(NepalAdminApi.hasDistrictElevationStats('P3.D05'), isTrue);
    expect(NepalAdminApi.hasDistrictElevationStats('kathmandu'), isTrue);
    expect(NepalAdminApi.hasDistrictElevationStats('P3.D99'), isFalse);
    expect(NepalAdminApi.hasDistrictElevationStats('Atlantis'), isFalse);
    expect(NepalAdminApi.getAllDistrictElevationStats().length, 77);
  });

  test('min <= mean <= max for every district, and values are sane', () {
    for (final s in NepalAdminApi.getAllDistrictElevationStats()) {
      expect(s.elevMin, lessThanOrEqualTo(s.elevMean), reason: s.nameEn);
      expect(s.elevMean, lessThanOrEqualTo(s.elevMax), reason: s.nameEn);
      expect(s.elevMin, greaterThanOrEqualTo(0), reason: s.nameEn);
      expect(s.elevMax, lessThanOrEqualTo(9000), reason: s.nameEn);
      expect(s.nameNe, isNotEmpty, reason: s.nameEn);
      expect(s.districtId.length, 6, reason: s.nameEn);
    }
  });

  test('measured anchors agree with known ground truth', () {
    // Everest (8,848.86 m) sits in Solukhumbu; the GLO-30 pixel max is
    // 8,738 m. Kangchenjunga (8,586 m) is in Taplejung, Annapurna I
    // (8,091 m) touches Myagdi, and the Kali Gandaki gorge keeps the
    // Mustang floor well above sea level.
    expect(NepalAdminApi.getDistrictElevationStats('Solukhumbu')!.elevMax,
        greaterThanOrEqualTo(8700));
    expect(NepalAdminApi.getDistrictElevationStats('Taplejung')!.elevMax,
        greaterThanOrEqualTo(8400));
    expect(NepalAdminApi.getDistrictElevationStats('Myagdi')!.elevMax,
        greaterThanOrEqualTo(7900));
    expect(NepalAdminApi.getDistrictElevationStats('Mustang')!.elevMin,
        greaterThanOrEqualTo(1300));
    // The lowest point of Nepal (Kechana Kalan, ~70 m) is in Jhapa.
    final jhapa = NepalAdminApi.getDistrictElevationStats('Jhapa');
    expect(jhapa!.elevMin, greaterThanOrEqualTo(50));
    expect(jhapa.elevMin, lessThan(100));
    // The Kathmandu Valley floor sits around 1,300 m.
    expect(NepalAdminApi.getDistrictElevationStats('P3.D05')!.elevMin,
        greaterThanOrEqualTo(1100));
  });

  test('the elevation layer joins the roster and boundary layer exactly', () {
    final stats = NepalAdminApi.getAllDistrictElevationStats();
    // District-id order.
    final ids = <String>[
      for (final s in stats) s.districtId,
    ];
    final sorted = <String>[...ids]..sort();
    expect(ids, orderedEquals(sorted));
    // Every roster district resolves by name, and the names agree.
    for (final d in NepalAdminApi.getAllDistricts()) {
      final s = NepalAdminApi.getDistrictElevationStats(d.name);
      expect(s, isNotNull, reason: d.name);
      expect(s!.nameEn, d.name, reason: d.name);
      final nameNe = d.nameNe;
      if (nameNe != null) {
        expect(s.nameNe, nameNe, reason: d.name);
      }
    }
    // Every elevation row has a boundary, and the names agree.
    for (final s in stats) {
      final b = NepalAdminApi.getDistrictBoundary(s.districtId);
      expect(b, isNotNull, reason: s.nameEn);
      expect(b!.districtName, s.nameEn, reason: s.nameEn);
    }
  });

  test('districtElevationStatsGeoJson emits a full FeatureCollection', () {
    final fc = NepalAdminApi.districtElevationStatsGeoJson();
    expect(fc['type'], 'FeatureCollection');
    final features = fc['features'] as List;
    expect(features.length, 77);
    final codec = DistrictElevations.toGeoJsonFeatureCollection();
    expect((codec['features'] as List).length, 77);
    for (final feature in features) {
      final f = feature as Map;
      // The layer is statistics only: geometry is null by design.
      expect(f['geometry'], isNull);
      final props = f['properties'] as Map;
      final id = props['districtId'] as String;
      expect(id.length, 6);
      expect(id.startsWith('P'), isTrue);
      expect(id[2], '.');
      expect(props['elevMin'], isA<int>());
      expect(props['elevMean'], isA<int>());
      expect(props['elevMax'], isA<int>());
    }
  });
}
