import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

void main() {
  testWidgets('renders the title and the empty summary', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: AdministrativePickerCard(
            title: 'Service address',
            showSearch: false,
          ),
        ),
      ),
    ));
    expect(find.text('Service address'), findsOneWidget);
    expect(
      find.text('Pick a province, then a district, then a local body.'),
      findsOneWidget,
    );
  });

  testWidgets('clear reports an empty selection and resets the summary',
      (tester) async {
    final cascade = AdministrativeCascade();
    AdministrativeSelection? last;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: AdministrativePickerCard(
            cascade: cascade,
            showSearch: false,
            onChanged: (selection) => last = selection,
          ),
        ),
      ),
    ));

    // Select a body programmatically, the way a saved-address restore would.
    cascade.selectLocalBody(
      NepalAdminApi.getLocalBodiesByType(LocalBodyType.metropolitan).first,
    );
    await tester.pumpAndSettle();
    expect(cascade.selection.isComplete, isTrue);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();
    expect(last, isNotNull);
    expect(last!.isEmpty, isTrue);
    expect(
      find.text('Pick a province, then a district, then a local body.'),
      findsOneWidget,
    );
  });
}
