import 'package:flutter/material.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/kiosk_info_model.dart';
import '../common/glass_container_widget.dart';
import '../common/section_header_widget.dart';
import '../footer/support_help_badge_widget.dart';
import 'kiosk_code_display_widget.dart';
import 'qr_code_card_widget.dart';
import 'scan_step_instruction_widget.dart';

/// The Scan-To-Print QR code see-only station widget with assistance & support badges.
class QrCodeSection extends StatelessWidget {
  final KioskInfoModel kioskInfo;

  const QrCodeSection({
    super.key,
    required this.kioskInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainerWidget(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 20,
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
          const SizedBox(height: 10),

          // Center Area: QR Code + Kiosk ID
          Center(
            child: Column(
              children: [
                QrCodeCardWidget(
                  qrData: kioskInfo.scanQrUrl,
                  size: 135,
                ),
                const SizedBox(height: 8),
                KioskCodeDisplayWidget(kioskId: kioskInfo.kioskId),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Divider
          Divider(color: AppColors.glassBorderSubtle.withOpacity(0.4)),
          const SizedBox(height: 8),

          // 3 Steps visual instructions (Passive / See-only guide)
          const Column(
            children: [
              ScanStepInstructionWidget(
                stepNumber: 1,
                icon: Icons.photo_camera_rounded,
                title: KioskStrings.step1Title,
                description: KioskStrings.step1Desc,
              ),
              SizedBox(height: 6),
              ScanStepInstructionWidget(
                stepNumber: 2,
                icon: Icons.upload_file_rounded,
                title: KioskStrings.step2Title,
                description: KioskStrings.step2Desc,
              ),
              SizedBox(height: 6),
              ScanStepInstructionWidget(
                stepNumber: 3,
                icon: Icons.inventory_2_rounded,
                title: KioskStrings.step3Title,
                description: KioskStrings.step3Desc,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Support & Assistance (WhatsApp & Helpdesk)
          Divider(color: AppColors.glassBorderSubtle.withOpacity(0.4)),
          const SizedBox(height: 8),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.support_agent_rounded,
                      size: 13,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'NEED ASSISTANCE?',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const SupportHelpBadgeWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
