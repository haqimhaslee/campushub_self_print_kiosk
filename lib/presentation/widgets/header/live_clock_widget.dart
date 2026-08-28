import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_helper.dart';
import '../../../services/clock_service.dart';

/// Live ticking date and time widget for the kiosk header bar.
class LiveClockWidget extends StatelessWidget {
  const LiveClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clockService = ClockService();

    return StreamBuilder<DateTime>(
      stream: clockService.clockStream,
      initialData: clockService.now,
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateTimeHelper.formatLiveTime(now),
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    DateTimeHelper.formatFullDate(now),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
