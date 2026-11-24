import 'portfolio_models.dart';

/// Single source of truth for public portfolio content.
abstract final class PortfolioData {
  static const profile = PortfolioProfile(
    name: 'Seif Abuashour',
    title: 'Full-Stack Software Engineer',
    subtitle: 'Flutter & Full-Stack Engineering · Cybersecurity & CTI',
    location: 'Amman, Jordan',
    email: 'saifaboashour98@gmail.com',
    githubUrl: 'https://github.com/saifaboashour',
    linkedInUrl: 'https://www.linkedin.com/in/seif-abuashour-4632aa163/',
    // The existing downloadable PDF is the mobile-focused resume.
    cvPublicPath: 'cv/Seif_Abuashour_CV.pdf',
    cvDownloadFileName: 'Seif_Abuashour_CV.pdf',
    aboutSummary:
        'Full-Stack Software Engineer with 6+ years of broader software '
        'development experience, specializing in Flutter while also building '
        'web applications, backend services, and complete products. I work '
        'with Node.js, NestJS, React, Next.js, TypeScript, and databases '
        'including PostgreSQL, MySQL, MongoDB, and Supabase.\n\n'
        'My projects span healthcare, transportation, booking, education, '
        'and business tools. Alongside engineering, I build independent ' 
        'threat intelligence pipelines, OSINT investigations, and security ' 
        'automation labs. As a freelancer and independent developer, '
        'I have owned architecture, frontend and backend implementation, '
        'API integrations, deployment, and ongoing maintenance. In employed '
        'roles I have delivered production mobile apps and collaborated '
        'with backend teams to diagnose and resolve issues.\n\n'
        'My cybersecurity portfolio reflects hands-on projects and research, ' 
        'not claimed SOC employment. I value maintainable architecture, practical testing, clear '
        'communication, and delivering software end to end.',
    experiences: [
      ExperienceItem(
        organization: 'DevNas',
        role: 'Application Developer',
        period: 'Sep 2025 – Oct 2026',
        highlights: [
          'Developed and maintained Flutter applications in the education sector.',
          'Owned mobile architecture decisions, API integration, feature delivery, and releases.',
          'Collaborated with backend engineers on integration issues and production debugging.',
          'Mentored developers and participated in code reviews.',
          'Continued as primary responsible mobile developer for Truckin Central through a company partnership.',
        ],
      ),
      ExperienceItem(
        organization: 'Truckin Central',
        role: 'Flutter Developer',
        period: 'Mar 2022 – Sep 2025',
        highlights: [
          'Built and maintained transportation-focused mobile applications using Flutter.',
          'Implemented application features, state management, API integrations, and release workflows.',
          'Contributed to TollGuru routing/toll data integration with fuel-price inputs for trip-cost estimates.',
          'Worked with backend colleagues to troubleshoot APIs and production issues.',
        ],
      ),
      ExperienceItem(
        organization: 'Emperor Soft',
        role: 'Team Leader',
        period: '2020 – 2021',
        highlights: [
          'Led and mentored developers, coordinated technical delivery, reviewed code, and contributed to implementation.',
        ],
      ),
      ExperienceItem(
        organization: 'Fz3a',
        role: 'Mobile Developer',
        period: '2019 – 2020',
        highlights: [
          'Developed mobile applications using Flutter and native mobile technologies.',
        ],
      ),
      ExperienceItem(
        organization: 'Freelance',
        role: 'Full-Stack & Mobile Software Developer',
        period: '2015 – Present · intermittent, alongside employment',
        highlights: [
          'Built web, backend, and mobile software for independent and client projects.',
          'Worked with Node.js, NestJS, PHP/Laravel, relational and NoSQL databases, and Flutter.',
          'Handled technical planning, integrations, deployment, troubleshooting, and maintenance when required.',
        ],
      ),
    ],
    projects: [
      ProjectItem(
        title: 'Mofeed',
        category: 'Full-Stack + Mobile · Client project',
        description:
            'Research participation platform for discovering studies, answering questionnaires, and supporting researcher workflows.',
        contribution:
            'Responsible for all technical implementation: frontend, NestJS backend, mobile applications, integrations, and deployment. Work remains under development and client review.',
        technologies: ['NestJS', 'Web frontend', 'Flutter', 'REST APIs', 'Deployment'],
        status: 'In development',
      ),
      ProjectItem(
        title: 'TimmiBook',
        category: 'Full-Stack Web · Independent product',
        description:
            'Appointment scheduling and booking platform for service providers and customers.',
        contribution:
            'Owner and sole developer. Built the application across product planning, frontend, backend integration, and testing. The repository includes Next.js, React, TypeScript, Supabase, Vitest, and Playwright.',
        technologies: ['Next.js', 'React', 'TypeScript', 'Supabase', 'Playwright'],
        imageAsset: 'assets/projects/timmibook.png',
      ),
      ProjectItem(
        title: 'VaxBuddy',
        category: 'Full-Stack + Mobile · Freelance healthcare project',
        description:
            'Healthcare application supporting vaccination tracking and reminders.',
        contribution:
            'Worked on the mobile application, web frontend, and Node.js backend, including API integrations, reminder scheduling, deployment, and maintenance.',
        technologies: ['Flutter', 'Node.js', 'Web frontend', 'REST APIs', 'Scheduled jobs'],
        status: 'Published',
        liveUrl: 'https://vaxbuddy.com/',
        appStoreUrl: 'https://apps.apple.com/jo/app/vaxbuddy/id6758889655',
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.elm4g0.vaxbuddy',
      ),
      ProjectItem(
        title: 'Mate',
        category: 'Backend + Mobile · Independent product',
        description:
            'Ride-sharing and carpooling product developed through multiple versions.',
        contribution:
            'Owned the product and extensively modified an existing CodeCanyon-based first version using Laravel and Firebase. Later developed a separate Node.js/Express backend using MySQL and Socket.IO; source remains private.',
        technologies: ['Laravel', 'Firebase', 'Node.js', 'Express', 'MySQL', 'Socket.IO'],
        imageAsset: 'assets/projects/mate.png',
      ),
      ProjectItem(
        title: 'Truckin Central',
        category: 'Mobile · Professional team project',
        description:
            'Production Flutter applications supporting transportation and trucking operations.',
        contribution:
            'Delivered mobile architecture, features, API integrations, release work, and contribution to TollGuru-based trip cost estimation in collaboration with the team.',
        technologies: ['Flutter', 'Dart', 'REST APIs', 'State management'],
      ),
      ProjectItem(
        title: 'Sprigg',
        category: 'Native iOS · Independent finance product',
        description:
            'iOS personal finance app for tracking expenses, budgets, savings goals, and subscriptions.',
        contribution:
            'Developed native SwiftUI and SwiftData personal-finance workflows and budget dashboards, with original mascot assets and local-first design.',
        technologies: ['Swift', 'SwiftUI', 'SwiftData', 'iOS', 'Personal finance'],
        imageAsset: 'assets/projects/sprigg.png',
        status: 'In development',
      ),
      ProjectItem(
        title: 'Wolf CEO',
        category: 'Native iOS · Independent product',
        description:
            'iOS app for solo freelancers to manage clients, projects, tasks, scheduling, and income.',
        contribution:
            'Designed and developed the native iOS MVP using SwiftUI and SwiftData, with optional iCloud synchronization considered in the architecture.',
        technologies: ['Swift', 'SwiftUI', 'SwiftData', 'iOS'],
        status: 'TestFlight',
      ),
      ProjectItem(
        title: 'Taz',
        category: 'Mobile · Open-source personal project',
        description:
            'Local-first task and habit tracker for iOS and Android, with a dark-first design.',
        contribution:
            'Implemented Flutter application screens and reusable components with a focus on simple daily workflows.',
        technologies: ['Flutter', 'Dart', 'iOS', 'Android'],
        status: 'In development',
        repoUrl: 'https://github.com/saifaboashour/taz',
      ),
      ProjectItem(
        title: 'Flutter Portfolio',
        category: 'Web · Open-source personal project',
        description:
            'Responsive portfolio built using Flutter Web and deployed on GitHub Pages.',
        contribution:
            'Implemented responsive layout, structured content, automated tests, and GitHub Actions deployment.',
        technologies: ['Flutter Web', 'Dart', 'GitHub Actions', 'Testing'],
        liveUrl: 'https://saifaboashour.github.io/flutter-portfolio/',
        repoUrl: 'https://github.com/saifaboashour/flutter-portfolio',
      ),
    ],
    skillCategories: [
      SkillCategory(
        title: 'Backend & APIs',
        skills: ['Node.js', 'NestJS', 'Express', 'PHP', 'Laravel', 'REST APIs'],
      ),
      SkillCategory(
        title: 'Web frontend',
        skills: ['React', 'Next.js', 'TypeScript', 'JavaScript', 'HTML', 'CSS', 'Tailwind CSS', 'Bootstrap', 'Flutter Web'],
      ),
      SkillCategory(
        title: 'Mobile',
        skills: ['Flutter', 'Dart', 'Swift', 'SwiftUI', 'Kotlin', 'Firebase'],
      ),
      SkillCategory(
        title: 'Databases & platforms',
        skills: ['PostgreSQL', 'MySQL', 'MongoDB', 'Firestore', 'SQLite', 'Supabase'],
      ),
      SkillCategory(
        title: 'Infrastructure & delivery',
        skills: ['Docker', 'Docker Compose', 'Linux / VPS', 'Nginx', 'Apache', 'PM2', 'Git', 'CI/CD', 'Azure DevOps', 'GitHub Actions', 'AWS'],
      ),
      SkillCategory(
        title: 'Architecture & quality',
        skills: ['Clean Architecture', 'State management', 'Unit testing', 'Widget testing', 'Integration / E2E testing', 'Code review', 'Debugging', 'Documentation'],
      ),
      SkillCategory(
        title: 'Cybersecurity & CTI practice',
        skills: ['Cyber Threat Intelligence', 'OSINT', 'MISP', 'n8n automation', 'IOC enrichment', 'Docker labs', 'Reverse engineering', 'Security testing'],
      ),
      SkillCategory(
        title: 'Mobile integrations',
        skills: ['Push notifications', 'Maps / geolocation', 'Payment integrations', 'App Store', 'Google Play'],
      ),
      SkillCategory(
        title: 'Collaboration & leadership',
        skills: ['Technical ownership', 'Mentoring', 'Cross-functional teamwork', 'Product delivery'],
      ),
    ],
  );
}
