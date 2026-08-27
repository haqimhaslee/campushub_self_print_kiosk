import 'package:flutter/material.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Support contacts badge with hotline, email, and WhatsApp help info.
class SupportHelpBadgeWidget extends StatelessWidget {
  const SupportHelpBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 6,
      children: [
        _buildContactPill(
          icon: Icons.headset_mic_rounded,
          text: KioskStrings.helpdeskHotline,
          color: AppColors.primary,
        ),
        _buildContactPill(
          icon: Icons.chat_rounded,
          text: KioskStrings.whatsappSupport,
          color: AppColors.success,
        ),
      ],
    );
  }

  Widget _buildContactPill({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
