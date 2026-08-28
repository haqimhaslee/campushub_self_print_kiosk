import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_colors.dart';

/// A glowing rounded icon badge used in headers, feature cards, and specs.
class KioskIconBadgeWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;
  final double borderRadius;

  const KioskIconBadgeWidget({
    super.key,
    required this.icon,
    this.color = AppColors.primary,
    this.size = 42.0,
    this.iconSize = 22.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: color.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
