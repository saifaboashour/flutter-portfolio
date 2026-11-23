import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_portfolio/core/content/portfolio_data.dart';

void main() {
  final profile = PortfolioData.profile;

  test('identity and contact targets match verified values', () {
    expect(profile.name, 'Seif Abuashour');
    expect(profile.email, 'saifaboashour98@gmail.com');
    expect(profile.location, 'Amman, Jordan');
    expect(profile.githubUrl, 'https://github.com/saifaboashour');
    expect(
      profile.linkedInUrl,
      'https://www.linkedin.com/in/seif-abuashour-4632aa163/',
    );
    expect(profile.cvPublicPath, 'cv/Seif_Abuashour_CV.pdf');
  });

  test('experience timeline matches verified roles and dates', () {
    final byOrg = {
      for (final item in profile.experiences) item.organization: item,
    };

    expect(byOrg['DevNas']!.role, 'Application Developer');
    expect(byOrg['DevNas']!.period, 'Sep 2025 – Oct 2026');

    expect(byOrg['Truckin Central']!.role, 'Flutter Developer');
    expect(byOrg['Truckin Central']!.period, 'Mar 2022 – Sep 2025');

    expect(byOrg['Emperor Soft']!.role, 'Team Leader');
    expect(byOrg['Emperor Soft']!.period, '2020 – 2021');

    expect(byOrg['Fz3a']!.role, 'Mobile Developer');
    expect(byOrg['Fz3a']!.period, '2019 – 2020');

    expect(byOrg['Freelance']!.role, 'Full-Stack & Mobile Software Developer');
    expect(byOrg['Freelance']!.period, contains('2015 – Present'));
    expect(byOrg['Freelance']!.period.toLowerCase(), contains('intermittent'));
  });

  test('projects avoid fake links and overclaim-free contribution wording', () {
    final titles = profile.projects.map((p) => p.title).toList();
    expect(titles, containsAll(['Truckin Central', 'VaxBuddy']));

    for (final project in profile.projects) {
      expect(project.imageAsset, isNull);
      if (project.repoUrl != null) {
        expect(project.repoUrl, startsWith('https://github.com/saifaboashour/'));
      }
    }

    expect(titles, containsAll(['Mofeed', 'TimmiBook', 'Mate', 'Wolf CEO', 'Taz']));

    final truckin =
        profile.projects.firstWhere((p) => p.title == 'Truckin Central');
    expect(truckin.contribution!.toLowerCase(), contains('contribution'));
    expect(truckin.category.toLowerCase(), contains('team'));

    final vax = profile.projects.firstWhere((p) => p.title == 'VaxBuddy');
    expect(vax.category.toLowerCase(), contains('freelance'));
  });

  test('site copy does not expose phone number', () {
    final blob = [
      profile.aboutSummary,
      ...profile.experiences.expand((e) => [e.role, e.period, ...e.highlights]),
      ...profile.projects.expand(
        (p) => [p.title, p.description, p.contribution ?? ''],
      ),
    ].join(' ');

    expect(blob.contains('9082'), isFalse);
    expect(blob.contains('9777'), isFalse);
  });
}
