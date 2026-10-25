import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(
        body: Center(child: SizedBox(width: 420, child: child)),
      ),
    );

LocalBody get _metro =>
    NepalAdminApi.getLocalBodiesByType(LocalBodyType.metropolitan).first;

void main() {
  testWidgets('empty state says what to do', (tester) async {
    await tester
        .pumpWidget(_wrap(const AdministrativeSummaryCard(body: null)));
    expect(find.text('Pick a province, then a district, then a local body.'),
        findsOneWidget);
  });

  testWidgets('shows a selected palika end to end', (tester) async {
    final body = _metro;
    await tester.pumpWidget(_wrap(AdministrativeSummaryCard(body: body)));
    expect(find.text(body.name), findsOneWidget);
    expect(find.text(body.type.fullName), findsOneWidget);
    expect(find.text('${body.districtName} · ${body.provinceName}'),
        findsOneWidget);
    expect(
        find.text(TrustBadge.labelFor(body.cbsCodeConfidence)),
        findsOneWidget);
  });

  testWidgets('an uncoded palika never shows a code', (tester) async {
    final uncoded = NepalAdminApi.getUncodedLocalBodies();
    expect(uncoded, isNotEmpty);
    await tester
        .pumpWidget(_wrap(AdministrativeSummaryCard(body: uncoded.first)));
    expect(find.text('Not coded'), findsOneWidget);
  });

  testWidgets('onTap fires once per tap', (tester) async {
    var taps = 0;
    final body = _metro;
    await tester.pumpWidget(_wrap(AdministrativeSummaryCard(
      body: body,
      onTap: () => taps++,
    )));
    await tester.tap(find.byType(AdministrativeSummaryCard));
    expect(taps, 1);
  });
}
