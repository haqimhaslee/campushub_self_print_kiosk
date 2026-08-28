import 'package:material_ui/material_ui.dart';

/// Centralized color palette for the Campus Hub Kiosk UI.
/// Tailored for high-contrast, futuristic desktop kiosk visibility.
class AppColors {
  AppColors._();

  // Background Gradients & Surfaces
  static const Color background = Color(0xFF0A0E17);
  static const Color backgroundSecondary = Color(0xFF0F172A);
  static const Color cardSurface = Color(0xFF131D31);
  static const Color cardSurfaceLight = Color(0xFF1E293B);
  static const Color glassSurface = Color(0x661E293B);
  static const Color glassBorder = Color(0x3338BDF8);
  static const Color glassBorderSubtle = Color(0x1A94A3B8);

  // Brand Accents
  static const Color primary = Color(0xFF00D2FF);
  static const Color primaryGlow = Color(0x4D00D2FF);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color accentIndigo = Color(0xFF6366F1);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentTeal = Color(0xFF14B8A6);

  // Status & Telemetry
  static const Color success = Color(0xFF10B981);
  static const Color successGlow = Color(0x4D10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningGlow = Color(0x4DF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color errorGlow = Color(0x4DEF4444);
  static const Color info = Color(0xFF0EA5E9);

  // Toner / Ink Colors
  static const Color tonerBlack = Color(0xFF1E293B);
  static const Color tonerCyan = Color(0xFF06B6D4);
  static const Color tonerMagenta = Color(0xFFEC4899);
  static const Color tonerYellow = Color(0xFFEAB308);

  // Typography Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textHighlight = Color(0xFF38BDF8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D2FF), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF162032), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient adOverlayGradient = LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x990A0E17),
      Color(0xF00A0E17),
    ],
    stops: [0.3, 0.7, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
