import 'package:flutter/material.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/kiosk_info_model.dart';
import '../../../services/mock_kiosk_service.dart';
import '../common/glass_container_widget.dart';
import '../common/section_header_widget.dart';
import 'kiosk_code_display_widget.dart';
import 'qr_code_card_widget.dart';
import 'scan_step_instruction_widget.dart';

/// The Scan-To-Print QR code interactive station widget.
class QrCodeSection extends StatelessWidget {
  final KioskInfoModel kioskInfo;

  const QrCodeSection({
    super.key,
    required this.kioskInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainerWidget(
      padding: const EdgeInsets.all(22),
      borderRadius: 22,
      borderColor: AppColors.primary.withOpacity(0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Title
          const SectionHeaderWidget(
            icon: Icons.qr_code_scanner_rounded,
            title: KioskStrings.scanToPrintTitle,
            subtitle: KioskStrings.scanToPrintSubtitle,
            iconColor: AppColors.primary,
          ),
          const SizedBox(height: 18),

          // Center Area: QR Code + Kiosk ID
          Center(
            child: Column(
              children: [
                QrCodeCardWidget(
                  qrData: kioskInfo.scanQrUrl,
                  size: 190,
                ),
                const SizedBox(height: 14),
                KioskCodeDisplayWidget(kioskId: kioskInfo.kioskId),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Divider
          Divider(color: AppColors.glassBorderSubtle.withOpacity(0.4)),
          const SizedBox(height: 14),

          // 3 Steps visual instructions
          const Column(
            children: [
              ScanStepInstructionWidget(
                stepNumber: 1,
                icon: Icons.photo_camera_rounded,
                title: KioskStrings.step1Title,
                description: KioskStrings.step1Desc,
              ),
              SizedBox(height: 10),
              ScanStepInstructionWidget(
                stepNumber: 2,
                icon: Icons.upload_file_rounded,
                title: KioskStrings.step2Title,
                description: KioskStrings.step2Desc,
              ),
              SizedBox(height: 10),
              ScanStepInstructionWidget(
                stepNumber: 3,
                icon: Icons.inventory_2_rounded,
                title: KioskStrings.step3Title,
                description: KioskStrings.step3Desc,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Instant Test Print Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                MockKioskService().simulateIncomingPrintJob(
                  user: 'Student #20240982 (Demo Scan)',
                  pages: 4,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.15),
                foregroundColor: AppColors.primary,
                side: BorderSide(
                  color: AppColors.primary.withOpacity(0.4),
                  width: 1.2,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.touch_app_rounded, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Simulate Mobile Scan & Print',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
