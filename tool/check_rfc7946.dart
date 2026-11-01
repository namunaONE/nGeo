// tool/check_rfc7946.dart - CI gate: every GeoJSON artifact this repo
// ships must conform to RFC 7946.
//
// The artifacts come from more than one pipeline - HDX COD-AB extracts,
// younginnovations-derived simplifications, OpenStreetMap corridors -
// and every one is downstream of a shapefile-style converter somewhere
// in its lineage. That is exactly the class of pipeline that silently
// emits a legacy "crs" member, axis-flipped coordinates or unclosed
// rings. A one-off pre-scan of the fetchable artifacts (2026-11-01)
// came back clean - and the gate's first full CI run then caught what
// no hand scan could see: the 40 MB high-resolution palika boundary
// file ships its converter's legacy "crs" member. That is the point:
// the gate scans every artifact on every run, including the ones too
// big to open by hand. The sanitize-crs auto-heal then removed that
// member in place on this branch: one line, zero reformatting.
//
// Checks, per file (every docs/*.geojson and bindings/geojson/*.geojson):
//   - parses as JSON and is a FeatureCollection
//   - no legacy "crs" member on the collection, a feature or a
//     geometry: RFC 7946 removed it, and a converter that did not get
//     the memo announces itself here. Foreign members stay legal - the
//     "metadata" block on districts.elevation.geojson documents its CRS
//     in prose, which is fine and must never fail this gate.
//   - every position is [lon, lat] with finite numbers in the RFC
//     ranges, plus the Nepal band from tool/check_boundary_topology.dart
//     (lon 79.5-89.0, lat 26.0-31.0); a lon/lat swap puts latitudes in
//     the lon slot and never passes this band.
//   - a null geometry is legal (districts.elevation.geojson ships 77)
//   - Polygon/MultiPolygon rings with four or more positions must
//     close; degenerate rings (fewer than 4) are counted and reported,
//     never failed - the source data ships zero-area sliver artifacts
//     (Naraphu, Manang), the same stance as the topology gate.
//   - LineStrings carry at least two positions (lines never close)
//   - a "bbox" member, when present, must be 4 (or 6) finite numbers
//     with min <= max, and a geometry's bbox must contain the actual
//     coordinates it claims to bound.
//
// Usage (from the repository root):
//   dart run tool/check_rfc7946.dart              the gate (exit 0 = pass)
//   dart run tool/check_rfc7946.dart --strip-crs  the matching auto-heal
//
// --strip-crs removes the collection-level legacy "crs" member from
// every file it walks, surgically and in place; the sanitize-crs
// workflow runs it and then re-runs the gate to prove the healed tree
// conforms. Exit 0 = pass, 1 = fail. Wired into
// .github/workflows/dart.yml (gate) and .github/workflows/
// sanitize-crs.yml (heal).

import 'dart:convert';
import 'dart:io';

Never _abort(String message) {
  stderr.writeln('check_rfc7946: $message');
  exit(1);
}

// The Nepal band tool/check_boundary_topology.dart already proves on
// the package-encoded palika geometry. Every vendored artifact
// describes Nepal; a swapped [lat, lon] position lands outside it.
const double nepalMinLon = 79.5;
const double nepalMaxLon = 89.0;
const double nepalMinLat = 26.0;
const double nepalMaxLat = 31.0;

// Annotations are capped so a systematic defect in a 40 MB file stays
// readable from the Checks tab; the failure count stays exact.
const int maxReported = 25;

final List<String> failures = <String>[];
int failureCount = 0;
int filesChecked = 0;
int positionsChecked = 0;
int ringsChecked = 0;
int degenerateRings = 0;

void fail(String file, String because) {
  failureCount++;
  if (failures.length < maxReported) {
    failures.add('::error file=$file::rfc7946: $because');
  }
}

/// The coordinate extent of one geometry, so its "bbox" member can be
/// held against what the coordinates actually say.
class Extent {
  double minLon = double.infinity;
  double maxLon = double.negativeInfinity;
  double minLat = double.infinity;
  double maxLat = double.negativeInfinity;
  int positions = 0;

