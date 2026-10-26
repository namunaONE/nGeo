// tool/check_boundary_join.dart — CI gate for the explorer boundary join.
//
// The choropleth shades 753 vendored boundary polygons
// (docs/palika-boundaries.geojson) using the palika rows that back
// docs/data.json (data/nepal_local_levels.json). That only works if the
// two sides join, so this tool mirrors app.js buildBoundaryIndex exactly
// — normalized English name + districtId key (first feature wins), then
// a centroid-in-own-polygon fallback, same district first, features
// claimed at most once — and pins the coverage:
//
//   753 rows, 753 features, 753 joined, no known misses.
//
// It fails on drift in either direction: a palika that stops joining is a
// regression, and a miss that gets fixed leaves the expected list stale.
// Both need a human to look, in the same PR that changed the data.
//
// Exit codes: 0 expected coverage, 1 mismatch, 2 missing inputs.

import 'dart:convert';
import 'dart:io';

const String dataPath = 'data/nepal_local_levels.json';
const String boundariesPath = 'docs/palika-boundaries.geojson';

const int expectedRows = 753;
const int expectedFeatures = 753;
const int expectedJoins = 753;

// Misses are rows neither the name join nor the centroid fallback could
// reach. The 2026-10-26 centroid completion (area-weighted centroids of
// the vendored boundary polygons, geoSource
// "palika-boundaries-centroid") joined the last seven upstream spelling
// variants — Baitedhar (Dolakha), Baraha (Sunsari), Barhagaun
// Muktichhetra (Mustang), Bogatan (Doti), Mugu Karmarong (Mugu),
// Naraphu (Manang), Neshang (Manang) — so the expected list is now
// empty. A palika that stops joining is a regression and fails here.
const List<String> expectedMisses = <String>[];

// District name -> districtId, verbatim from app.js (DISTRICT_ID_BY_NAME).
const Map<String, String> districtIdByName = <String, String>{
  'Achham': 'P7.D01',
  'Arghakhanchi': 'P5.D01',
  'Baglung': 'P4.D01',
  'Baitadi': 'P7.D02',
  'Bajhang': 'P7.D03',
  'Bajura': 'P7.D04',
  'Banke': 'P5.D02',
  'Bara': 'P2.D01',
  'Bhaktapur': 'P3.D01',
  'Bhojpur': 'P1.D01',
  'Chitwan': 'P3.D02',
  'Dadeldhura': 'P7.D05',
  'Dailekh': 'P6.D01',
  'Dang': 'P5.D04',
  'Darchula': 'P7.D06',
  'Dhading': 'P3.D03',
  'Dhankuta': 'P1.D02',
  'Dhanusha': 'P2.D02',
  'Dolakha': 'P3.D04',
  'Dolpa': 'P6.D02',
  'Doti': 'P7.D07',
  'Gorkha': 'P4.D02',
  'Gulmi': 'P5.D06',
  'Humla': 'P6.D03',
  'Ilam': 'P1.D03',
  'Jajarkot': 'P6.D04',
  'Jhapa': 'P1.D04',
  'Jumla': 'P6.D05',
  'Kailali': 'P7.D08',
  'Kalikot': 'P6.D06',
  'Kanchanpur': 'P7.D09',
  'Kapilvastu': 'P5.D07',
  'Kaski': 'P4.D03',
  'Kathmandu': 'P3.D05',
  'Kavrepalanchok': 'P3.D06',
  'Khotang': 'P1.D05',
  'Lalitpur': 'P3.D07',
  'Lamjung': 'P4.D04',
  'Mahottari': 'P2.D03',
  'Makwanpur': 'P3.D08',
  'Manang': 'P4.D05',
  'Morang': 'P1.D06',
  'Mugu': 'P6.D07',
  'Mustang': 'P4.D06',
  'Myagdi': 'P4.D07',
  'Nawalpur': 'P4.D08',
  'Nuwakot': 'P3.D09',
  'Okhaldhunga': 'P1.D07',
  'Palpa': 'P5.D08',
  'Panchthar': 'P1.D08',
  'Parasi (Nawalparasi West)': 'P5.D09',
  'Parbat': 'P4.D09',
  'Parsa': 'P2.D04',
  'Pyuthan': 'P5.D10',
  'Ramechhap': 'P3.D10',
  'Rasuwa': 'P3.D11',
  'Rautahat': 'P2.D05',
  'Rolpa': 'P5.D11',
  'Rukum East': 'P5.D05',
  'Rukum West': 'P6.D10',
  'Rupandehi': 'P5.D12',
  'Salyan': 'P6.D08',
  'Sankhuwasabha': 'P1.D09',
  'Saptari': 'P2.D06',
  'Sarlahi': 'P2.D07',
  'Sindhuli': 'P3.D12',
  'Sindhupalchok': 'P3.D13',
  'Siraha': 'P2.D08',
  'Solukhumbu': 'P1.D10',
  'Sunsari': 'P1.D11',
  'Surkhet': 'P6.D09',
  'Syangja': 'P4.D10',
  'Tanahun': 'P4.D11',
  'Taplejung': 'P1.D12',
  'Terhathum': 'P1.D13',
  'Udayapur': 'P1.D14',
};

