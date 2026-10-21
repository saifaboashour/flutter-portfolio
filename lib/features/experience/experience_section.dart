import 'package:flutter/material.dart';

import '../../core/content/portfolio_models.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/empty_state_note.dart';
import '../../shared/widgets/section_header.dart';
import 'widgets/experience_timeline.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.experiences});

  final List<ExperienceItem> experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          indexLabel: '02.',
          title: 'Experience',
          subtitle: 'Roles and responsibilities, most recent first.',
        ),
        const SizedBox(height: AppSpacing.lg),
        if (experiences.isEmpty)
          const EmptyStateNote(
            message:
                'Employment history is not listed yet. This timeline is ready '
                'for roles, organizations, and periods once content is supplied.',
          )
        else
          ExperienceTimeline(items: experiences),
      ],
    );
  }
}