  void note(double lon, double lat) {
    if (lon < minLon) minLon = lon;
    if (lon > maxLon) maxLon = lon;
    if (lat < minLat) minLat = lat;
    if (lat > maxLat) maxLat = lat;
    positions++;
  }
}

/// Two positions agree on lon and lat.
bool samePosition(dynamic a, dynamic b) {
  if (a is! List || b is! List || a.length < 2 || b.length < 2) {
    return false;
  }
  return a[0] == b[0] && a[1] == b[1];
}

/// Validates one position - [lon, lat] or [lon, lat, elevation] - and
/// folds it into the extent.
void checkPosition(String file, dynamic position, String where, Extent extent) {
  if (position is! List || position.length < 2) {
    fail(file, '$where: position is not a [lon, lat] pair.');
    return;
  }
  final lon = position[0];
  final lat = position[1];
  if (lon is! num || lat is! num) {
    fail(file, '$where: lon/lat are not both numbers.');
    return;
  }
  if (!lon.isFinite || !lat.isFinite) {
    fail(file, '$where: lon/lat are not finite.');
    return;
  }
  for (var i = 2; i < position.length; i++) {
    final elevation = position[i];
    if (elevation is! num || !elevation.isFinite) {
      fail(file, '$where: position slot $i is not a finite number.');
      return;
    }
  }
  if (lon < -180 || lon > 180 || lat < -90 || lat > 90) {
    fail(file, '$where: [$lon, $lat] is outside the WGS84 ranges.');
    return;
  }
  if (lon < nepalMinLon ||
      lon > nepalMaxLon ||
      lat < nepalMinLat ||
      lat > nepalMaxLat) {
    fail(file, '$where: [$lon, $lat] is outside the Nepal band.');
    return;
  }
  positionsChecked++;
  extent.note(lon.toDouble(), lat.toDouble());
}

/// Rings with four or more positions must close. Degenerate rings are
/// counted and reported, never failed: the source data ships zero-area
/// sliver artifacts (Naraphu, Manang) and the topology gate already
/// documents that stance.
void checkRing(String file, dynamic ring, String where, Extent extent) {
  if (ring is! List) {
    fail(file, '$where: ring is not a list of positions.');
    return;
  }
  if (ring.isEmpty) {
    return; // An empty geometry is legal; nothing to check.
  }
  ringsChecked++;
  if (ring.length < 4) {
    degenerateRings++;
  } else if (!samePosition(ring[0], ring[ring.length - 1])) {
    fail(file, '$where: ring is not closed (first != last).');
  }
  for (var i = 0; i < ring.length; i++) {
    checkPosition(file, ring[i], '$where position $i', extent);
  }
}

/// Lines never close; a LineString needs at least two positions.
void checkLine(String file, dynamic line, String where, Extent extent) {
  if (line is! List) {
    fail(file, '$where: line is not a list of positions.');
    return;
  }
  if (line.length < 2) {
    fail(file, '$where: line needs at least two positions.');
    return;
  }
  for (var i = 0; i < line.length; i++) {
    checkPosition(file, line[i], '$where position $i', extent);
  }
}

/// MultiPoint and validated LineString position lists.
void checkEachPosition(String file, dynamic list, String where, Extent extent) {
  if (list is! List) {
    fail(file, '$where: coordinates is not a list.');
    return;
  }
  for (var i = 0; i < list.length; i++) {
    checkPosition(file, list[i], '$where position $i', extent);
  }
}

