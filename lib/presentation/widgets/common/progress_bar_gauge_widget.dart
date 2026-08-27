import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// A custom progress bar gauge with animated fill, glowing gradient,
/// and optional value labels.
class ProgressBarGaugeWidget extends StatelessWidget {
  final String label;
  final double value; // 0.0 to 1.0
  final String? valueText;
  final Color activeColor;
  final Color? trackColor;
  final double height;
  final IconData? icon;

  const ProgressBarGaugeWidget({
    super.key,
    required this.label,
    required this.value,
    this.valueText,
    required this.activeColor,
    this.trackColor,
    this.height = 8.0,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 1.0);
    final percentage = (clampedValue * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 14, color: activeColor),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              valueText ?? '$percentage%',
              style: AppTextStyles.labelLarge.copyWith(
                color: clampedValue < 0.2 ? AppColors.warning : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: trackColor ?? AppColors.cardSurfaceLight,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    width: constraints.maxWidth * clampedValue,
                    height: height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          activeColor.withOpacity(0.7),
                          activeColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(height / 2),
                      boxShadow: [
                        BoxShadow(
                          color: activeColor.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
