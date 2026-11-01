// tool/merge/apply_cbs_population.dart
//
// Applies CBS 2021 population data (from data/_stage/cbs_2021_population.json)
// to province and district entries in nepal_local_levels.json.
//
// Usage:
//   dart run tool/merge/apply_cbs_population.dart           # apply
//   dart run tool/merge/apply_cbs_population.dart --dry-run  # report only

import 'dart:convert';
import 'dart:io';

const String stagePath = 'data/_stage/cbs_2021_population.json';
const String rosterPath = 'data/nepal_local_levels.json';

Map<String, dynamic> _readJson(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  final stageFile = File(stagePath);
  final rosterFile = File(rosterPath);
  if (!stageFile.existsSync() || !rosterFile.existsSync()) {
    stderr.writeln('ERROR: missing input file.');
    exit(2);
  }

  final stage = _readJson(stageFile);
  final provincePop = (stage['provincePopulation'] as Map<String, dynamic>)
      .cast<String, dynamic>();
  final districtPop = (stage['districtPopulation'] as Map<String, dynamic>)
      .cast<String, dynamic>();

  final rosterJson = _readJson(rosterFile);
  final provinces =
      (rosterJson['provinces'] as List).cast<Map<String, dynamic>>();

  var provMatched = 0, provUnmatched = 0;
  var distMatched = 0, distUnmatched = 0;

  for (final province in provinces) {
    final provinceName = province['name'] as String;
    if (provincePop.containsKey(provinceName)) {
      province['population'] = provincePop[provinceName] as int;
      provMatched++;
    } else {
      provUnmatched++;
      stderr.writeln('UNMATCHED PROVINCE: $provinceName');
    }

    for (final district
        in (province['districts'] as List).cast<Map<String, dynamic>>()) {
      final districtName = district['name'] as String;
      if (districtPop.containsKey(districtName)) {
        district['population'] = districtPop[districtName] as int;
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
  stdout.writeln('Updated $rosterPath with CBS 2021 population data.');
}