/// A bbox is [minLon, minLat, maxLon, maxLat] or the 3D six-number
/// form. Returns whether the member was present and well formed.
bool checkBboxShape(String file, dynamic bbox, String where) {
  if (bbox == null) {
    return false; // A bbox is optional.
  }
  if (bbox is! List || (bbox.length != 4 && bbox.length != 6)) {
    fail(file, '$where: needs 4 (or 6) numbers.');
    return false;
  }
  for (final value in bbox) {
    if (value is! num || !value.isFinite) {
      fail(file, '$where: holds a non-finite number.');
      return false;
    }
  }
  final size = bbox.length;
  final loLon = (bbox[0] as num).toDouble();
  final loLat = (bbox[1] as num).toDouble();
  final hiLon = (bbox[size - 2] as num).toDouble();
  final hiLat = (bbox[size - 1] as num).toDouble();
  if (loLon > hiLon || loLat > hiLat) {
    fail(file, '$where: min exceeds max.');
    return false;
  }
  return true;
}

/// The bbox must actually bound the coordinates it claims to.
void checkBboxContains(
    String file, List<dynamic> bbox, Extent extent, String where) {
  const slack = 1e-9;
  final size = bbox.length;
  final loLon = (bbox[0] as num).toDouble() - slack;
  final loLat = (bbox[1] as num).toDouble() - slack;
  final hiLon = (bbox[size - 2] as num).toDouble() + slack;
  final hiLat = (bbox[size - 1] as num).toDouble() + slack;
  final contains = extent.minLon >= loLon &&
      extent.maxLon <= hiLon &&
      extent.minLat >= loLat &&
      extent.maxLat <= hiLat;
  if (!contains) {
    fail(file, '$where: does not contain the coordinates.');
  }
}

/// RFC 7946 removed the "crs" member: a WGS84 lon/lat file never needs
/// one. Only real GeoJSON objects are checked - prose notes inside
/// foreign members (metadata.crs) are documentation, not a crs member.
void checkNoCrs(String file, Map<String, dynamic> object, String where) {
  if (object.containsKey('crs')) {
    fail(file, '$where: legacy "crs" member present.');
  }
}

void checkGeometry(String file, dynamic geometry, String where) {
  if (geometry == null) {
    return; // A null geometry is legal (elevation stats ship 77).
  }
  if (geometry is! Map<String, dynamic>) {
    fail(file, '$where: geometry is not an object.');
    return;
  }
  checkNoCrs(file, geometry, where);
  final type = geometry['type'];
  final coordinates = geometry['coordinates'];
  if (type == 'GeometryCollection') {
    final members = geometry['geometries'];
    checkBboxShape(file, geometry['bbox'], '$where bbox');
    if (members is! List) {
      fail(file, '$where: GeometryCollection without a geometries list.');
      return;
    }
    for (var i = 0; i < members.length; i++) {
      checkGeometry(file, members[i], '$where geometry $i');
    }
    return;
  }
  final extent = Extent();
  if (type == 'Point') {
    checkPosition(file, coordinates, '$where Point', extent);
  } else if (type == 'MultiPoint') {
    checkEachPosition(file, coordinates, '$where MultiPoint', extent);
  } else if (type == 'LineString') {
    if (coordinates is! List) {
      fail(file, '$where: LineString coordinates is not a list.');
    } else if (coordinates.isNotEmpty && coordinates.length < 2) {
      fail(file, '$where: LineString needs at least two positions.');
    } else {
      checkEachPosition(file, coordinates, '$where LineString', extent);
    }
  } else if (type == 'MultiLineString') {
    if (coordinates is! List) {
      fail(file, '$where: MultiLineString coordinates is not a list.');
    } else {
      for (var i = 0; i < coordinates.length; i++) {
        checkLine(file, coordinates[i], '$where line $i', extent);
      }
    }
  } else if (type == 'Polygon') {
    if (coordinates is! List) {
      fail(file, '$where: Polygon coordinates is not a list.');
    } else {
      for (var i = 0; i < coordinates.length; i++) {
        checkRing(file, coordinates[i], '$where ring $i', extent);
      }
    }
  } else if (type == 'MultiPolygon') {
    if (coordinates is! List) {
      fail(file, '$where: MultiPolygon coordinates is not a list.');
    } else {
      for (var i = 0; i < coordinates.length; i++) {
        final polygon = coordinates[i];
        if (polygon is! List) {
          fail(file, '$where polygon $i is not a list of rings.');
          continue;
        }
        for (var r = 0; r < polygon.length; r++) {
          checkRing(file, polygon[r], '$where polygon $i ring $r', extent);
        }
      }
    }
  } else {
    fail(file, '$where: unknown geometry type "$type".');
    return;
  }
  final bbox = geometry['bbox'];
  if (checkBboxShape(file, bbox, '$where bbox') && extent.positions > 0) {
    checkBboxContains(file, bbox as List, extent, '$where bbox');
  }
}

