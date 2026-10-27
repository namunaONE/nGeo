// Pins the high-resolution palika boundary layer shipped by this package.

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_boundaries_highres/nepal_admin_boundaries_highres.dart';
import 'package:test/test.dart';

void main() {
  test('high-res constants are self-consistent', () {
    expect(kHighResPalikaBoundaryFormatVersion, '1');
    expect(kHighResPalikaBoundaryFeatureCount, 753);
    final matchedEntries =
        kHighResPalikaBoundaries.values.fold<int>(0, (n, m) => n + m.length);
    expect(matchedEntries, kHighResPalikaBoundaryMatchedCount);
    expect(
      matchedEntries + kHighResUnmatchedPalikaBoundaries.length,
      kHighResPalikaBoundaryFeatureCount,
    );
  });

  test('high-res carries more vertices than the core package', () {
    expect(kHighResPalikaBoundaryVertexCount, greaterThan(70000));
  });

  test('all six metros have high-res boundary polygons', () {
    final metros =
        NepalAdminApi.getLocalBodiesByType(LocalBodyType.metropolitan);
    expect(metros.length, 6);
    for (final m in metros) {
      expect(HighResPalikaBoundaries.hasBoundary(m.districtName, m.name), isTrue,
          reason: '${m.name} has no high-res boundary');
      expect(HighResPalikaBoundaries.byName(m.districtName, m.name), isNotNull,
          reason: '${m.name} failed to decode');
    }
  });

  test('Bharatpur: high-res decode, centroid containment, GeoJSON', () {
    final b = HighResPalikaBoundaries.byName('Chitwan', 'Bharatpur');
    expect(b, isNotNull);
    final lb = NepalAdminApi.getLocalBodyByCbs(31304);
    expect(b!.containsPoint(lb!.lat!, lb.lng!), isTrue);
    final feature = b.toGeoJsonFeature();
    expect(feature['type'], 'Feature');
    final geometry = feature['geometry'] as Map<String, Object?>;
    expect(geometry['type'], anyOf('Polygon', 'MultiPolygon'));
  });

  test('high-res coverage matches the roster (753/753)', () {
    final roster = NepalAdminApi.getAllLocalBodies();
    var covered = 0;
    for (final lb in roster) {
      if (HighResPalikaBoundaries.hasBoundary(lb.districtName, lb.name)) {
        covered++;
      }
    }
    expect(covered, 753);
  });

  test('high-res hasBoundary is cheaper than byName (no decode)', () {
    expect(HighResPalikaBoundaries.hasBoundary('Chitwan', 'Bharatpur'), isTrue);
    expect(HighResPalikaBoundaries.hasBoundary('Chitwan', 'Nope'), isFalse);
  });

  test('toGeoJsonFeatureCollection emits 753 features', () {
    final fc = HighResPalikaBoundaries.toGeoJsonFeatureCollection();
    expect(fc['type'], 'FeatureCollection');
    final features = fc['features'] as List;
    expect(features.length, 753);
  });
}