final RegExp _dashRe = RegExp('[\u2013\u2014]');
final RegExp _nonNameRe = RegExp('[^a-z0-9\u0900-\u097F]+');
final RegExp _typeSuffixRe =
    RegExp(' (rural municipality|municipality|sub metropolis|'
        'sub metropolitan city|metropolitan city|metropolis|gaunpalika|'
        'nagarpalika|upamahanagarpalika|mahanagarpalika)\$');
final RegExp _spaceRe = RegExp(' ');

/// Exact port of app.js normPalikaName — the join key depends on it.
String normPalikaName(String input) {
  var s = input.toLowerCase();
  s = s.replaceAll(_dashRe, '-');
  s = s.replaceAll(_nonNameRe, ' ');
  s = s.trim();
  s = s.replaceAll(_typeSuffixRe, '');
  s = s.replaceAll(_spaceRe, '');
  return s;
}

class PalikaRow {
  PalikaRow(this.name, this.district, this.districtId, this.lat, this.lng);

  final String name;
  final String district;
  final String districtId;
  final double? lat;
  final double? lng;
  BoundaryFeature? matched;

  String get label => '$name ($districtId $district)';
}

class BoundaryFeature {
  BoundaryFeature(this.properties, this.geometry);

  final Map<String, dynamic> properties;
  final Map<String, dynamic>? geometry;
  bool claimed = false;
}

bool pointInRing(double x, double y, List<dynamic> ring) {
  var inside = false;
  for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
    final xi = (ring[i][0] as num).toDouble();
    final yi = (ring[i][1] as num).toDouble();
    final xj = (ring[j][0] as num).toDouble();
    final yj = (ring[j][1] as num).toDouble();
    final straddles =
        (yi > y) != (yj > y) && x < (xj - xi) * (y - yi) / (yj - yi) + xi;
    if (straddles) {
      inside = !inside;
    }
  }
  return inside;
}

bool pointInGeometry(double x, double y, Map<String, dynamic>? geom) {
  if (geom == null) {
    return false;
  }
  final type = geom['type'];
  final polys = <dynamic>[];
  if (type == 'Polygon') {
    polys.add(geom['coordinates']);
  } else if (type == 'MultiPolygon') {
    polys.addAll(geom['coordinates'] as List<dynamic>);
  } else {
    return false;
  }
  for (final poly in polys) {
    final rings = poly as List<dynamic>;
    if (pointInRing(x, y, rings[0] as List<dynamic>)) {
      var inHole = false;
      for (var h = 1; h < rings.length; h++) {
        if (pointInRing(x, y, rings[h] as List<dynamic>)) {
          inHole = true;
          break;
        }
      }
      if (!inHole) {
        return true;
      }
    }
  }
  return false;
}

BoundaryFeature? _pipScan(
  List<BoundaryFeature> features,
  double x,
  double y,
  String? districtId,
) {
  for (final feature in features) {
    if (feature.claimed) {
      continue;
    }
    if (districtId != null && districtId.isNotEmpty) {
      final featureDistrict = feature.properties['districtId'];
      if (featureDistrict != districtId) {
        continue;
      }
    }
    if (pointInGeometry(x, y, feature.geometry)) {
      return feature;
    }
  }
  return null;
}

