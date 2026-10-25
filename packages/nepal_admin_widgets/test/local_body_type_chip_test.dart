import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('renders the full type name for every palika type',
      (tester) async {
    for (final type in LocalBodyType.values) {
      await tester.pumpWidget(_wrap(LocalBodyTypeChip(type: type)));
      expect(find.text(type.fullName), findsOneWidget);
    }
  });

  testWidgets('compact mode uses the dataset abbreviation', (tester) async {
    for (final type in LocalBodyType.values) {
      await tester
          .pumpWidget(_wrap(LocalBodyTypeChip(type: type, compact: true)));
      expect(find.text(type.shortName), findsOneWidget);
    }
  });

  test('accents are pairwise distinct across the real types', () {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6));
    final accents = <Color>{
      for (final type in LocalBodyType.values)
        if (type != LocalBodyType.unknown)
          LocalBodyTypeChip.accentFor(type, scheme),
    };
    expect(accents.length, 4,
        reason: 'each palika type must read as its own colour');
  });

  test('every one of the 753 bodies has a renderable type accent', () {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF3B82F6));
    for (final body in NepalAdminApi.getAllLocalBodies()) {
      expect(LocalBodyTypeChip.accentFor(body.type, scheme), isNotNull);
    }
  });
}
