import 'package:flutter/material.dart';

import '../../core/content/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.profile});

  final PortfolioProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          indexLabel: '01.',
          title: 'About',
          subtitle: 'Background, focus, and how I work.',
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.charcoal.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.aboutSummary,
                style: textTheme.bodyLarge?.copyWith(height: 1.65),
              ),
              const SizedBox(height: AppSpacing.lg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MetaChip(
                    icon: Icons.badge_outlined,
                    label: profile.headline,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _MetaChip(
                    icon: Icons.location_on_outlined,
                    label: profile.location,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.emerald),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.offWhite,
                ),
          ),
        ),
      ],
    );
  }
}
