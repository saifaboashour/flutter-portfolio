import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

/// Anchored section wrapper used for scroll navigation.
class SectionBlock extends StatelessWidget {
  const SectionBlock({
    super.key,
    required this.sectionKey,
    required this.child,
    this.padding,
  });

  final Key sectionKey;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final vertical = width < 768 ? AppSpacing.xxl : AppSpacing.section;
    final horizontal = width < 768 ? AppSpacing.lg : AppSpacing.xl;

    return KeyedSubtree(
      key: sectionKey,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical / 2,
            ),
        child: child,
      ),
    );
  }
}
