import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// ThemeData definitions for the kiosk app.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.cardSurface,
        error: AppColors.error,
        onPrimary: AppColors.background,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.glassBorderSubtle, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.glassBorderSubtle,
        thickness: 1,
        space: 1,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.cardSurfaceLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.glassBorderSubtle),
        ),
        textStyle: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
      ),
    );
  }
}