void checkFeature(String file, dynamic feature, String where) {
  if (feature is! Map<String, dynamic>) {
    fail(file, '$where: feature is not an object.');
    return;
  }
  checkNoCrs(file, feature, where);
  if (feature['type'] != 'Feature') {
    fail(file, '$where: type is not "Feature".');
  }
  // Shape only: extent containment is enforced on geometry bboxes.
  checkBboxShape(file, feature['bbox'], '$where bbox');
  checkGeometry(file, feature['geometry'], '$where geometry');
}

void checkCollection(String file, Map<String, dynamic> root) {
  checkNoCrs(file, root, 'feature collection');
  if (root['type'] != 'FeatureCollection') {
    fail(file, 'type is not "FeatureCollection".');
  }
  checkBboxShape(file, root['bbox'], 'feature collection bbox');
  final features = root['features'];
  if (features is! List) {
    fail(file, '"features" is not a list.');
    return;
  }
  for (var i = 0; i < features.length; i++) {
    checkFeature(file, features[i], 'feature $i');
  }
}

void checkFile(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    _abort('$path not found - run from the repository root.');
  }
  dynamic root;
  try {
    root = jsonDecode(file.readAsStringSync());
  } on FormatException catch (error) {
    fail(path, 'invalid JSON: ' + error.message);
    return;
  }
  if (root is! Map<String, dynamic>) {
    fail(path, 'root is not an object.');
    return;
  }
  checkCollection(path, root);
  filesChecked++;
}

/// The whitespace the strip walks over (never a regex: the exact
/// bytes matter, and so does staying parser-free).
bool isWhitespace(String char) {
  return char == ' ' || char == '\n' || char == '\r' || char == '\t';
}

/// Finds the offset of the collection-level "crs" key: the member
/// the gate bans. The scan is string-aware (escaped quotes are
/// skipped) and depth-aware, so a "crs" note inside metadata or a
/// feature - prose at object depth 2 or deeper, perfectly legal -
/// can never masquerade as the root member.
/// bindings/geojson/districts.elevation.geojson documents its CRS
/// exactly that way, and the first strip run aborted on it because a
/// naive first-occurrence search cannot tell the two apart. Returns
/// -1 when the file carries no root-level member.
int findRootCrsKey(String text) {
  var depth = 0;
  var i = 0;
  while (i < text.length) {
    final char = text[i];
    if (char == '{') {
      depth++;
    } else if (char == '}') {
      depth--;
    } else if (char == '"') {
      final start = i;
      i++;
      while (i < text.length && text[i] != '"') {
        if (text[i] == '\\') {
          i++;
        }
        i++;
      }
      final key = text.substring(start, i + 1);
      i++;
      var j = i;
      while (j < text.length && isWhitespace(text[j])) {
        j++;
      }
      if (depth == 1 && j < text.length && text[j] == ':' && key == '"crs"') {
        return start;
      }
    }
    i++;
  }
  return -1;
}

