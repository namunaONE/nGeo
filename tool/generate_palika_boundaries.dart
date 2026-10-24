// tool/generate_palika_boundaries.dart — regenerate the vendored palika
// boundary geometry used by the explorer choropleth.
//
// Input : data/_raw/nepali-geo-pro-max/src_geo_local-units.geo.ts
//         (gitignored; pinned in data/PROVENANCE.sha256)
// Output: docs/palika-boundaries.geojson (committed, website-only)
//
// The pinned input is a TypeScript module (export const ... = {...};), not
// raw JSON, so the object literal is sliced out and trailing commas are
// stripped defensively (the current upstream file has none). The output
// is a plain FeatureCollection with a metadata block that records the
// exact source pin, so the explorer never depends on the TS-module shape
// and the lineage stays machine-readable.
//
// Exit codes mirror tool/merge/verify_provenance.dart:
//   0  regenerated
//   2  raw input absent (data/_raw/ is gitignored; expected in CI)

import 'dart:convert';
import 'dart:io';

const String rawPath =
    'data/_raw/nepali-geo-pro-max/src_geo_local-units.geo.ts';
const String outPath = 'docs/palika-boundaries.geojson';
const int expectedFeatures = 753;

const String sourceRepo = 'l3lackcurtains/nepali-geo-pro-max';
const String sourceCommit = '117fd0f3d2dabae3bd86bfe9e4c57098ffe56669';
const String sourceFile = 'src/geo/local-units.geo.ts';
const String sourceSha256 =
    '561A5E2C40A05947DCE4F85E5019794D8F4125249A1DA34E7579A2688B913472';
const int sourceBytes = 477203;

void main() {
  final raw = File(rawPath);
  if (!raw.existsSync()) {
    stdout.writeln('SKIPPED: $rawPath is not present, so nothing could be\n'
        'regenerated. data/_raw/ is deliberately gitignored, so this is\n'
        'expected in CI and is NOT an upstream change. To regenerate\n'
        'locally, re-fetch per data/SOURCES.md.');
    exit(2);
  }

  final text = raw.readAsStringSync();
  final eq = text.indexOf('=');
  final start = text.indexOf('{', eq);
  final end = text.lastIndexOf('}');
  if (eq < 0 || start < 0 || end <= start) {
    stderr.writeln('ERROR: boundary module shape not recognized');
    exit(1);
  }
  final objectText = text.substring(start, end + 1);
  const featuresKey = '"features":[';
  final featuresStart = objectText.indexOf(featuresKey);
  if (featuresStart < 0) {
    stderr.writeln('ERROR: "features" array not found');
    exit(1);
  }
  final body = objectText.substring(featuresStart + featuresKey.length);
  final featuresEnd = body.lastIndexOf(']');
  final trailingCommas = RegExp(r',\s*([\]}])');
  final featuresText = body
      .substring(0, featuresEnd)
      .replaceAllMapped(trailingCommas, (match) => match.group(1)!);

  final featureCount = '"type":"Feature"'.allMatches(featuresText).length;
  if (featureCount != expectedFeatures) {
    stderr.writeln(
        'ERROR: expected $expectedFeatures features, found $featureCount');
    exit(1);
  }

  final metadata = <String, Object>{
    'source': sourceRepo,
    'sourceCommit': sourceCommit,
    'sourceFile': sourceFile,
    'sourceSha256': sourceSha256,
    'sourceBytes': sourceBytes,
    'upstream': 'younginnovations/nepal-locallevel-map (MIT)',
    'upstreamFile': 'out/municipalities.high.geojson',
    'license': 'MIT',
    'note': 'Simplified derived artifact; regenerate via '
        'tool/generate_palika_boundaries.dart - see data/SOURCES.md',
    'generator': 'tool/generate_palika_boundaries.dart',
  };

  final out = File(outPath);
  out.writeAsStringSync('{"type":"FeatureCollection","metadata":'
      '${jsonEncode(metadata)},"features":[$featuresText]}\n');

  stdout.writeln('OK: wrote $outPath ($featureCount features, '
      '${out.lengthSync()} bytes) from $sourceRepo@$sourceCommit');
}
