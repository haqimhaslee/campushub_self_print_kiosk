/// Global application constants.
class AppConstants {
  AppConstants._();

  // Kiosk Identification
  static const String kioskId = 'CAMPUS-PRINT-K04';
  static const String kioskName = 'Campus Hub Print Station 04';
  static const String appVersion = 'v2.4.0 (Windows Kiosk)';
  static const String campusLocation = 'Central Library • Level 2, Zone B';
  static const String building = 'Knowledge Complex Block C';

  // Base Scan-to-Print URL format for QR
  static const String printPortalBaseUrl =
      'https://print.campushub.edu.my/kiosk?station_id=CAMPUS-PRINT-K04';

  // Slideshow & Animation Durations
  static const Duration adSlideDuration = Duration(seconds: 7);
  static const Duration adTransitionDuration = Duration(milliseconds: 600);
  static const Duration qrPulseDuration = Duration(seconds: 2);
  static const Duration statusRefreshInterval = Duration(seconds: 15);

  // Layout Metrics
  static const double defaultBorderRadius = 16.0;
  static const double cardPadding = 20.0;
  static const double maxContentWidth = 1920.0;
}
