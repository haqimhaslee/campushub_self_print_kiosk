import 'package:material_ui/material_ui.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/printer_status_model.dart';

/// Renders visual CMYK toner level vertical tubes/gauges.
class TonerLevelGaugeWidget extends StatelessWidget {
  final PrinterStatusModel printerStatus;

  const TonerLevelGaugeWidget({
    super.key,
    required this.printerStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.color_lens_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      KioskStrings.tonerLevelsTitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'CMYK Cartridges',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTonerItem(
              label: 'K',
              subLabel: 'Black',
              level: printerStatus.tonerBlack,
              color: Colors.white70,
              badgeBg: const Color(0xFF1E293B),
            ),
            _buildTonerItem(
              label: 'C',
              subLabel: 'Cyan',
              level: printerStatus.tonerCyan,
              color: AppColors.tonerCyan,
              badgeBg: AppColors.tonerCyan.withOpacity(0.2),
            ),
            _buildTonerItem(
              label: 'M',
              subLabel: 'Magenta',
              level: printerStatus.tonerMagenta,
              color: AppColors.tonerMagenta,
              badgeBg: AppColors.tonerMagenta.withOpacity(0.2),
            ),
            _buildTonerItem(
              label: 'Y',
              subLabel: 'Yellow',
              level: printerStatus.tonerYellow,
              color: AppColors.tonerYellow,
              badgeBg: AppColors.tonerYellow.withOpacity(0.2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTonerItem({
    required String label,
    required String subLabel,
    required double level,
    required Color color,
    required Color badgeBg,
  }) {
    final clamped = level.clamp(0.0, 1.0);
    final percent = (clamped * 100).toInt();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.cardSurfaceLight.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: badgeBg,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1.2),
              ),
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Mini vertical bar
            Container(
              height: 36,
              width: 8,
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 36 * clamped,
                width: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$percent%',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
