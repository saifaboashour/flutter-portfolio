// Content models kept separate from presentation widgets.

class ExperienceItem {
  const ExperienceItem({
    required this.role,
    required this.organization,
    required this.period,
    this.highlights = const [],
    this.location,
  });

  final String role;
  final String organization;
  final String period;
  final List<String> highlights;
  final String? location;
}

class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.category,
    required this.description,
    required this.technologies,
    this.contribution,
    this.imageAsset,
    this.status,
    this.appStoreUrl,
    this.playStoreUrl,
    this.liveUrl,
    this.repoUrl,
  });

  final String title;
  final String category;
  final String description;
  final String? contribution;
  final List<String> technologies;
  final String? imageAsset;
  final String? status;
  final String? appStoreUrl;
  final String? playStoreUrl;

  /// Only set when a verified public URL is available.
  final String? liveUrl;

  /// Only set when a verified public repository URL is available.
  final String? repoUrl;

  bool get hasExternalLinks =>
      liveUrl != null || repoUrl != null || appStoreUrl != null || playStoreUrl != null;
}

class SkillCategory {
  const SkillCategory({
    required this.title,
    required this.skills,
  });

  final String title;
  final List<String> skills;
}

class PortfolioProfile {
  const PortfolioProfile({
    required this.name,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.email,
    required this.aboutSummary,
    required this.experiences,
    required this.projects,
    required this.skillCategories,
    this.githubUrl,
    this.linkedInUrl,
    this.cvPublicPath,
    this.cvDownloadFileName,
  });

  final String name;
  final String title;
  final String subtitle;
  final String location;
  final String email;
  final String aboutSummary;
  final List<ExperienceItem> experiences;
  final List<ProjectItem> projects;
  final List<SkillCategory> skillCategories;

  /// Public GitHub profile URL (optional supporting evidence).
  final String? githubUrl;

  /// Optional / secondary — may not match this portfolio's Flutter focus.
  final String? linkedInUrl;

  /// Site-relative CV path served from `web/` (e.g. `cv/Seif_Abuashour_CV.pdf`).
  /// When null, Download CV stays disabled.
  final String? cvPublicPath;

  /// Suggested download filename for the CV.
  final String? cvDownloadFileName;

  bool get hasCv => cvPublicPath != null && cvPublicPath!.isNotEmpty;

  String get headline => '$title | $subtitle';

  Uri get mailtoUri => Uri(scheme: 'mailto', path: email);

  String get monogram {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'SA';
  }
}
