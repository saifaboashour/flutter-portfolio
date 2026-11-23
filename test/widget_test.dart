import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_portfolio/app/app.dart';
import 'package:flutter_portfolio/app/portfolio_page.dart';
import 'package:flutter_portfolio/core/content/portfolio_data.dart';
import 'package:flutter_portfolio/core/content/portfolio_models.dart';
import 'package:flutter_portfolio/core/utils/external_navigator.dart';
import 'package:flutter_portfolio/features/contact/contact_section.dart';
import 'package:flutter_portfolio/features/home/home_section.dart';

void main() {
  tearDown(ExternalNavigator.reset);

  testWidgets('renders identity and primary sections', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final profile = PortfolioData.profile;

    expect(find.text(profile.name), findsWidgets);
    expect(find.textContaining('Full-Stack Software Engineer'), findsWidgets);
    expect(find.text('View Projects'), findsOneWidget);
    expect(find.text('Contact Me'), findsOneWidget);
    expect(find.text('Mobile CV (PDF)'), findsOneWidget);
    expect(find.text('About'), findsWidgets);
    expect(find.text('Experience'), findsWidgets);
    expect(find.text('Projects'), findsWidgets);
    expect(find.text('Skills'), findsWidgets);
    expect(find.text('Contact'), findsWidgets);
  });

  testWidgets('renders accurate experience and project content', (tester) async {
    tester.view.physicalSize = const Size(1440, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('DevNas'), findsOneWidget);
    expect(find.text('Application Developer'), findsOneWidget);
    expect(find.text('Truckin Central'), findsWidgets);
    expect(find.text('VaxBuddy'), findsWidgets);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('LinkedIn (optional)'), findsOneWidget);
  });

  testWidgets('Download CV is enabled when public CV path is configured',
      (tester) async {
    final launched = <Uri>[];
    ExternalNavigator.launch = (uri, {bool preferDownload = false}) async {
      launched.add(uri);
      return true;
    };

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final cvButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Mobile CV (PDF)'),
    );
    expect(cvButton.onPressed, isNotNull);
    expect(PortfolioData.profile.hasCv, isTrue);

    await tester.tap(find.text('Mobile CV (PDF)'));
    await tester.pumpAndSettle();

    expect(launched, isNotEmpty);
    expect(launched.last.path, contains('Seif_Abuashour_CV.pdf'));
  });

  testWidgets('Download CV stays disabled without a CV path', (tester) async {
    const profile = PortfolioProfile(
      name: 'Seif Abuashour',
      title: 'Senior Flutter Developer',
      subtitle: 'Mobile Application Engineer',
      location: 'Amman, Jordan',
      email: 'saifaboashour98@gmail.com',
      aboutSummary: 'Summary',
      experiences: [],
      projects: [],
      skillCategories: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeSection(
            profile: profile,
            onViewProjects: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final cvButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Mobile CV (PDF)'),
    );
    expect(cvButton.onPressed, isNull);
  });

  testWidgets('Contact Me opens mailto for the profile email', (tester) async {
    final launched = <Uri>[];
    ExternalNavigator.launch = (uri, {bool preferDownload = false}) async {
      launched.add(uri);
      return true;
    };

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Contact Me'));
    await tester.pumpAndSettle();

    expect(launched, isNotEmpty);
    expect(launched.last.scheme, 'mailto');
    expect(launched.last.path, PortfolioData.profile.email);
  });

  testWidgets('Email Me and GitHub use expected destinations', (tester) async {
    final launched = <Uri>[];
    ExternalNavigator.launch = (uri, {bool preferDownload = false}) async {
      launched.add(uri);
      return true;
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ContactSection(profile: PortfolioData.profile),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Email Me'));
    await tester.pump();
    expect(launched.last.scheme, 'mailto');
    expect(launched.last.path, 'saifaboashour98@gmail.com');

    await tester.tap(find.text('GitHub'));
    await tester.pump();
    expect(
      launched.last.toString(),
      'https://github.com/saifaboashour',
    );

    await tester.tap(find.text('LinkedIn (optional)'));
    await tester.pump();
    expect(
      launched.last.toString(),
      'https://www.linkedin.com/in/seif-abuashour-4632aa163/',
    );
  });

  testWidgets('Copy email writes address to the clipboard', (tester) async {
    final clipboard = <String?>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          final args = call.arguments as Map<dynamic, dynamic>;
          clipboard.add(args['text'] as String?);
        }
        return null;
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ContactSection(profile: PortfolioData.profile),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Copy email'));
    await tester.pump();

    expect(clipboard, contains('saifaboashour98@gmail.com'));
    expect(find.text('Email copied to clipboard'), findsOneWidget);
  });

  testWidgets('View Projects scrolls to projects section', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('View Projects'));
    await tester.pumpAndSettle();

    expect(
      tester.state<PortfolioPageState>(find.byType(PortfolioPage)),
      isNotNull,
    );
    expect(
      find.text('Featured work with clear contribution scope.'),
      findsOneWidget,
    );
  });

  testWidgets('uses compact navigation below 768px width', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.byTooltip('Menu'), findsOneWidget);
    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
  });

  testWidgets('uses side navigation at desktop widths', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.byTooltip('Menu'), findsNothing);
    expect(find.byTooltip('Home'), findsOneWidget);
    expect(find.text(PortfolioData.profile.monogram), findsOneWidget);
  });
}