/// Removes the collection-level legacy "crs" member, keeping every
/// other byte untouched: a 40 MB artifact keeps a one-line diff, and
/// prose "crs" notes inside foreign members stay where they are.
/// Only the converter shape ever seen here is handled - an object
/// value, separated like a proper member - anything else aborts
/// rather than guess. Returns the healed text, or null when there is
/// nothing to strip.
String? stripRootCrs(String path, String text) {
  final key = findRootCrsKey(text);
  if (key < 0) {
    return null;
  }
  var start = key;
  while (start > 0 && isWhitespace(text[start - 1])) {
    start--;
  }
  var value = key;
  while (value < text.length && text[value] != ':') {
    value++;
  }
  value++;
  while (value < text.length && isWhitespace(text[value])) {
    value++;
  }
  if (value >= text.length || text[value] != '{') {
    _abort('$path: "crs" member is not an object value - fix by hand.');
  }
  final open = value;
  var depth = 0;
  var close = -1;
  for (var i = open; i < text.length; i++) {
    if (text[i] == '{') {
      depth++;
    } else if (text[i] == '}') {
      depth--;
      if (depth == 0) {
        close = i;
        break;
      }
    }
  }
  if (close < 0) {
    _abort('$path: "crs" member value is not closed.');
  }
  var end = close + 1;
  while (end < text.length && isWhitespace(text[end])) {
    end++;
  }
  if (end < text.length && text[end] == ',') {
    // The member is followed by a comma: cut through the end of its
    // line so no blank line remains.
    while (end < text.length && text[end] != '\n') {
      end++;
    }
    if (end < text.length) {
      end++;
    }
  } else if (start > 0 && text[start - 1] == ',') {
    // Last member: the separator comma sits in front of it.
    start--;
  } else {
    _abort('$path: "crs" member shape is unexpected - fix by hand.');
  }
  final healed = text.replaceRange(start, end, '');
  dynamic root;
  try {
    root = jsonDecode(healed);
  } on FormatException catch (error) {
    _abort('$path: strip produced invalid JSON: ' + error.message);
  }
  if (root is! Map<String, dynamic> || root.containsKey('crs')) {
    _abort('$path: strip did not remove the collection-level member.');
  }
  return healed;
}

/// The auto-heal walk: strip the legacy "crs" member in place when a
/// file carries one. The workflow re-runs the gate right after, so a
/// strip that broke anything fails before a commit exists.
void stripFile(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    _abort('$path not found - run from the repository root.');
  }
  final text = file.readAsStringSync();
  final healed = stripRootCrs(path, text);
  if (healed == null) {
    return;
  }
  final removed = text.length - healed.length;
  file.writeAsStringSync(healed, flush: true);
  stdout.writeln('rfc7946 strip: removed the legacy "crs" member from '
      '$path ($removed bytes).');
}

void main(List<String> arguments) {
  // Every vendored artifact lives in one of two directories: docs/
  // (website overlays and boundary payloads) and bindings/geojson/
  // (the public downloads, staged into the site artifact at deploy).
  // --strip-crs switches this same walk from gate to auto-heal: the
  // collection-level legacy "crs" member is surgically removed in
  // place instead of reported.
  final stripCrs = arguments.contains('--strip-crs');
  final dirs = <String>[];
  for (final argument in arguments) {
    if (!argument.startsWith('-')) {
      dirs.add(argument);
    }
  }
  if (dirs.isEmpty) {
    dirs.add('docs');
    dirs.add('bindings/geojson');
  }
  for (final dir in dirs) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      _abort('$dir not found - run from the repository root.');
    }
    final paths = <String>[];
    for (final entity in directory.listSync()) {
      if (entity is File && entity.path.endsWith('.geojson')) {
        paths.add(entity.path);
      }
    }
    if (paths.isEmpty) {
      _abort('no .geojson files found under $dir/.');
    }
    paths.sort();
    for (final path in paths) {
      if (stripCrs) {
        stripFile(path);
      } else {
        checkFile(path);
      }
    }
  }
  if (stripCrs) {
    return; // The gate re-run afterwards is the proof, not this pass.
  }
  if (degenerateRings > 0) {
    stdout.writeln('INFO: $degenerateRings degenerate ring(s) - source '
        'artifacts, reported not failed (topology gate stance).');
  }
  if (failures.isEmpty) {
    stdout.writeln('rfc7946 OK: $filesChecked file(s) conform: WGS84 '
        'lon/lat, Nepal band, closed rings, no legacy "crs" member.');
    return;
  }
  for (final failure in failures) {
    stderr.writeln(failure);
  }
  _abort('$failureCount RFC 7946 violation(s).');
}
