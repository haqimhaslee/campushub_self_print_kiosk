import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/kiosk_info_model.dart';
import '../common/glass_container_widget.dart';
import '../footer/kiosk_simulation_panel_widget.dart';
import 'ticker_announcement_bar_widget.dart';
import 'campus_brand_widget.dart';
import 'live_clock_widget.dart';
import 'network_status_badge_widget.dart';

/// Top header bar for the kiosk containing brand, campus location, live notice ticker, clock, and connection telemetry.
class KioskHeaderWidget extends StatelessWidget {
  final KioskInfoModel kioskInfo;
  final VoidCallback? onSettingsTap;

  const KioskHeaderWidget({
    super.key,
    required this.kioskInfo,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainerWidget(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      borderRadius: 18,
      child: Row(
        children: [
          // 1. Campus Brand Logo (Tappable for simulation dev panel)
          Tooltip(
            message: 'Tap to open Simulation Panel',
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap:
                  onSettingsTap ??
                  () => KioskSimulationPanelWidget.show(context),
              child: const CampusBrandWidget(),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Compact Location Badge
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cardSurfaceLight.withOpacity(0.35),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.glassBorderSubtle),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 15,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kioskInfo.campusLocation,
                          style: AppTextStyles.labelLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            fontSize: 11.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          kioskInfo.building,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 9.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 3. Live Notice & Announcement Ticker (Rolling broadcast)
          const Expanded(child: TickerAnnouncementBarWidget()),
          const SizedBox(width: 12),

          // 4. Cloud Server Connectivity Badge
          NetworkStatusBadgeWidget(kioskInfo: kioskInfo),
          const SizedBox(width: 10),

          // 5. Live Clock Widget
          const LiveClockWidget(),
        ],
      ),
    );
  }
}
