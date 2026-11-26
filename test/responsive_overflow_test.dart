import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_portfolio/app/app.dart';

void main() {
  final viewports = <String, Size>{
    '375': const Size(375, 812),
    '768': const Size(768, 1024),
    '1024': const Size(1024, 900),
    '1440': const Size(1440, 900),
  };

  for (final entry in viewports.entries) {
    testWidgets('no overflow exceptions at width ${entry.key}', (tester) async {
      final errors = <FlutterErrorDetails>[];
      final oldHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        errors.add(details);
        oldHandler?.call(details);
      };
      addTearDown(() => FlutterError.onError = oldHandler);

      tester.view.physicalSize = entry.value;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const PortfolioApp());
      await tester.pump();

      // Scroll through content to surface layout issues below the fold.
      final gesture = await tester.startGesture(const Offset(200, 400));
      for (var i = 0; i < 12; i++) {
        await gesture.moveBy(const Offset(0, -300));
        await tester.pump(const Duration(milliseconds: 16));
      }
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 100));

      final overflow = errors.where(
        (e) => e.exceptionAsString().contains('overflowed'),
      );
      expect(
        overflow,
        isEmpty,
        reason: 'Unexpected overflow at ${entry.key}px: $overflow',
      );

      expect(find.text('Download CV'), findsOneWidget);
      expect(find.text('View Projects'), findsWidgets);
    });
  }

  testWidgets('text scale 1.3 remains usable on mobile', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(375, 812),
          textScaler: TextScaler.linear(1.3),
        ),
        child: const PortfolioApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Seif Abuashour'), findsWidgets);
    expect(find.text('Download CV'), findsOneWidget);
    expect(find.byTooltip('Menu'), findsOneWidget);
  });

  testWidgets('reduced motion skips long scroll animation duration path',
      (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(1440, 900),
          disableAnimations: true,
        ),
        child: const PortfolioApp(),
      ),
    );
    await tester.pump();

    await tester.ensureVisible(find.text('View Projects'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View Projects'));
    await tester.pump(); // should complete without needing long settle
    expect(find.textContaining('Featured work'), findsOneWidget);
  });
}
