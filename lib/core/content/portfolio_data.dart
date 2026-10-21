import 'portfolio_models.dart';

/// Single source of truth for portfolio copy.
abstract final class PortfolioData {
  static const profile = PortfolioProfile(
    name: 'Seif Abuashour',
    title: 'Senior Flutter Developer',
    subtitle: 'Mobile Application Engineer',
    location: 'Amman, Jordan',
    email: 'saifaboashour98@gmail.com',
    githubUrl: 'https://github.com/saifaboashour',
    linkedInUrl: 'https://www.linkedin.com/in/seif-abuashour-4632aa163/',
    cvPublicPath: 'cv/Seif_Abuashour_CV.pdf',
    cvDownloadFileName: 'Seif_Abuashour_CV.pdf',
    aboutSummary:
        'Senior Flutter Developer and Mobile Application Engineer with '
        'experience building, maintaining, and delivering mobile applications '
        'across transportation, education, healthcare, and e-commerce.\n\n'
        'Experienced in taking ownership of application architecture, technical '
        'decisions, and the full development lifecycle — from implementation '
        'through release and ongoing maintenance. Comfortable leading technical '
        'work, mentoring developers, and collaborating across teams.\n\n'
        'Focused on building maintainable applications using Clean Architecture '
        'principles, automated testing, and clear documentation.',
    experiences: [
      ExperienceItem(
        organization: 'DevNas',
        role: 'Application Developer',
        period: 'Sep 2025 – Oct 2026',
        highlights: [
          'Developed and maintained Flutter applications in the education sector.',
          'Owned architecture decisions, API integration, feature delivery, and release activities.',
          'Mentored developers and participated in code reviews.',
          'Continued as primary responsible mobile developer for Truckin Central through a company partnership.',
        ],
      ),
      ExperienceItem(
        organization: 'Truckin Central',
        role: 'Flutter Developer',
        period: 'Mar 2022 – Sep 2025',
        highlights: [
          'Developed and maintained Flutter applications supporting transportation and trucking operations.',
          'Worked on mobile architecture, state management, API integrations, and production releases.',
          'Contributed to integration of TollGuru routing/toll data with fuel-price inputs for trip-cost estimation.',
          'Supported mentoring and technical collaboration.',
        ],
      ),
      ExperienceItem(
        organization: 'Emperor Soft',
        role: 'Team Leader',
        period: '2020 – 2021',
        highlights: [
          'Led and mentored developers, coordinated technical delivery, reviewed code, and contributed implementation work when needed.',
        ],
      ),
      ExperienceItem(
        organization: 'Fz3a',
        role: 'Mobile Developer',
        period: '2019 – 2020',
        highlights: [
          'Developed mobile applications across multiple sectors using Flutter and native technologies.',
        ],
      ),
      ExperienceItem(
        organization: 'Freelance',
        role: 'Software & Mobile Developer',
        period: '2015 – Present · intermittent, alongside employment',
        highlights: [
          'Delivered independent software and mobile development projects across multiple sectors.',
          'Owned implementation, integrations, delivery, and ongoing maintenance where applicable.',
        ],
      ),
    ],
    projects: [
      ProjectItem(
        title: 'Truckin Central',
        category: 'Professional / team project · Transportation',
        description:
            'Flutter applications supporting transportation operations and '
            'trucking workflows.',
        contribution:
            'Mobile architecture, features, REST API integrations, '
            'maintenance, release work, and contribution to trip-cost '
            'estimation integrating TollGuru toll data and fuel pricing.',
        technologies: [
          'Flutter',
          'Dart',
          'REST APIs',
          'State management',
        ],
      ),
      ProjectItem(
        title: 'VaxBuddy',
        category: 'Independent freelance project · Healthcare',
        description:
            'Mobile application for tracking vaccinations and managing '
            'reminders.',
        contribution:
            'Flutter app, backend, deployment, publishing, and ongoing '
            'maintenance. Implemented timezone-aware reminders and cron-based '
            'scheduling.',
        technologies: [
          'Flutter',
          'Dart',
          'Backend APIs',
          'Scheduled tasks',
        ],
      ),
    ],
    skillCategories: [
      SkillCategory(
        title: 'Mobile',
        skills: ['Flutter', 'Dart', 'Swift', 'Kotlin'],
      ),
      SkillCategory(
        title: 'State management',
        skills: ['BLoC', 'Provider', 'Riverpod', 'GetX'],
      ),
      SkillCategory(
        title: 'Architecture',
        skills: [
          'Clean Architecture',
          'Maintainable code',
          'Reusable components',
        ],
      ),
      SkillCategory(
        title: 'Integrations',
        skills: [
          'REST APIs',
          'Firebase',
          'Push notifications',
          'Maps / geolocation',
          'Payments & in-app purchases',
        ],
      ),
      SkillCategory(
        title: 'Delivery',
        skills: ['Git', 'CI/CD', 'App Store', 'Google Play'],
      ),
      SkillCategory(
        title: 'Quality',
        skills: [
          'Unit tests',
          'Widget tests',
          'Integration / E2E tests',
          'Mocks',
          'Code reviews',
          'Documentation',
        ],
      ),
      SkillCategory(
        title: 'Leadership',
        skills: [
          'Mentoring',
          'Technical ownership',
          'Team collaboration',
        ],
      ),
    ],
  );
}
