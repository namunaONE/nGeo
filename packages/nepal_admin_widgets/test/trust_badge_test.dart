import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nepal_admin_api/nepal_admin_api.dart';
import 'package:nepal_admin_widgets/nepal_admin_widgets.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  test('every tier has a non-empty label, tooltip and icon', () {
    for (final confidence in CbsCodeConfidence.values) {
      expect(TrustBadge.labelFor(confidence), isNotEmpty);
      expect(TrustBadge.tooltipFor(confidence), isNotEmpty);
      expect(TrustBadge.iconFor(confidence), isNotNull);
    }
  });

  test('all 753 local bodies map onto a defined tier', () {
    final bodies = NepalAdminApi.getAllLocalBodies();
    expect(bodies, hasLength(753));
    for (final body in bodies) {
      expect(TrustBadge.labelFor(body.cbsCodeConfidence), isNotEmpty);
      expect(TrustBadge.tooltipFor(body.cbsCodeConfidence), isNotEmpty);
    }
  });

  testWidgets('renders the right label for a real palika of each tier',
      (tester) async {
    final verified = NepalAdminApi.getVerifiedLocalBodies();
    final singleSource = NepalAdminApi.getSingleSourceLocalBodies();
    final uncoded = NepalAdminApi.getUncodedLocalBodies();

    // The dataset documents all three tiers as non-empty (see CHANGELOG).
    expect(verified, isNotEmpty,
        reason: 'dataset must carry doubly-attested codes');
    expect(singleSource, isNotEmpty,
        reason: 'dataset must carry single-source codes');
    expect(uncoded, isNotEmpty, reason: 'dataset must carry uncoded palikas');

    final samples = <CbsCodeConfidence, LocalBody>{
      CbsCodeConfidence.verified: verified.first,
      CbsCodeConfidence.singleSource: singleSource.first,
      CbsCodeConfidence.unverified: uncoded.first,
    };

    for (final entry in samples.entries) {
      await tester
          .pumpWidget(_wrap(TrustBadge.confidence(confidence: entry.key)));
      expect(find.text(TrustBadge.labelFor(entry.key)), findsOneWidget);
    }
  });

  testWidgets('renders from a body and in compact form', (tester) async {
    final body = NepalAdminApi.getVerifiedLocalBodies().first;
    await tester.pumpWidget(_wrap(TrustBadge.forLocalBody(body: body)));
    expect(find.text('Doubly attested'), findsOneWidget);

    await tester.pumpWidget(_wrap(const TrustBadge.confidence(
      confidence: CbsCodeConfidence.verified,
      compact: true,
    )));
    expect(find.byIcon(Icons.verified), findsOneWidget);
    expect(find.text('Doubly attested'), findsNothing);
  });

  testWidgets('themes in dark mode', (tester) async {
    final body = NepalAdminApi.getVerifiedLocalBodies().first;
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(body: Center(child: TrustBadge.forLocalBody(body: body))),
    ));
    expect(find.text('Doubly attested'), findsOneWidget);
  });
}
