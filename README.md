# Seif Abuashour — Software Engineering Portfolio

Personal Flutter Web portfolio for **Seif Abuashour**, Full-Stack Software Engineer and Mobile Application Developer.

**Live site:** [https://saifaboashour.github.io/flutter-portfolio/](https://saifaboashour.github.io/flutter-portfolio/)

**CV:** [Download PDF](https://saifaboashour.github.io/flutter-portfolio/cv/Seif_Abuashour_CV.pdf)

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) SDK (stable channel recommended)
- Chrome (or another browser) for local web runs

Verified with Flutter **3.47.7** / Dart **3.13.5**.

## Setup

```bash
flutter pub get
```

## Run (Chrome)

```bash
flutter run -d chrome
```

## Analyze

```bash
flutter analyze
```

## Test

```bash
flutter test
```

## Project structure

```
lib/
  app/                 # MaterialApp + responsive PortfolioPage shell
  core/
    theme/             # Colors, typography, spacing, ThemeData
    content/           # Profile models + portfolio copy
    constants/         # Breakpoints + nav sections
    utils/             # External link / CV / mailto helpers
  features/
    home/              # Hero
    about/             # Summary
    experience/        # Timeline
    projects/          # Featured projects
    skills/            # Categorized chips
    contact/           # Email, GitHub, optional LinkedIn
  shared/widgets/      # Side/mobile nav, section chrome
  main.dart
web/
  cv/Seif_Abuashour_CV.pdf   # Static CV for Download CV / GitHub Pages
```

Responsive behavior: side rail at ≥768px; compact top bar + chip/menu nav below that.

## Build for web

```bash
flutter build web --release
```

For GitHub Pages under `/flutter-portfolio/`:

```bash
flutter build web --release --base-href /flutter-portfolio/
```

Output lands in `build/web/`. The CV is served at:

`/flutter-portfolio/cv/Seif_Abuashour_CV.pdf`

## Deployment (GitHub Pages)

This repository deploys automatically via GitHub Actions (`.github/workflows/deploy.yml`) on every push to `main`.

1. Repository **Settings → Pages → Build and deployment → Source:** **GitHub Actions**
2. Push to `main` (or run the **Deploy to GitHub Pages** workflow manually)
3. Site URL: https://saifaboashour.github.io/flutter-portfolio/

The workflow runs `flutter analyze`, `flutter test`, then builds with `--base-href /flutter-portfolio/` and deploys with `actions/deploy-pages`.

## License

Private / personal portfolio — all rights reserved unless otherwise noted.

## Selected work

The portfolio showcases full-stack and mobile projects including **Mofeed, VaxBuddy, TimmiBook, Mate, Truckin Central, Sprigg, Wolf CEO, Taz, and this portfolio**. Private client and personal codebases remain private; the site focuses on individual contributions and high-level technologies.

**Note:** The current CV download is the mobile-focused PDF. A separate full-stack resume can be added after review.
