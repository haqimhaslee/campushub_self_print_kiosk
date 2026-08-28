import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_text_styles.dart';
import 'animated_pulse_dot_widget.dart';

/// A sleek pill badge displaying a state label with glowing pulse and optional icon.
class StatusBadgeWidget extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final bool showPulse;
  final EdgeInsetsGeometry padding;
  final double fontSize;

  const StatusBadgeWidget({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.showPulse = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.fontSize = 11.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showPulse) ...[
            AnimatedPulseDotWidget(color: color, size: 7),
            const SizedBox(width: 6),
          ] else if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: color,
              fontSize: fontSize,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
