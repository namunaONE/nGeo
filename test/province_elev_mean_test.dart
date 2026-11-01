// Pins Province.elevMean's fallback weighting: districts that carry no
// official or single-source area must fall back to equal weighting, and a
// province mixing weighted and unweighted districts must blend the two.
// The real roster gives every district an area, so these branches are only
// reachable with hand-built provinces — the honest way to cover them.

import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:test/test.dart';

Province _province(List<District> districts) => Province(
      id: 'test',
      name: 'Test',
      cbsCode: 9,
      isoCode: 'NP-P9',
      stats: const ProvinceStats(
        districts: 0,
        metro: 0,
        subMetro: 0,
        mun: 0,
        ruralMun: 0,
        total: 0,
        wards: 0,
      ),
      districts: districts,
    );

District _district(String name, {double? areaSqKm}) => District(
      name: name,
      areaSqKm: areaSqKm,
      units: const [],
    );

void main() {
  test('districts without an area fall back to equal weighting', () {
    final k = DistrictElevations.byName('Kathmandu')!;
    final b = DistrictElevations.byName('Bhaktapur')!;
    final p = _province([
      _district('Kathmandu'),
      _district('Bhaktapur'),
    ]);
    expect(p.elevMean, ((k.elevMean + b.elevMean) / 2).round());
  });

  test('a mix of weighted and unweighted districts blends both parts', () {
    final k = DistrictElevations.byName('Kathmandu')!;
    final b = DistrictElevations.byName('Bhaktapur')!;
    final p = _province([
      _district('Kathmandu', areaSqKm: 100),
      _district('Bhaktapur'),
    ]);
    expect(p.elevMean, ((100 * k.elevMean + b.elevMean) / 101).round());
  });

  test('a single unweighted district returns its own mean', () {
    final k = DistrictElevations.byName('Kathmandu')!;
    final p = _province([_district('Kathmandu')]);
    expect(p.elevMean, k.elevMean);
  });

  test('districts without elevation stats contribute nothing', () {
    final p = _province([_district('Atlantis', areaSqKm: 100)]);
    expect(p.elevMean, isNull);
  });
}
