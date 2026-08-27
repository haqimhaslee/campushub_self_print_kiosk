import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/kiosk_info_model.dart';
import '../common/animated_pulse_dot_widget.dart';

/// Top bar badge showing cloud server connectivity and ping latency.
class NetworkStatusBadgeWidget extends StatelessWidget {
  final KioskInfoModel kioskInfo;

  const NetworkStatusBadgeWidget({
    super.key,
    required this.kioskInfo,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = kioskInfo.isOnline;
    final statusColor = isOnline ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedPulseDotWidget(
            color: statusColor,
            size: 7,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isOnline ? 'CLOUD CONNECTED' : 'DISCONNECTED',
                style: AppTextStyles.labelSmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                isOnline ? '${kioskInfo.pingMs}ms latency' : 'Reconnecting...',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
