import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/content/portfolio_models.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/external_navigator.dart';
import '../../shared/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.profile});

  final PortfolioProfile profile;

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: profile.email));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email copied to clipboard'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _emailMe(BuildContext context) async {
    final opened = await ExternalNavigator.openMailto(
      profile.email,
      subject: 'Software engineering opportunity',
    );
    if (!context.mounted) return;
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not open mail app. Email: ${profile.email}',
          ),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Copy',
            onPressed: () => _copyEmail(context),
          ),
        ),
      );
    }
  }

  Future<void> _openExternal(
    BuildContext context,
    String url, {
    required String failureMessage,
  }) async {
    final opened = await ExternalNavigator.openUri(Uri.parse(url));
    if (!context.mounted) return;
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(failureMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          indexLabel: '05.',
          title: 'Contact',
          subtitle: 'Open to full-stack, backend, and mobile opportunities.',
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface,
                AppColors.emerald.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's build something solid.",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Reach out for full-stack, backend, or mobile engineering opportunities. '
                'You can also explore selected work through GitHub.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              SelectableText(
                profile.email,
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.emerald,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  Semantics(
                    button: true,
                    label: 'Email me at ${profile.email}',
                    child: FilledButton.icon(
                      onPressed: () => _emailMe(context),
                      icon: const Icon(Icons.mail_outline, size: 20),
                      label: const Text('Email Me'),
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: 'Copy email address',
                    child: OutlinedButton.icon(
                      onPressed: () => _copyEmail(context),
                      icon: const Icon(Icons.copy_outlined, size: 20),
                      label: const Text('Copy email'),
                    ),
                  ),
                  if (profile.githubUrl != null)
                    Semantics(
                      button: true,
                      label: 'Open GitHub profile',
                      link: true,
                      child: OutlinedButton.icon(
                        onPressed: () => _openExternal(
                          context,
                          profile.githubUrl!,
                          failureMessage: 'Unable to open GitHub.',
                        ),
                        icon: const Icon(Icons.code, size: 20),
                        label: const Text('GitHub'),
                      ),
                    ),
                ],
              ),
              if (profile.linkedInUrl != null) ...[
                const SizedBox(height: AppSpacing.md),
                TextButton(
                  onPressed: () => _openExternal(
                    context,
                    profile.linkedInUrl!,
                    failureMessage: 'Unable to open LinkedIn.',
                  ),
                  child: Text(
                    'LinkedIn (optional)',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.mutedText,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.outline,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Text(
                '${profile.name} · ${profile.location}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
