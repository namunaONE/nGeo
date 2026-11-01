// tool/check_site_truth.dart - CI gate: the site must claim what the
// dataset actually says, not what it said three releases ago.
//
// The dataset advanced three times after the docs were first written:
// 752/753 CBS codes became 753/753, 196 single-source codes became 205,
// and 9 uncoded palikas became 0. Some pages kept up; some quietly did
// not, and nothing failed. This gate keeps them honest: it reads the
// version from pubspec.yaml and the coverage counters from
// bindings/meta.json (both regenerated and drift-checked earlier in the
// same CI run), then asserts that every doc surface - README, index,
// explorer, api, llms.txt, llms-full.txt, robots.txt, sitemap.xml -
// carries exactly those numbers, the dataset's as-of date wherever a
// freshness signal is exposed (index JSON-LD dateModified), and none of
// the figures the truth sweep retired. When the dataset moves and a page
// does not follow, CI fails here with a file-annotated error.
//
// Usage (from the repository root):
//   dart run tool/check_site_truth.dart
//
// Exit 0 = pass, 1 = fail. Wired into .github/workflows/dart.yml.

import 'dart:convert';
import 'dart:io';

Never _abort(String message) {
  stderr.writeln('check_site_truth: $message');
  exit(1);
}

String _read(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    _abort('$path not found - run from the repository root.');
  }
  return file.readAsStringSync();
}

/// 6743 -> "6,743", the way the hero counter renders the ward figure.
String _group(int n) {
  final pattern = RegExp(r'\B(?=(\d{3})+(?!\d))');
  return n.toString().replaceAllMapped(pattern, (m) => ',');
}

