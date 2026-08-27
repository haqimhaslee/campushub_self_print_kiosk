import 'package:flutter/material.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/printer_status_model.dart';
import '../common/animated_pulse_dot_widget.dart';

/// Shows current print queue count and live job status.
class QueueStatusWidget extends StatelessWidget {
  final PrinterStatusModel printerStatus;

  const QueueStatusWidget({
    super.key,
    required this.printerStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isPrinting = printerStatus.state == PrinterState.printing;
    final hasQueue = printerStatus.jobsInQueue > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isPrinting
            ? AppColors.primary.withOpacity(0.1)
            : AppColors.cardSurfaceLight.withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPrinting
              ? AppColors.primary.withOpacity(0.4)
              : AppColors.glassBorderSubtle,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isPrinting
                  ? AppColors.primary.withOpacity(0.2)
                  : AppColors.cardSurfaceLight,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isPrinting
                  ? const AnimatedPulseDotWidget(
                      color: AppColors.primary,
                      size: 8,
                    )
                  : Icon(
                      hasQueue ? Icons.queue_rounded : Icons.check_circle_outline_rounded,
                      size: 18,
                      color: hasQueue ? AppColors.warning : AppColors.success,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        KioskStrings.queueTitle,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 10.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${printerStatus.pagesPrintedToday} pages today',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isPrinting
                      ? 'Printing: ${printerStatus.currentJobUser}'
                      : (hasQueue
                          ? '${printerStatus.jobsInQueue} jobs in queue'
                          : KioskStrings.queueEmpty),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isPrinting
                        ? AppColors.primary
                        : (hasQueue ? AppColors.warning : AppColors.textPrimary),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
