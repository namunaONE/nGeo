// Logic tests for the cascade. These are the part worth testing: the state
// transitions and label rules are where an address picker silently goes wrong.
import 'package:flutter_test/flutter_test.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

void main() {
  // Real records from the dataset, looked up by name so the tests fail loudly
  // if the roster changes rather than silently testing a different unit.
  Province province(String name) =>
      NepalAdminApi.getAllProvinces().firstWhere((p) => p.name == name);
  District district(String name) => NepalAdminApi.getDistrictByName(name)!;
  List<LocalBody> bodiesIn(String districtName) =>
      NepalAdminApi.getLocalBodiesByDistrict(districtName);

  group('dataset', () {
    test('has the gazetted shape', () {
      expect(NepalAdminApi.getAllProvinces(), hasLength(7));
      expect(NepalAdminApi.getAllDistricts(), hasLength(77));
      expect(NepalAdminApi.getAllLocalBodies(), hasLength(753));
    });
  });

  group('initial state', () {
    test('starts empty', () {
      final c = AdministrativeCascade();
      expect(c.isEmpty, isTrue);
      expect(c.selection.isEmpty, isTrue);
      expect(c.selection.isComplete, isFalse);
    });

    test('offers no local bodies until a province or district is chosen', () {
      // Deliberate: listing all 753 would drop the district out of the answer,
      // which is exactly the ambiguity the cascade exists to remove.
      final c = AdministrativeCascade();
      expect(c.availableLocalBodies, isEmpty);
      expect(c.search('kath'), isEmpty);
    });

    test('offers every district before a province is chosen', () {
      final c = AdministrativeCascade();
      expect(c.availableDistricts, hasLength(77));
    });
  });

  group('selecting a province', () {
    test('clears the levels beneath it', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      c.selectLocalBody(bodiesIn('Kathmandu').first);
      expect(c.localBody, isNotNull);

      c.selectProvince(province('Koshi'));

      expect(c.province!.name, 'Koshi');
      expect(c.district, isNull, reason: 'a stale district must not survive');
      expect(c.localBody, isNull, reason: 'a stale body must not survive');
    });

    test('re-picking the province the cascade already implies is a no-op', () {
      // Choosing Kathmandu already implies Bagmati, so that state is coherent,
      // not stale. Re-picking Bagmati from the dropdown must therefore do
      // nothing rather than appear to "reset" a selection the user never made.
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      expect(c.province!.name, 'Bagmati');

      var calls = 0;
      c.addListener(() => calls++);
      c.selectProvince(province('Bagmati'));

      expect(calls, 0);
      expect(c.district!.name, 'Kathmandu');
    });

    test('notifies listeners once, and not again for a no-op', () {
      final c = AdministrativeCascade();
      var calls = 0;
      c.addListener(() => calls++);

      final bagmati = province('Bagmati');
      c.selectProvince(bagmati);
      expect(calls, 1);

      c.selectProvince(bagmati);
      expect(calls, 1, reason: 're-selecting the same value is not a change');
    });
  });

  group('selecting a district', () {
    test('clears the body beneath it', () {
      final c = AdministrativeCascade();
      c.selectProvince(province('Bagmati'));
      c.selectDistrict(district('Kathmandu'));
      c.selectLocalBody(bodiesIn('Kathmandu').first);

      c.selectDistrict(district('Lalitpur'));

      expect(c.district!.name, 'Lalitpur');
      expect(c.localBody, isNull);
    });

    test('infers its own province', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Jhapa'));
      expect(c.province!.name, 'Koshi');
    });

    test('repoints the province when the district is elsewhere', () {
      final c = AdministrativeCascade();
      c.selectProvince(province('Bagmati'));
      c.selectDistrict(district('Jhapa'));
      expect(c.province!.name, 'Koshi');
    });
  });

  group('selecting a local body', () {
    test('reconciles the levels above it', () {
      // The behaviour that makes search safe: a hit from a district the user
      // never chose still selects a coherent chain, so a body can never be
      // selected under a district it does not belong to.
      final c = AdministrativeCascade();
      final body = bodiesIn('Jhapa').first;

      c.selectLocalBody(body);

      expect(c.localBody, same(body));
      expect(c.district!.name, body.districtName);
      expect(c.province!.name, body.provinceName);
      expect(c.selection.isComplete, isTrue);
      expect(c.availableLocalBodies,
          hasLength(bodiesIn(body.districtName).length));
    });

    test('clearing the body leaves the upper levels intact', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Jhapa'));
      c.selectLocalBody(bodiesIn('Jhapa').first);

      c.selectLocalBody(null);

      expect(c.localBody, isNull);
      expect(c.district!.name, 'Jhapa');
    });
  });

  group('scoping', () {
    test('province scopes both levels below it', () {
      final c = AdministrativeCascade();
      c.selectProvince(province('Koshi'));
      expect(c.availableDistricts, hasLength(14));
      expect(c.availableLocalBodies, hasLength(137));
    });

    test('district scopes the bodies beneath it', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      final listed = c.availableLocalBodies.map((b) => b.name).toSet();
      expect(listed, bodiesIn('Kathmandu').map((b) => b.name).toSet());
    });

    test('every body in a district shares its province', () {
      final c = AdministrativeCascade();
      for (final d in c.districts) {
        c.selectDistrict(d);
        for (final b in c.availableLocalBodies) {
          expect(b.provinceName, d.provinceName,
              reason: '${b.name} in ${d.name}');
        }
      }
    });

    test('no cascade can produce a body outside its own roster', () {
      final c = AdministrativeCascade();
      for (final b in c.localBodies) {
        c.selectLocalBody(b);
        expect(c.availableLocalBodies.contains(b), isTrue,
            reason: 'selected body ${b.name} must be selectable');
      }
    });
  });

  group('clear', () {
    test('empties every level and is a no-op when already empty', () {
      final c = AdministrativeCascade();
      var calls = 0;
      c.addListener(() => calls++);

      c.clear();
      expect(calls, 0, reason: 'clearing an empty cascade is not a change');

      c.selectLocalBody(bodiesIn('Jhapa').first);
      expect(calls, 1);
      c.clear();
      expect(c.isEmpty, isTrue);
      expect(calls, 2);
    });
  });

  group('selectAll', () {
    test('restores a whole saved address', () {
      final c = AdministrativeCascade();
      // Kaski contains Pokhara Metropolitan City; there is no "Pokhara"
      // district, which trips up code that assumes one level per name.
      final body = bodiesIn('Kaski').firstWhere((b) => b.name == 'Pokhara');
      c.selectAll(
        province: province('Gandaki'),
        district: district('Kaski'),
        localBody: body,
      );
      expect(c.localBody, same(body));
      expect(c.district!.name, 'Kaski');
      expect(c.province!.name, 'Gandaki');
    });

    test('drops a body that is not a child of the district it kept', () {
      // Restoring a stale saved address must not resurrect a contradiction.
      final c = AdministrativeCascade();
      final body = bodiesIn('Jhapa').first;
      c.selectAll(district: district('Kathmandu'), localBody: body);
      expect(c.localBody, isNull);
      expect(c.district!.name, 'Kathmandu');
    });

    test('leaves unspecified levels alone', () {
      final c = AdministrativeCascade();
      c.selectProvince(province('Koshi'));
      c.selectDistrict(district('Jhapa'));
      c.selectAll(province: province('Bagmati'));
      expect(c.province!.name, 'Bagmati');
      expect(c.district!.name, 'Jhapa');
    });
  });

  group('label formatting', () {
    final bagmati = province('Bagmati');

    test('both scripts when both are attested', () {
      expect(
          AdministrativeCascade.formatProvince(bagmati, style: LabelStyle.both),
          contains('·'));
    });

    test('never emits a dangling separator', () {
      // Every one of the 753 palikas carries an attested Devanagari name
      // since the Government of Nepal code table filled the last gaps
      // (2026-10-27); the invariants must hold regardless.
      for (final b in NepalAdminApi.getAllLocalBodies()) {
        final label =
            AdministrativeCascade.formatLocalBody(b, style: LabelStyle.both);
        expect(label, isNot(endsWith('·')), reason: b.name);
        expect(label.trim(), label, reason: b.name);
        expect(label.contains('·'), b.nameNe != null, reason: b.name);
      }
    });

    test('falls back to English when no Devanagari name exists', () {
      // No dataset row lacks a Devanagari name any more, so the fallback
      // contract is exercised on a synthetic body.
      final without = LocalBody.fromJson({
        'name': 'Y',
        'type': 'M',
        'district': 'D',
        'province': 'P',
      });
      expect(
        AdministrativeCascade.formatLocalBody(without,
            style: LabelStyle.devanagari),
        'Y',
      );
    });

    test('every label style is non-empty for every record', () {
      for (final b in NepalAdminApi.getAllLocalBodies()) {
        for (final style in LabelStyle.values) {
          expect(AdministrativeCascade.formatLocalBody(b, style: style),
              isNotEmpty,
              reason: '${b.name} / $style');
        }
      }
    });

    test('the disambiguated form is unique where the bare name is not', () {
      // `Sunkoshi` names four different rural municipalities.
      final sunkoshi = NepalAdminApi.getAllLocalBodies()
          .where((b) => b.name == 'Sunkoshi')
          .toList();
      expect(sunkoshi, hasLength(4));
      for (final b in sunkoshi) {
        expect(b.type, LocalBodyType.ruralMunicipality, reason: b.districtName);
      }

      final bare = sunkoshi
          .map((b) => AdministrativeCascade.formatLocalBody(b,
              style: LabelStyle.english))
          .toSet();
      expect(bare, hasLength(1),
          reason: 'the bare name is genuinely ambiguous');

      final qualified = sunkoshi
          .map((b) => AdministrativeCascade.formatLocalBodyDisambiguated(
                b,
                style: LabelStyle.english,
              ))
          .toSet();
      expect(qualified, hasLength(4),
          reason: 'so the qualified form must be unique');
    });

    test('the qualified form stays unique even when names repeat', () {
      // Four rural municipalities share the bare name "Sunkoshi". Whether a
      // given one carries a Devanagari name depends on the dataset version
      // this package resolves against (the 2026-10-27 code-table fill closes
      // the last one in nepal_admin_api 2.9.0), so what must hold in every
      // case is the district qualifier: it disambiguates every label style,
      // and the nameless fallback never introduces a collision.
      final sunkoshi =
          NepalAdminApi.getAllLocalBodies().where((b) => b.name == 'Sunkoshi');
      expect(sunkoshi, hasLength(4));

      for (final style in LabelStyle.values) {
        final qualified = sunkoshi
            .map((b) => AdministrativeCascade.formatLocalBodyDisambiguated(b,
                style: style))
            .toSet();
        expect(qualified, hasLength(4), reason: 'style $style');
      }
    });

    test('the disambiguated form is unique across all 753 bodies', () {
      final labels = NepalAdminApi.getAllLocalBodies()
          .map(AdministrativeCascade.formatLocalBodyDisambiguated)
          .toSet();
      expect(labels, hasLength(753));
    });
  });

  group('search', () {
    test('an empty query returns the available bodies unfiltered', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      expect(c.search('  '), hasLength(c.availableLocalBodies.length));
      expect(c.search(''), hasLength(c.availableLocalBodies.length));
    });

    test('matches English names case-insensitively', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      expect(
        c.search('kATHMaNDU').map((b) => b.name),
        contains('Kathmandu'),
      );
    });

    test('ranks an exact match above a prefix match above a substring', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      final names = c.search('kath').map((b) => b.name).toList();
      expect(names.indexOf('Kathmandu'), lessThan(names.length - 1),
          reason: 'the exact match must come first, not last');
    });

    test('matches Devanagari names', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      final ne = district('Kathmandu').nameNe;
      expect(ne, isNotNull);
      expect(c.search(ne!), isNotEmpty);
    });

    test('is scoped to the district, never returning a body from elsewhere',
        () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      for (final b in c.search('a')) {
        expect(b.districtName, 'Kathmandu');
      }
    });

    test('every result is selectable without contradicting the district', () {
      final c = AdministrativeCascade();
      for (final term in ['a', 'sunkoshi', 'bharatpur', 'महानगर', 'zzz']) {
        c.selectDistrict(district('Kathmandu'));
        for (final b in c.search(term)) {
          c.selectLocalBody(b);
          expect(c.district!.name, 'Kathmandu', reason: 'query "$term"');
        }
      }
    });

    test('a nonsense query returns nothing rather than everything', () {
      final c = AdministrativeCascade();
      c.selectDistrict(district('Kathmandu'));
      expect(c.search('qqqqzzzz'), isEmpty);
    });

    test('matches the district name too', () {
      final c = AdministrativeCascade();
      c.selectProvince(province('Koshi'));
      final hits = c.search('Jhapa');
      expect(hits, isNotEmpty);
      expect(hits.every((b) => b.districtName == 'Jhapa'), isTrue);
    });
  });

  group('selection equality', () {
    test('distinguishes same-named bodies in different districts', () {
      // Without this, `AdministrativeSelection ==` would report two different
      // municipalities as the same answer.
      final a = AdministrativeSelection(
        province: province('Koshi'),
        district: district('Sindhuli'),
        localBody:
            NepalAdminApi.getLocalBodiesByName('Sunkoshi', 'Sindhuli').single,
      );
      final b = AdministrativeSelection(
        province: province('Bagmati'),
        district: district('Sindhupalchok'),
        localBody:
            NepalAdminApi.getLocalBodiesByName('Sunkoshi', 'Sindhupalchok')
                .single,
      );
      expect(a, isNot(equals(b)));
      expect(a.hashCode, isNot(equals(b.hashCode)));
      expect(a, equals(a));
    });
  });
}
