import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/nav_items.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({
    super.key,
    required this.monogram,
    required this.activeSection,
    required this.onSelect,
  });

  final String monogram;
  final PortfolioSection activeSection;
  final ValueChanged<PortfolioSection> onSelect;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Primary navigation',
      child: Container(
        width: AppSpacing.sideNavWidth,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Column(
          children: [
            _Monogram(monogram: monogram),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final section in PortfolioSection.values)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xs,
                      ),
                      child: _NavIconButton(
                        section: section,
                        selected: section == activeSection,
                        onPressed: () => onSelect(section),
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.mutedText.withValues(alpha: 0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  const _Monogram({required this.monogram});

  final String monogram;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Seif Abuashour monogram',
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.emerald, width: 1.5),
        ),
        child: Text(
          monogram,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.emerald,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
        ),
      ),
    );
  }
}

class _NavIconButton extends StatefulWidget {
  const _NavIconButton({
    required this.section,
    required this.selected,
    required this.onPressed,
  });

  final PortfolioSection section;
  final bool selected;
  final VoidCallback onPressed;

  @override
  State<_NavIconButton> createState() => _NavIconButtonState();
}

class _NavIconButtonState extends State<_NavIconButton> {
  bool _focused = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlight = widget.selected || _hovered || _focused;
    final color = widget.selected
        ? AppColors.emerald
        : highlight
            ? AppColors.offWhite
            : AppColors.mutedText;

    return Tooltip(
      message: widget.section.label,
      preferBelow: false,
      child: FocusableActionDetector(
        onShowFocusHighlight: (value) => setState(() => _focused = value),
        onShowHoverHighlight: (value) => setState(() => _hovered = value),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onPressed();
              return null;
            },
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            hoverColor: AppColors.emerald.withValues(alpha: 0.08),
            focusColor: AppColors.emerald.withValues(alpha: 0.12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: AppSpacing.touchTarget,
              height: AppSpacing.touchTarget,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: widget.selected
                    ? AppColors.emerald.withValues(alpha: 0.12)
                    : Colors.transparent,
                border: Border.all(
                  color: widget.selected
                      ? AppColors.emerald.withValues(alpha: 0.45)
                      : Colors.transparent,
                ),
              ),
              child: Icon(widget.section.icon, color: color, size: 22),
            ),
          ),
        ),
      ),
    );
  }
}
