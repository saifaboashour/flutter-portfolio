import 'package:flutter/material.dart';

import '../../core/content/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/external_navigator.dart';
import 'widgets/code_decorations.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.profile,
    required this.onViewProjects,
  });

  final PortfolioProfile profile;
  final VoidCallback onViewProjects;

  Future<void> _downloadCv(BuildContext context, String? path) async {
    if (path == null) return;

    final opened = await ExternalNavigator.openSiteRelative(
      path,
      preferDownload: true,
    );
    if (!context.mounted) return;
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open CV. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _emailMe(BuildContext context) async {
    final opened = await ExternalNavigator.openMailto(
      profile.email,
      subject: 'Project inquiry / technical partnership',
    );
    if (!context.mounted) return;
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open email client.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 768;
    final nameStyle = compact ? textTheme.displayMedium : textTheme.displayLarge;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: compact ? 420 : 520),
      child: Stack(
        children: [
          const Positioned.fill(child: FlutterGeometryBackdrop()),
          LayoutBuilder(
            builder: (context, constraints) {
              final sideBySide = constraints.maxWidth >= 760;
              final intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!sideBySide) ...[
                const Center(child: _ProfileAvatar(size: 112)),
                const SizedBox(height: AppSpacing.lg),
              ],
              const CodeDecorations(),
              const SizedBox(height: AppSpacing.xl),
              Text(
                "Hi, I'm",
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.emerald,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                profile.name,
                style: nameStyle?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text.rich(
                TextSpan(
                  style: (compact
                          ? textTheme.titleMedium
                          : textTheme.headlineMedium)
                      ?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                  children: [
                    TextSpan(
                      text: 'final ',
                      style: TextStyle(
                        color: AppColors.emerald.withValues(alpha: 0.9),
                      ),
                    ),
                    const TextSpan(
                      text: 'role',
                      style: TextStyle(color: AppColors.offWhite),
                    ),
                    const TextSpan(
                      text: ' = ',
                      style: TextStyle(color: AppColors.mutedText),
                    ),
                    TextSpan(
                      text: "'${profile.title}'",
                      style: const TextStyle(color: AppColors.emerald),
                    ),
                    const TextSpan(
                      text: ';',
                      style: TextStyle(color: AppColors.mutedText),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                profile.subtitle,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.mutedText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    profile.location,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Available for independent software development projects and technical partnerships.',
                style: textTheme.bodyLarge?.copyWith(color: AppColors.emerald),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text('Mobile apps, web platforms, backend systems, automation, and software maintenance.'),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  FilledButton.icon(
                    onPressed: () => _emailMe(context),
                    icon: const Icon(Icons.mail_outline, size: 20),
                    label: const Text('Discuss Your Project'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onViewProjects,
                    icon: const Icon(Icons.apps_outlined, size: 20),
                    label: const Text('View Projects'),
                  ),
                  PopupMenuButton<String>(
                    tooltip: 'Download a targeted CV',
                    enabled: profile.hasCv ||
                        profile.fullStackCvPublicPath != null ||
                        profile.cyberCvPublicPath != null,
                    onSelected: (path) => _downloadCv(context, path),
                    itemBuilder: (context) => [
                      if (profile.cvPublicPath != null)
                        PopupMenuItem(value: profile.cvPublicPath!, child: const Text('Mobile CV (PDF)')),
                      if (profile.fullStackCvPublicPath != null)
                        PopupMenuItem(value: profile.fullStackCvPublicPath!, child: const Text('Full-Stack CV (PDF)')),
                      if (profile.cyberCvPublicPath != null)
                        PopupMenuItem(value: profile.cyberCvPublicPath!, child: const Text('Cybersecurity CV (PDF)')),
                    ],
                    child: const Chip(
                      avatar: Icon(Icons.download_outlined, size: 20),
                      label: Text('Download CV'),
                    ),
                  ),
                ],
              ),

            ],
              );
              if (!sideBySide) return intro;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: intro),
                  const SizedBox(width: AppSpacing.xl),
                  const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.xl),
                    child: _ProfileAvatar(size: 200),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.emerald.withValues(alpha: 0.65)),
    ),
    child: ClipOval(
      child: Image.network(
        'https://avatars.githubusercontent.com/u/21100664?v=4',
        fit: BoxFit.cover,
        semanticLabel: 'Illustrated profile avatar',
        errorBuilder: (context, error, stackTrace) => const ColoredBox(
          color: AppColors.charcoal,
          child: Icon(Icons.person_outline, color: AppColors.emerald, size: 48),
        ),
      ),
    ),
  );
}
