import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/kiosk_info_model.dart';
import '../../models/printer_status_model.dart';
import '../../services/mock_kiosk_service.dart';
import '../widgets/ads_slideshow/ad_slideshow_section.dart';
import '../widgets/footer/kiosk_footer_widget.dart';
import '../widgets/header/kiosk_header_widget.dart';
import '../widgets/printer_status/printer_status_section.dart';
import '../widgets/qr_scanner/qr_code_section.dart';

/// Main Dashboard Screen for Campus Hub Self-Print Kiosk on Windows.
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

          // Main Kiosk Surface
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ValueListenableBuilder<KioskInfoModel>(
                valueListenable: kioskService.kioskInfoNotifier,
                builder: (context, kioskInfo, child) {
                  return ValueListenableBuilder<PrinterStatusModel>(
                    valueListenable: kioskService.printerNotifier,
                    builder: (context, printerStatus, child) {
                      return Column(
                        children: [
                          // 1. Top Header Bar
                          KioskHeaderWidget(kioskInfo: kioskInfo),
                          const SizedBox(height: 16),

                          // 2. Middle Content Grid
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Desktop Kiosk layout (wide landscape)
                                if (constraints.maxWidth > 960) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Left Column: Advertisement & Campus Bulletin Carousel
                                      const Expanded(
                                        flex: 6,
                                        child: AdSlideshowSection(),
                                      ),
                                      const SizedBox(width: 18),

                                      // Right Column: QR Code Scan Station & Printer Status
                                      Expanded(
                                        flex: 5,
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              QrCodeSection(
                                                  kioskInfo: kioskInfo),
                                              const SizedBox(height: 16),
                                              PrinterStatusSection(
                                                printerStatus: printerStatus,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  // Fallback for narrower window widths
                                  return SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 380,
                                          child: AdSlideshowSection(),
                                        ),
                                        const SizedBox(height: 16),
                                        QrCodeSection(kioskInfo: kioskInfo),
                                        const SizedBox(height: 16),
                                        PrinterStatusSection(
                                          printerStatus: printerStatus,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 3. Bottom Footer Bar
                          const KioskFooterWidget(),
                        ],
                      );
                    },
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
