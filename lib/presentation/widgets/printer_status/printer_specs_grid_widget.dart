import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/printer_status_model.dart';

/// Grid of hardware specification chips (Duplex, Speed, Resolution, Color).
class PrinterSpecsGridWidget extends StatelessWidget {
  final PrinterStatusModel printerStatus;

  const PrinterSpecsGridWidget({
    super.key,
    required this.printerStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildSpecChip(
          icon: Icons.speed_rounded,
          label: '${printerStatus.printSpeedPpm} PPM',
          color: AppColors.primary,
        ),
        _buildSpecChip(
          icon: Icons.high_quality_rounded,
          label: printerStatus.maxResolution,
          color: AppColors.secondary,
        ),
        if (printerStatus.hasDuplex)
          _buildSpecChip(
            icon: Icons.flip_to_back_rounded,
            label: 'Auto Duplex (2-Sided)',
            color: AppColors.accentTeal,
          ),
        if (printerStatus.hasColor)
          _buildSpecChip(
            icon: Icons.palette_rounded,
            label: 'Color & B/W',
            color: AppColors.accentPurple,
          ),
        if (printerStatus.hasStapler)
          _buildSpecChip(
            icon: Icons.attach_file_rounded,
            label: 'Corner Stapler',
            color: AppColors.warning,
          ),
      ],
    );
  }

  Widget _buildSpecChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textPrimary,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
