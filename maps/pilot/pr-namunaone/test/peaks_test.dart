import 'package:nepal_admin_api/peaks.dart';
import 'package:test/test.dart';

void main() {
  group('Nepal peaks', () {
    test('total count is 51', () {
      expect(nepalPeaks.length, 51);
    });

    test('8 main eight-thousanders', () {
      final mains = nepalPeaks.where((p) => p.isMainEightThousander).toList();
      expect(mains.length, 8);
      expect(mains.any((p) => p.id == 'pk-everest'), isTrue);
      expect(mains.any((p) => p.id == 'pk-kanchenjunga'), isTrue);
      expect(mains.any((p) => p.id == 'pk-lhotse'), isTrue);
      expect(mains.any((p) => p.id == 'pk-makalu'), isTrue);
      expect(mains.any((p) => p.id == 'pk-cho-oyu'), isTrue);
      expect(mains.any((p) => p.id == 'pk-dhaulagiri-i'), isTrue);
      expect(mains.any((p) => p.id == 'pk-manaslu'), isTrue);
      expect(mains.any((p) => p.id == 'pk-annapurna-i'), isTrue);
    });

    test('6 official additional eight-thousanders', () {
      final officials = nepalPeaks
          .where((p) => p.isOfficialAdditionalEightThousander)
          .toList();
      expect(officials.length, 6);
    });

    test('37 seven-thousanders', () {
      final sevens = nepalPeaks.where((p) => p.isSevenThousander).toList();
      expect(sevens.length, 37);
    });

    test('43 attested Nepali names', () {
      final attested =
          nepalPeaks.where((p) => p.nameStatus == 'attested').toList();
      expect(attested.length, 43);
    });

    test('8 transliterated Nepali names', () {
      final transliterated =
          nepalPeaks.where((p) => p.nameStatus == 'transliterated').toList();
      expect(transliterated.length, 8);
      expect(transliterated.any((p) => p.id == 'pk-thulagi-chuli'), isTrue);
    });

    test('0 pending Nepali names', () {
      final pending =
          nepalPeaks.where((p) => p.nameStatus == 'pending').toList();
      expect(pending.length, 0);
    });

    test('51 approved, 0 draft', () {
      final approved = nepalPeaks.where((p) => p.reviewStatus == 'approved');
      expect(approved.length, 51);
      final drafts =
          nepalPeaks.where((p) => p.reviewStatus == 'draft').toList();
      expect(drafts.length, 0);
    });

    test('all coordinates within Nepal bbox', () {
      for (final p in nepalPeaks) {
        expect(p.lng, greaterThanOrEqualTo(80.0));
        expect(p.lng, lessThanOrEqualTo(88.3));
        expect(p.lat, greaterThanOrEqualTo(26.3));
        expect(p.lat, lessThanOrEqualTo(30.5));
      }
    });

    test('all elevations above 7,000 m', () {
      for (final p in nepalPeaks) {
        expect(p.elevation, greaterThanOrEqualTo(7000));
      }
    });

    test('all elevations below 9,000 m', () {
      for (final p in nepalPeaks) {
        expect(p.elevation, lessThan(9000));
      }
    });

    test('Everest has correct elevation and name', () {
      final everest = nepalPeaks.firstWhere((p) => p.id == 'pk-everest');
      expect(everest.elevation, 8848.86);
      expect(everest.nameEn, 'Mount Everest');
      expect(everest.nameNe, 'सगरमाथा');
      expect(everest.isBorderPeak, isTrue);
    });

    test('Thulagi Chuli is transliterated', () {
      final thulagi = nepalPeaks.firstWhere((p) => p.id == 'pk-thulagi-chuli');
      expect(thulagi.nameStatus, 'transliterated');
      expect(thulagi.nameNe, 'थुलागी चुली');
      expect(thulagi.reviewStatus, 'approved');
    });

    test('Ratna Chuli is on the border', () {
      final ratna = nepalPeaks.firstWhere((p) => p.id == 'pk-ratna-chuli');
      expect(ratna.isBorderPeak, isTrue);
      expect(ratna.borderCountries, contains('China'));
    });

    test('province codes are valid (1-7)', () {
      for (final p in nepalPeaks) {
        for (final code in p.provinceCodes) {
          expect(code, greaterThanOrEqualTo(1));
          expect(code, lessThanOrEqualTo(7));
        }
      }
    });

    test('district codes are 3-digit (101-707)', () {
      for (final p in nepalPeaks) {
        for (final code in p.districtCodes) {
          expect(code, greaterThanOrEqualTo(101));
          expect(code, lessThanOrEqualTo(707));
        }
      }
    });

    test('peak classes are valid', () {
      final validClasses = {
        'eight_thousander_main',
        'eight_thousander_official_additional',
        'seven_thousander',
      };
      for (final p in nepalPeaks) {
        expect(validClasses, contains(p.peakClass));
      }
    });

    test('name statuses are valid', () {
      final validStatuses = {'attested', 'transliterated', 'pending'};
      for (final p in nepalPeaks) {
        expect(validStatuses, contains(p.nameStatus));
      }
    });

    test('review statuses are valid', () {
      final validStatuses = {'approved', 'draft'};
      for (final p in nepalPeaks) {
        expect(validStatuses, contains(p.reviewStatus));
      }
    });
  });
}
