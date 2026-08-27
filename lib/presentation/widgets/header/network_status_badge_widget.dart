import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/kiosk_info_model.dart';
import '../common/animated_pulse_dot_widget.dart';

/// Top bar badge showing cloud server connectivity and ping latency.
class NetworkStatusBadgeWidget extends StatelessWidget {
  final KioskInfoModel kioskInfo;

  const NetworkStatusBadgeWidget({super.key, required this.kioskInfo});

  @override
  Widget build(BuildContext context) {
    final isOnline = kioskInfo.isOnline;
    final statusColor = isOnline ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedPulseDotWidget(color: statusColor, size: 6),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isOnline ? 'ONLINE' : 'OFFLINE',
                style: AppTextStyles.labelSmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 9.5,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                isOnline ? '${kioskInfo.pingMs}ms latency' : 'Reconnecting...',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
