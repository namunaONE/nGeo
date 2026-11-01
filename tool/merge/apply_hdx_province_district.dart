// tool/merge/apply_hdx_province_district.dart
//
// Applies HDX COD-AB official data (pcode, area_sqkm, center_lat/lon) to
// province and district entries in nepal_local_levels.json.
//
// Usage:
//   dart run tool/merge/apply_hdx_province_district.dart           # apply
//   dart run tool/merge/apply_hdx_province_district.dart --dry-run  # report only

import 'dart:convert';
import 'dart:io';

const String admin1Path = 'data/_raw/hdx-cod-ab/npl_admin1.geojson';
const String admin2Path = 'data/_raw/hdx-cod-ab/npl_admin2.geojson';
const String rosterPath = 'data/nepal_local_levels.json';

String _normProv(String name) =>
    name == 'Sudurpashchim' ? 'Sudur Paschim' : name;

String _normDist(String name) {
  const mapping = {
    'Chitwan': 'Chitawan',
    'Dhanusha': 'Dhanusa',
    'Kapilvastu': 'Kapilbastu',
    'Nawalpur': 'Nawalparasi East',
    'Parasi (Nawalparasi West)': 'Nawalparasi West',
    'Tanahun': 'Tanahu',
  };
  return mapping[name] ?? name;
}

String _n(String s) => s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

Map<String, dynamic> _readJson(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  final admin1File = File(admin1Path);
  final admin2File = File(admin2Path);
  final rosterFile = File(rosterPath);
  if (!admin1File.existsSync() ||
      !admin2File.existsSync() ||
      !rosterFile.existsSync()) {
    stderr.writeln('ERROR: missing input file.');
    exit(2);
  }

  final admin1 = _readJson(admin1File);
  final admin2 = _readJson(admin2File);
  final rosterJson = _readJson(rosterFile);
  final provinces =
      (rosterJson['provinces'] as List).cast<Map<String, dynamic>>();

  // Build HDX lookups keyed by normalized name.
  final hdxProv = <String, Map<String, dynamic>>{};
  for (final raw in (admin1['features'] as List)) {
    final props =
        (raw as Map<String, dynamic>)['properties'] as Map<String, dynamic>;
    hdxProv[_n(props['adm1_name'] as String)] = props;
  }
  final hdxDist = <String, Map<String, dynamic>>{};
  for (final raw in (admin2['features'] as List)) {
    final props =
        (raw as Map<String, dynamic>)['properties'] as Map<String, dynamic>;
    final key =
        '${_n(_normProv(props['adm1_name'] as String))}|${_n(_normDist(props['adm2_name'] as String))}';
    hdxDist[key] = props;
  }

  var provMatched = 0, provUnmatched = 0;
  var distMatched = 0, distUnmatched = 0;

  for (final province in provinces) {
    final provinceName = province['name'] as String;
    final hdxP = hdxProv[_n(_normProv(provinceName))];
    if (hdxP != null) {
      province['hdxPcode'] = hdxP['adm1_pcode'] as String;
      province['areaSqKmOfficial'] = (hdxP['area_sqkm'] as num).toDouble();
      province['latHdx'] = (hdxP['center_lat'] as num).toDouble();
      province['lngHdx'] = (hdxP['center_lon'] as num).toDouble();
      provMatched++;
    } else {
      provUnmatched++;
      stderr.writeln('UNMATCHED PROVINCE: $provinceName');
    }

    for (final district
        in (province['districts'] as List).cast<Map<String, dynamic>>()) {
      final districtName = district['name'] as String;
      final key =
          '${_n(_normProv(provinceName))}|${_n(_normDist(districtName))}';
      final hit = hdxDist[key];
      if (hit != null) {
        district['hdxPcode'] = hit['adm2_pcode'] as String;
        district['areaSqKmOfficial'] = (hit['area_sqkm'] as num).toDouble();
        district['latHdx'] = (hit['center_lat'] as num).toDouble();
        district['lngHdx'] = (hit['center_lon'] as num).toDouble();
        distMatched++;
      } else {
        distUnmatched++;
        stderr.writeln('UNMATCHED DISTRICT: $districtName ($provinceName)');
      }
    }
  }

  stdout.writeln(
      'Provinces matched: $provMatched / ${provMatched + provUnmatched}');
  stdout.writeln(
      'Districts matched: $distMatched / ${distMatched + distUnmatched}');

  if (dryRun) {
    stdout.writeln('Dry run — no files written.');
    return;
  }

  const encoder = JsonEncoder.withIndent('  ');
  rosterFile.writeAsStringSync(encoder.convert(rosterJson));
  stdout.writeln('Updated $rosterPath with HDX province/district data.');
}
