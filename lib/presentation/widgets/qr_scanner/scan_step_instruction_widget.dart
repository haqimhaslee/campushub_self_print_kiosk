import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Renders a numbered step with icon and guide text.
class ScanStepInstructionWidget extends StatelessWidget {
  final int stepNumber;
  final IconData icon;
  final String title;
  final String description;

  const ScanStepInstructionWidget({
    super.key,
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
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
                children: [
                  Icon(icon, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