void main() {
  final versionPattern = RegExp(r'^version:\s*([\d.]+)', multiLine: true);
  final versionMatch = versionPattern.firstMatch(_read('pubspec.yaml'));
  if (versionMatch == null) {
    _abort('could not read the version from pubspec.yaml.');
  }
  final version = versionMatch.group(1)!;

  final meta = jsonDecode(_read('bindings/meta.json')) as Map<String, dynamic>;
  final metaVersion = meta['version'] as String;
  final dataAsOf = meta['dataAsOf'] as String;
  final coverage = meta['coverage'] as Map<String, dynamic>;
  final bodies = coverage['localBodies'] as int;
  final provinces = coverage['provinces'] as int;
  final districts = coverage['districts'] as int;
  final withCode = coverage['withCbsCode'] as int;
  final doublyAttested = coverage['doublyAttestedCodes'] as int;
  final singleSource = coverage['singleSourceCodes'] as int;
  final withWards = coverage['withWards'] as int;
  final wards = coverage['declaredWards'] as int;
  final uncoded = bodies - withCode;

  final failures = <String>[];

  void check(bool condition, String file, String because) {
    if (!condition) {
      failures.add('::error file=$file::site truth: $because');
    }
  }

  check(metaVersion == version, 'bindings/meta.json',
      'meta.json says v$metaVersion, pubspec.yaml says v$version.');

  final surfaces = <String, String>{
    'README.md': _read('README.md'),
    'docs/index.html': _read('docs/index.html'),
    'docs/explorer.html': _read('docs/explorer.html'),
    'docs/api.html': _read('docs/api.html'),
    'docs/llms.txt': _read('docs/llms.txt'),
    'docs/llms-full.txt': _read('docs/llms-full.txt'),
    'docs/robots.txt': _read('docs/robots.txt'),
    'docs/sitemap.xml': _read('docs/sitemap.xml'),
  };

  void need(String file, String needle, String because) {
    final found = (surfaces[file] ?? '').contains(needle);
    check(found, file, 'expected $because (missing "$needle").');
  }

  // Versions: every surface that states one states the current one.
  need('README.md', 'nepal_admin_api: ^$version',
      'the install snippet to say ^$version');
  need('docs/index.html', '<span class="badge">v$version ',
      'the hero badge to say v$version');
  need('docs/index.html', 'nepal_admin_api: ^$version',
      'the install snippet to say ^$version');
  need('docs/index.html', '"version": "$version"',
      'the JSON-LD version to be $version');

  // Freshness: the index JSON-LD carries the dataset's as-of date, so
  // search and AI answer engines never see a dataset that claims to be
  // newer (or older) than the data actually is.
  need('docs/index.html', '"dateModified": "$dataAsOf"',
      'the JSON-LD dateModified to be $dataAsOf (meta.json dataAsOf)');

  // Crawler welcome: the dataset is meant to be found and cited. The
  // robots file must welcome the known AI answer-engine bots (several
  // of them crawl only when explicitly named) and declare the sitemap;
  // the sitemap must list every public page.
  const aiBots = [
    'GPTBot',
    'OAI-SearchBot',
    'ClaudeBot',
    'PerplexityBot',
    'Google-Extended',
    'CCBot',
  ];
  for (final bot in aiBots) {
    need('docs/robots.txt', 'User-agent: $bot',
        'the AI crawler $bot to be explicitly welcomed');
  }
  need(
      'docs/robots.txt',
      'Sitemap: https://namunaone.github.io/nGeo/sitemap.xml',
      'the sitemap to be declared');
  const sitePages = [
    'https://namunaone.github.io/nGeo/',
    'https://namunaone.github.io/nGeo/explorer.html',
    'https://namunaone.github.io/nGeo/api.html',
    'https://namunaone.github.io/nGeo/brand.html',
  ];
  for (final page in sitePages) {
    need('docs/sitemap.xml', '<loc>$page</loc>', 'the sitemap to list $page');
  }
  need('docs/explorer.html', 'v$version', 'the footer to say v$version');
  need(
      'docs/explorer.html',
      'District boundaries: Survey Department of Nepal / National Geoportal',
      'the district overlay attribution to name its source');
  need('docs/api.html', 'v$version', 'the footer to say v$version');
  need('docs/llms.txt', 'v$version', 'the version to be v$version');
  need('docs/llms.txt', 'nepal_admin_api: ^$version',
      'the install line to say ^$version');
  need('docs/llms-full.txt', 'nepal_admin_api: ^$version',
      'the install snippet to say ^$version');
  need('docs/llms-full.txt', 'v$version', 'the version to be v$version');

  // Counters: the hero figures match the dataset.
  need('docs/index.html', 'stat-value">$provinces<',
      'the province counter to be $provinces');
  need('docs/index.html', 'stat-value">$districts<',
      'the district counter to be $districts');
  need('docs/index.html', 'stat-value">$bodies<',
      'the local-body counter to be $bodies');
  need('docs/index.html', 'stat-value">${_group(wards)}<',
      'the ward counter to be ${_group(wards)}');

  // Coverage: the headline claims match meta.json.
  need('docs/index.html', '$withCode/$bodies palikas (100%)',
      'CBS coverage to be $withCode/$bodies (100%)');
  need(
    'docs/index.html',
    '$doublyAttested doubly-attested, $singleSource single-source',
    'the attestation split to be $doublyAttested + $singleSource',
  );
  need('docs/explorer.html', '$withWards/$bodies palikas',
      'ward coverage to be $withWards/$bodies');
  final coverageLine =
      'Coverage: $withCode/$bodies palikas carry a CBS code ($doublyAttested doubly-attested, $singleSource single-source, $uncoded null)';
  need('docs/llms.txt', coverageLine,
      'the coverage line to carry the meta.json counters');
  need('docs/llms-full.txt', '**CBS codes:** $withCode/$bodies palikas carry',
      'the CBS coverage line to be $withCode/$bodies');

  // Wave 3: the district elevation artifact must parse and agree with
  // the dataset's district count, and every row must satisfy
  // min <= mean <= max. The count interpolates from meta.json — nothing
  // is hand-pinned, so this gate never drifts with a release.
  final elevation = jsonDecode(_read('docs/district-elevation.json')) as List;
  check(elevation.length == districts, 'docs/district-elevation.json',
      'expected $districts districts, found ${elevation.length}.');
  for (final row in elevation) {
    final e = row as Map<String, dynamic>;
    check(
        e['elevMin'] is int && e['elevMean'] is int && e['elevMax'] is int,
        'docs/district-elevation.json',
        '${e['district']} is missing integer elevation values.');
    final lo = e['elevMin'] as int;
    final mid = e['elevMean'] as int;
    final hi = e['elevMax'] as int;
    check(lo <= mid && mid <= hi, 'docs/district-elevation.json',
        '${e['district']} violates min <= mean <= max.');
  }

  // Tripwire: figures retired by the truth sweep stay retired.
  const retired = ['752/753', '744/753', '731/753', '733/753', '98.8'];
  for (final entry in surfaces.entries) {
    for (final token in retired) {
      final clean = !entry.value.contains(token);
      check(clean, entry.key, 'retired figure "$token" reappeared.');
    }
  }

  if (failures.isEmpty) {
    final okMessage =
        'site truth OK: ${surfaces.length} surfaces agree with pubspec.yaml v$version and bindings/meta.json ($withCode/$bodies coded, $doublyAttested doubly attested, $singleSource single source).';
    stdout.writeln(okMessage);
    return;
  }
  for (final failure in failures) {
    stderr.writeln(failure);
  }
  _abort('${failures.length} surface(s) drifted from the dataset.');
}
