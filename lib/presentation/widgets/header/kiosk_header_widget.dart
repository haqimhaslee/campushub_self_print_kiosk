import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/kiosk_info_model.dart';
import '../common/glass_container_widget.dart';
import 'campus_brand_widget.dart';
import 'live_clock_widget.dart';
import 'network_status_badge_widget.dart';

/// Top header bar for the kiosk containing brand, campus location, clock, and connection telemetry.
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      borderRadius: 18,
      child: Row(
        children: [
          const CampusBrandWidget(),
          const SizedBox(width: 24),
          // Location Badge
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardSurfaceLight.withOpacity(0.35),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.glassBorderSubtle),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kioskInfo.campusLocation,
                          style: AppTextStyles.titleSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          kioskInfo.building,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 11,
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
          const SizedBox(width: 20),
          NetworkStatusBadgeWidget(kioskInfo: kioskInfo),
          const SizedBox(width: 14),
          const LiveClockWidget(),
        ],
      ),
    );
  }
}
