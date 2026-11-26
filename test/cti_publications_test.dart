import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portfolio/core/utils/external_navigator.dart';
import 'package:flutter_portfolio/features/cybersecurity/cybersecurity_section.dart';

void main() {
  testWidgets('research publications opens public CTI repository', (tester) async {
    final launched = <Uri>[];
    ExternalNavigator.launch = (uri, {bool preferDownload = false}) async {
      launched.add(uri);
      return true;
    };
    addTearDown(ExternalNavigator.reset);
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: CybersecuritySection()),
      ),
    ));
    final button = find.text('View Research Publications');
    expect(button, findsOneWidget);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(launched.single.toString(),
        'https://github.com/saifaboashour/cti-research');
  });
}
