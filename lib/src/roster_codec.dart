// lib/src/roster_codec.dart
//
// Reader for the compact roster embedded in nepal_data.dart, format
// version 1. The generated file packs the dataset as pipe-separated rows
// instead of half a megabyte of constructor literals; this decoder
// rebuilds exactly the objects those literals used to describe.
//
// The writer that mirrors this reader is tool/generate.dart. Both sides
// validate: the generator refuses a dataset that contradicts the official
// federal structure, and the decoder refuses a roster it cannot consume
// completely, so a truncated or hand-edited file fails loudly on import
// rather than decoding half a dataset.

import 'nepal_admin_api_base.dart';

/// Decodes compact roster rows into fully wired [Province] objects.
class RosterCodec {
  /// Rebuilds the province list from the generated roster constants.
  ///
  /// Rows are consumed in dataset order: each province names its district
  /// count, each district its local-body count, and every row must be
  /// consumed exactly — a roster that leaves rows behind, or asks for
  /// more than it carries, fails rather than decoding partially.
  static List<Province> decode({
    required String formatVersion,
    required List<String> geoSources,
    required List<String> provinces,
    required List<String> districts,
    required List<String> localBodies,
  }) {
    if (formatVersion != '1') {
      throw StateError('roster format $formatVersion'); // coverage:ignore-line
    }
    var nextDistrict = 0;
    var nextBody = 0;
    final decoded = <Province>[];
    for (final row in provinces) {
      final pf = _fields(row);
      _arity(pf, 16, 'province row');
      final districtCount = int.parse(pf[15]);
      final provinceDistricts = <District>[];
      var metro = 0;
      var subMetro = 0;
      var mun = 0;
      var ruralMun = 0;
      var total = 0;
      for (var i = 0; i < districtCount; i++) {
        final df = _fields(districts[nextDistrict++]);
        _arity(df, 13, 'district row');
        final unitCount = int.parse(df[12]);
        final units = <LocalBody>[];
        for (var j = 0; j < unitCount; j++) {
          final lf = _fields(localBodies[nextBody++]);
          _arity(lf, 19, 'local-body row');
          final type = _typeOf(lf[3]);
          final code = _intOpt(lf[4]);
          final verified = _flag(lf[5]);
          final body = LocalBody(
            name: lf[0],
            nameNe: _opt(lf[1]),
            nameNeVerified: _flag(lf[2]),
            type: type,
            districtName: df[0],
            provinceName: pf[1],
            cbsCode: code,
            cbsCodeVerified: verified,
            cbsCodeConfidence: _confidence(code, verified),
            lat: _doubleOpt(lf[6]),
            lng: _doubleOpt(lf[7]),
            geoSource: _geo(lf[8], geoSources),
            hdxPcode: _opt(lf[15]),
            areaSqKmOfficial: _doubleOpt(lf[16]),
            latHdx: _doubleOpt(lf[17]),
            lngHdx: _doubleOpt(lf[18]),
            wards: _intOpt(lf[9]),
            wardsVerified: _flag(lf[10]),
            website: _opt(lf[11]),
            email: _opt(lf[12]),
            phone: _opt(lf[13]),
            zipCodes: _zips(lf[14]),
          );
          units.add(body);
          total++;
          if (type == LocalBodyType.metropolitan) {
            metro++;
          } else if (type == LocalBodyType.subMetropolitan) {
            subMetro++;
          } else if (type == LocalBodyType.municipality) {
            mun++;
          } else {
            ruralMun++;
          }
        }
        provinceDistricts.add(
          District(
            name: df[0],
            nameNe: _opt(df[1]),
            nameNeVerified: _flag(df[2]),
            cbsCode: _intOpt(df[3]),
            headquarter: _opt(df[4]),
            areaSqKm: _doubleOpt(df[5]),
            hdxPcode: _opt(df[6]),
            areaSqKmOfficial: _doubleOpt(df[7]),
            latHdx: _doubleOpt(df[8]),
            lngHdx: _doubleOpt(df[9]),
            population: _intOpt(df[10]),
            website: _opt(df[11]),
            units: units,
          ),
        );
      }
      decoded.add(
        Province(
          id: pf[0],
          name: pf[1],
          nameNe: _opt(pf[2]),
          nameNeVerified: _flag(pf[3]),
          cbsCode: int.parse(pf[12]),
          capital: _opt(pf[4]),
          areaSqKm: _doubleOpt(pf[5]),
          hdxPcode: _opt(pf[6]),
          areaSqKmOfficial: _doubleOpt(pf[7]),
          latHdx: _doubleOpt(pf[8]),
          lngHdx: _doubleOpt(pf[9]),
          population: _intOpt(pf[10]),
          website: _opt(pf[11]),
          isoCode: pf[13],
          stats: ProvinceStats(
            districts: districtCount,
            metro: metro,
            subMetro: subMetro,
            mun: mun,
            ruralMun: ruralMun,
            total: total,
            wards: int.parse(pf[14]),
          ),
          districts: provinceDistricts,
        ),
      );
    }
    if (nextDistrict != districts.length || nextBody != localBodies.length) {
      throw StateError('unconsumed roster rows'); // coverage:ignore-line
    }
    return decoded;
  }

  /// Splits one roster row into its fields.
  static List<String> _fields(String row) => row.split('|');

  /// Refuses rows whose field count does not match the format.
  static void _arity(List<String> f, int n, String kind) {
    if (f.length == n) return;
    throw FormatException('$kind: ${f.length}/$n'); // coverage:ignore-line
  }

  /// An empty field decodes to null; anything else is the value itself.
  static String? _opt(String field) => field.isEmpty ? null : field;

  /// '1' is the only truthy spelling the writer emits.
  static bool _flag(String field) => field == '1';

  /// Parses an integer field; an empty field decodes to null.
  static int? _intOpt(String field) => field.isEmpty ? null : int.parse(field);

  /// Parses a real-valued field; an empty field decodes to null.
  static double? _doubleOpt(String field) =>
      field.isEmpty ? null : double.parse(field);

  /// Resolves a geo-source index to its label; an empty field decodes to
  /// null.
  static String? _geo(String field, List<String> geoSources) {
    if (field.isEmpty) return null;
    return geoSources[int.parse(field)];
  }

  /// Splits the comma-joined postal codes back into a list.
  static List<String> _zips(String field) {
    if (field.isEmpty) return const [];
    return field.split(',');
  }

  /// Maps the one-letter type code back to its [LocalBodyType].
  static LocalBodyType _typeOf(String code) {
    switch (code) {
      case 'M':
        return LocalBodyType.metropolitan;
      case 'S':
        return LocalBodyType.subMetropolitan;
      case 'm':
        return LocalBodyType.municipality;
      case 'r':
        return LocalBodyType.ruralMunicipality;
      default:
        throw FormatException('type "$code"'); // coverage:ignore-line
    }
  }

  /// Rebuilds the tier the writer derived away: no code means no tier, a
  /// doubly-attested code is verified, any other code is single-source.
  static CbsCodeConfidence _confidence(int? cbsCode, bool verified) {
    if (cbsCode == null) return CbsCodeConfidence.unverified;
    if (verified) return CbsCodeConfidence.verified;
    return CbsCodeConfidence.singleSource;
  }
}
