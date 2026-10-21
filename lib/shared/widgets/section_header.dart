import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.indexLabel,
    required this.title,
    this.subtitle,
  });

  final String indexLabel;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              indexLabel,
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.emerald,
                fontFamily: 'monospace',
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(title, style: textTheme.headlineLarge),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(subtitle!, style: textTheme.bodyMedium),
        ],
      ],
    );
  }
}
