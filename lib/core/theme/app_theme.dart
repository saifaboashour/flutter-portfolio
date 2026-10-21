import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Material 3 dark theme for the portfolio.
abstract final class AppTheme {
  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.emerald,
      onPrimary: AppColors.charcoal,
      secondary: AppColors.emerald,
      onSecondary: AppColors.charcoal,
      surface: AppColors.surface,
      onSurface: AppColors.offWhite,
      onSurfaceVariant: AppColors.mutedText,
      outline: AppColors.outline,
      error: const Color(0xFFCF6679),
      onError: AppColors.charcoal,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.charcoal,
      textTheme: AppTypography.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.charcoal,
        foregroundColor: AppColors.offWhite,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outline,
        thickness: 1,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.emerald,
          foregroundColor: AppColors.charcoal,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.offWhite,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          side: const BorderSide(color: AppColors.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.outline),
        ),
        textStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.offWhite,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.charcoal,
        selectedColor: AppColors.emerald.withValues(alpha: 0.2),
        labelStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.offWhite,
        ),
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
    );
  }
}
