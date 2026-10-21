import 'package:flutter/material.dart';

enum PortfolioSection {
  home,
  about,
  experience,
  projects,
  skills,
  contact,
}

extension PortfolioSectionX on PortfolioSection {
  String get label => switch (this) {
        PortfolioSection.home => 'Home',
        PortfolioSection.about => 'About',
        PortfolioSection.experience => 'Experience',
        PortfolioSection.projects => 'Projects',
        PortfolioSection.skills => 'Skills',
        PortfolioSection.contact => 'Contact',
      };

  IconData get icon => switch (this) {
        PortfolioSection.home => Icons.home_outlined,
        PortfolioSection.about => Icons.person_outline,
        PortfolioSection.experience => Icons.work_outline,
        PortfolioSection.projects => Icons.apps_outlined,
        PortfolioSection.skills => Icons.bolt_outlined,
        PortfolioSection.contact => Icons.mail_outline,
      };

  String get scrollId => name;
}
