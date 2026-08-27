import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/kiosk_info_model.dart';
import '../../services/mock_kiosk_service.dart';
import '../widgets/ads_slideshow/ad_slideshow_section.dart';
import '../widgets/header/kiosk_header_widget.dart';
import '../widgets/qr_scanner/qr_code_section.dart';

/// Main Dashboard Screen for Campus Hub Self-Print Kiosk (See-Only Digital Signage).
class KioskDashboardScreen extends StatelessWidget {
  const KioskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kioskService = MockKioskService();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Glow Background Orbs
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.08),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.12),
                    blurRadius: 160,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentIndigo.withOpacity(0.09),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentIndigo.withOpacity(0.12),
                    blurRadius: 180,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),

          // Main Kiosk Surface (See-Only Digital Signage Layout - Zero manual scroll/input required)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: ValueListenableBuilder<KioskInfoModel>(
                valueListenable: kioskService.kioskInfoNotifier,
                builder: (context, kioskInfo, child) {
                  return Column(
                    children: [
                      // 1. Top Header Bar (With Brand, Location, Notice Ticker, Clock & Network Status)
                      KioskHeaderWidget(kioskInfo: kioskInfo),
                      const SizedBox(height: 16),

                      // 2. Middle Content Grid (See-Only / No Scroll Required)
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // Wide Kiosk Display (1080p+ / 1920x1080 Widescreen kiosk monitor)
                            if (constraints.maxWidth > 1400) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Left Column: 16:9 Advertisement & Campus Bulletin Carousel
                                  const Expanded(
                                    flex: 11,
                                    child: Center(child: AdSlideshowSection()),
                                  ),
                                  const SizedBox(width: 20),

                                  // Right Column: QR Code Scan-To-Print Station
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: QrCodeSection(
                                        kioskInfo: kioskInfo,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (constraints.maxWidth > 800) {
                              // Standard / Mid-width Kiosk Display (2-Column view e.g. 1366x768, 1280x720)
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Left Column: 16:9 Ads Slideshow
                                  const Expanded(
                                    flex: 6,
                                    child: Center(child: AdSlideshowSection()),
                                  ),
                                  const SizedBox(width: 16),

                                  // Right Column: QR Station
                                  Expanded(
                                    flex: 5,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 420,
                                        child: QrCodeSection(
                                          kioskInfo: kioskInfo,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // Compact Window Display
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 900,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex: 6,
                                        child: AdSlideshowSection(),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        flex: 5,
                                        child: QrCodeSection(
                                          kioskInfo: kioskInfo,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
