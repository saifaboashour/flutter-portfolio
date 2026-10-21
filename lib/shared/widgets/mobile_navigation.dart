import 'package:flutter/material.dart';

import '../../core/constants/nav_items.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class MobileTopBar extends StatelessWidget {
  const MobileTopBar({
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
    return Material(
      color: AppColors.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Semantics(
                    label: 'Seif Abuashour monogram',
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.emerald),
                      ),
                      child: Text(
                        monogram,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.emerald,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      activeSection.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: 'Open navigation menu',
                    child: IconButton(
                      tooltip: 'Menu',
                      iconSize: 24,
                      constraints: const BoxConstraints(
                        minWidth: AppSpacing.touchTarget,
                        minHeight: AppSpacing.touchTarget,
                      ),
                      onPressed: () => _openMenu(context),
                      icon: const Icon(Icons.menu_rounded),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: PortfolioSection.values.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final section = PortfolioSection.values[index];
                  final selected = section == activeSection;
                  return FilterChip(
                    selected: selected,
                    showCheckmark: false,
                    label: Text(section.label),
                    avatar: Icon(
                      section.icon,
                      size: 16,
                      color: selected ? AppColors.charcoal : AppColors.mutedText,
                    ),
                    selectedColor: AppColors.emerald,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.charcoal : AppColors.offWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    onSelected: (_) => onSelect(section),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }

  Future<void> _openMenu(BuildContext context) async {
    final selected = await showModalBottomSheet<PortfolioSection>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.outline,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                for (final section in PortfolioSection.values)
                  ListTile(
                    leading: Icon(
                      section.icon,
                      color: section == activeSection
                          ? AppColors.emerald
                          : AppColors.mutedText,
                    ),
                    title: Text(
                      section.label,
                      style: TextStyle(
                        color: section == activeSection
                            ? AppColors.emerald
                            : AppColors.offWhite,
                        fontWeight: section == activeSection
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(section),
                    minVerticalPadding: 16,
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      onSelect(selected);
    }
  }
}
