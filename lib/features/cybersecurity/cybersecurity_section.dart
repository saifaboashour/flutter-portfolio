import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';
import '../../core/utils/external_navigator.dart';

/// Independent cybersecurity practice; not a representation of SOC employment.
class CybersecuritySection extends StatelessWidget {
  const CybersecuritySection({super.key});

  static const _caseStudies = <_SecurityCaseStudy>[
    _SecurityCaseStudy(
      title: 'GetIntel — Threat Intelligence Pipeline',
      subtitle: 'Independent CTI research · Active lab',
      icon: Icons.travel_explore_outlined,
      description:
          'Built a multi-source intelligence collection pipeline for regional security reporting. Normalizes leads for manual validation, triage, and further research.',
      capabilities: ['OSINT', 'Source validation', 'Threat monitoring', 'Lead triage'],
    ),
    _SecurityCaseStudy(
      title: 'CTI Automation Lab',
      subtitle: 'Security automation · Active lab',
      icon: Icons.hub_outlined,
      description:
          'Built local n8n, PostgreSQL, and Docker workflows for advisory collection, CVE relationships, enrichment, and reproducible security analysis.',
      capabilities: ['n8n', 'PostgreSQL', 'Docker', 'CVE enrichment'],
    ),
    _SecurityCaseStudy(
      title: 'MISP Threat Intelligence',
      subtitle: 'Self-hosted research environment',
      icon: Icons.shield_outlined,
      description:
          'Deployed and operated MISP in Docker to structure intelligence events and indicators, while distinguishing reported claims from verified evidence.',
      capabilities: ['MISP', 'IOC management', 'Docker', 'Evidence handling'],
    ),
    _SecurityCaseStudy(
      title: 'OSINT & Security Testing',
      subtitle: 'Independent practice and authorized assessments',
      icon: Icons.manage_search_outlined,
      description:
          'Applied OSINT methods, reverse-engineering and CTF experience, and scoped black-box web testing principles on authorized systems.',
      capabilities: ['OSINT', 'Reverse engineering', 'CTF', 'Web security'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          indexLabel: '04.',
          title: 'Cybersecurity & Threat Intelligence',
          subtitle: 'Independent CTI research, technical investigations, and security automation.',
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'My independent research focuses on cyber threats in Jordan, the Gulf, '
          'and the wider Middle East, including adversary infrastructure, OSINT, '
          'indicator validation, and intelligence automation. I distinguish '
          'observed evidence from reported claims and analytical judgments.',
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.mutedText,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.charcoal.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.article_outlined, color: AppColors.emerald, size: 30),
              const SizedBox(height: AppSpacing.md),
              Text('Research Publications', style: textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'My public CTI research repository contains the publication index '
                'and research methodology. Markdown investigations are added as '
                'they are completed and reviewed.',
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: () async {
                  final opened = await ExternalNavigator.openUri(
                    Uri.parse('https://github.com/saifaboashour/cti-research'),
                  );
                  if (!context.mounted || opened) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to open research repository.')),
                  );
                },
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('View Research Publications'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Research Projects & Labs', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        const Text('Independent projects and hands-on lab practice.'),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth >= 720
                ? (constraints.maxWidth - AppSpacing.lg) / 2
                : constraints.maxWidth;
            return Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.lg,
              children: [
                for (final study in _caseStudies)
                  SizedBox(width: width, child: _SecurityCard(study: study)),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SecurityCaseStudy {
  const _SecurityCaseStudy({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.description,
    required this.capabilities,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final String description;
  final List<String> capabilities;
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard({required this.study});
  final _SecurityCaseStudy study;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: AppColors.charcoal.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.outline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(study.icon, color: AppColors.emerald, size: 30),
        const SizedBox(height: AppSpacing.md),
        Text(study.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(study.subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.emerald)),
        const SizedBox(height: AppSpacing.md),
        Text(study.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [for (final skill in study.capabilities) Chip(label: Text(skill))],
        ),
      ],
    ),
  );
}
