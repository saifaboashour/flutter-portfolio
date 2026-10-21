import 'package:flutter/material.dart';

import '../../core/content/portfolio_models.dart';
import '../../core/theme/app_spacing.dart';
import '../../shared/widgets/section_header.dart';
import 'widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.projects});

  final List<ProjectItem> projects;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 1024
        ? 2
        : width >= 600
            ? 2
            : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          indexLabel: '03.',
          title: 'Projects',
          subtitle: 'Featured work with clear contribution scope.',
        ),
        const SizedBox(height: AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final spacing = AppSpacing.lg;
            final itemWidth = crossAxisCount == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - spacing) / 2;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final project in projects)
                  SizedBox(
                    width: itemWidth,
                    child: ProjectCard(project: project),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
