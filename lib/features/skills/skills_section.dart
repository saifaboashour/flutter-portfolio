import 'package:flutter/material.dart';

import '../../core/content/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.categories});

  final List<SkillCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          indexLabel: '05.',
          title: 'Skills',
          subtitle: 'Tools and practices used across delivery work.',
        ),
        const SizedBox(height: AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 720;
            return Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.lg,
              children: [
                for (final category in categories)
                  SizedBox(
                    width: wide
                        ? (constraints.maxWidth - AppSpacing.lg) / 2
                        : constraints.maxWidth,
                    child: _SkillCategoryCard(category: category),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            category.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.emerald,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final skill in category.skills)
                Chip(
                  avatar: const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: AppColors.emerald,
                  ),
                  label: Text(skill),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
