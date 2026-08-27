import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../common/glass_container_widget.dart';
import 'kiosk_simulation_panel_widget.dart';
import 'support_help_badge_widget.dart';
import 'ticker_announcement_bar_widget.dart';

/// Bottom footer bar for the kiosk containing the live notice ticker, support info, and admin control button.
class KioskFooterWidget extends StatelessWidget {
  const KioskFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainerWidget(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: 16,
      child: Row(
        children: [
          // Scrolling Notice Ticker
          const Expanded(
            flex: 5,
            child: TickerAnnouncementBarWidget(),
          ),
          const SizedBox(width: 16),

          // Support Contacts
          const SupportHelpBadgeWidget(),
          const SizedBox(width: 14),

          // Admin Simulation Trigger Button
          Tooltip(
            message: 'Open Kiosk Simulation / Dev Tools',
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => KioskSimulationPanelWidget.show(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.tune_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'SIMULATION',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // System Version
          Text(
            AppConstants.appVersion,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}
