import 'package:flutter/material.dart';

import '../../../core/content/portfolio_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/external_navigator.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final ProjectItem project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final textTheme = Theme.of(context).textTheme;
    final highlight = _hovered || _focused;

    return FocusableActionDetector(
      onShowHoverHighlight: (v) => setState(() => _hovered = v),
      onShowFocusHighlight: (v) => setState(() => _focused = v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, highlight ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.charcoal.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: highlight
                ? AppColors.emerald.withValues(alpha: 0.55)
                : AppColors.outline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(13),
                  ),
                  border: Border(
                    bottom: BorderSide(color: AppColors.outline),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(13),
                  ),
                  child: project.imageAsset != null
                      ? Image.asset(
                          project.imageAsset!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _BrandedProjectVisual(
                            title: project.title,
                          ),
                        )
                      : _BrandedProjectVisual(title: project.title),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(project.title, style: textTheme.titleLarge),
                      if (project.status != null)
                        Chip(label: Text(project.status!), visualDensity: VisualDensity.compact),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.category,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.emerald,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    project.description,
                    style: textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                  if (project.contribution != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Contribution',
                      style: textTheme.labelLarge?.copyWith(
                        color: AppColors.mutedText,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      project.contribution!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.offWhite,
                        height: 1.5,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final tech in project.technologies)
                        Chip(label: Text(tech)),
                    ],
                  ),
                  if (project.hasExternalLinks) ...[
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        if (project.liveUrl != null)
                          TextButton.icon(
                            onPressed: () => ExternalNavigator.openUri(Uri.parse(project.liveUrl!)),
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: const Text('Live'),
                          ),
                        if (project.appStoreUrl != null)
                          TextButton.icon(
                            onPressed: () => ExternalNavigator.openUri(Uri.parse(project.appStoreUrl!)),
                            icon: const Icon(Icons.apple, size: 18),
                            label: const Text('App Store'),
                          ),
                        if (project.playStoreUrl != null)
                          TextButton.icon(
                            onPressed: () => ExternalNavigator.openUri(Uri.parse(project.playStoreUrl!)),
                            icon: const Icon(Icons.shop_outlined, size: 18),
                            label: const Text('Google Play'),
                          ),
                        if (project.repoUrl != null)
                          TextButton.icon(
                            onPressed: () => ExternalNavigator.openUri(Uri.parse(project.repoUrl!)),
                            icon: const Icon(Icons.code, size: 18),
                            label: const Text('Code'),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Abstract branded visual — not a fake app screenshot.
class _BrandedProjectVisual extends StatelessWidget {
  const _BrandedProjectVisual({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BrandVisualPainter(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.emerald, width: 1.5),
                  color: AppColors.emerald.withValues(alpha: 0.08),
                ),
                child: Text(
                  _initials(title),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.emerald,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.offWhite,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _initials(String title) {
    final parts = title.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
    }
    return title.isNotEmpty ? title[0].toUpperCase() : 'P';
  }
}

class _BrandVisualPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = AppColors.surface;
    canvas.drawRect(Offset.zero & size, bg);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = AppColors.emerald.withValues(alpha: 0.2);

    final fill = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.emerald.withValues(alpha: 0.06);

    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.28),
      size.shortestSide * 0.28,
      fill,
    );
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.28),
      size.shortestSide * 0.28,
      stroke,
    );
    canvas.drawCircle(
      Offset(size.width * 0.18, size.height * 0.78),
      size.shortestSide * 0.2,
      stroke,
    );

    final path = Path()
      ..moveTo(size.width * 0.05, size.height * 0.35)
      ..lineTo(size.width * 0.35, size.height * 0.12)
      ..lineTo(size.width * 0.4, size.height * 0.55)
      ..close();
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