Map<String, dynamic> _readJsonMap(File file) {
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

bool _sameList(List<String> actual, List<String> expected) {
  if (actual.length != expected.length) {
    return false;
  }
  for (var i = 0; i < actual.length; i++) {
    if (actual[i] != expected[i]) {
      return false;
    }
  }
  return true;
}

void main() {
  final dataFile = File(dataPath);
  final boundariesFile = File(boundariesPath);
  if (!dataFile.existsSync() || !boundariesFile.existsSync()) {
    stderr.writeln('ERROR: $dataPath or $boundariesPath is missing; '
        'run from the package root.');
    exit(2);
  }

  final data = _readJsonMap(dataFile);
  final boundaries = _readJsonMap(boundariesFile);

  // Rows enumerated like generate_explorer_data.dart (province ->
  // district -> local body), then sorted districtId + name so the
  // claim-once fallback below is deterministic.
  final rows = <PalikaRow>[];
  final provinces = data['provinces'] as List<dynamic>;
  for (final province in provinces) {
    final districts =
        (province as Map<String, dynamic>)['districts'] as List<dynamic>;
    for (final districtEntry in districts) {
      final district = districtEntry as Map<String, dynamic>;
      final districtName = district['name'] as String;
      final districtId = districtIdByName[districtName] ?? '';
      final bodies = district['localBodies'] as List<dynamic>;
      for (final body in bodies) {
        final localBody = body as Map<String, dynamic>;
        rows.add(PalikaRow(
          localBody['name'] as String,
          districtName,
          districtId,
          (localBody['lat'] as num?)?.toDouble(),
          (localBody['lng'] as num?)?.toDouble(),
        ));
      }
    }
  }
  rows.sort((PalikaRow a, PalikaRow b) {
    final byDistrict = a.districtId.compareTo(b.districtId);
    if (byDistrict != 0) {
      return byDistrict;
    }
    return a.name.compareTo(b.name);
  });

  final features = <BoundaryFeature>[];
  final featureList = boundaries['features'] as List<dynamic>;
  for (final entry in featureList) {
    final feature = entry as Map<String, dynamic>;
    features.add(BoundaryFeature(
      (feature['properties'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      feature['geometry'] as Map<String, dynamic>?,
    ));
  }

  // 1) name join within the district (first feature wins, claim once)
  final byKey = <String, BoundaryFeature>{};
  for (final feature in features) {
    final featureDistrictId = feature.properties['districtId'] as String? ?? '';
    final featureName = feature.properties['nameEn'] as String? ?? '';
    final key = '$featureDistrictId|${normPalikaName(featureName)}';
    byKey.putIfAbsent(key, () => feature);
  }
  var nameJoins = 0;
  for (final row in rows) {
    final key = '${row.districtId}|${normPalikaName(row.name)}';
    final feature = byKey[key];
    if (feature != null && !feature.claimed) {
      row.matched = feature;
      feature.claimed = true;
      nameJoins++;
    }
  }

  // 2) centroid-in-own-polygon fallback, same district first, claim once
  var pipJoins = 0;
  for (final row in rows) {
    if (row.matched != null || row.lat == null || row.lng == null) {
      continue;
    }
    var hit = _pipScan(features, row.lng!, row.lat!, row.districtId);
    hit ??= _pipScan(features, row.lng!, row.lat!, null);
    if (hit != null) {
      row.matched = hit;
      hit.claimed = true;
      pipJoins++;
    }
  }

  var joinedCount = 0;
  var unclaimedCount = 0;
  final misses = <String>[];
  for (final row in rows) {
    if (row.matched == null) {
      misses.add(row.label);
    } else {
      joinedCount++;
    }
  }
  for (final feature in features) {
    if (!feature.claimed) {
      unclaimedCount++;
    }
  }
  misses.sort();

  stdout.writeln('boundary join coverage: $joinedCount/${rows.length}');
  stdout.writeln('  name joins: $nameJoins');
  stdout.writeln('  point-in-polygon joins: $pipJoins');
  stdout.writeln('  unclaimed boundary features: $unclaimedCount');
  for (final miss in misses) {
    stdout.writeln('  miss: $miss');
  }

  final problems = <String>[];
  if (rows.length != expectedRows) {
    problems.add('rows: ${rows.length} (expected $expectedRows)');
  }
  if (features.length != expectedFeatures) {
    problems.add('features: ${features.length} (expected $expectedFeatures)');
  }
  if (joinedCount != expectedJoins) {
    problems.add('joined: $joinedCount (expected $expectedJoins)');
  }
  if (!_sameList(misses, expectedMisses)) {
    problems.add('miss list changed: ${misses.length} actual vs '
        '${expectedMisses.length} expected');
  }

  if (problems.isNotEmpty) {
    stderr.writeln('FAIL: boundary join coverage gate');
    for (final problem in problems) {
      stderr.writeln('  - $problem');
    }
    stderr.writeln('actual misses (${misses.length}):');
    for (final miss in misses) {
      stderr.writeln('  - $miss');
    }
    stderr.writeln('expected misses (${expectedMisses.length}):');
    for (final miss in expectedMisses) {
      stderr.writeln('  - $miss');
    }
    exit(1);
  }

  stdout.writeln('OK: $expectedJoins/$expectedRows joined with '
      '${expectedMisses.length} known misses - coverage as pinned.');
}
