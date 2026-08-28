import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_text_styles.dart';

/// Category / promotion badge placed on top of the advertisement card.
class AdTagBadgeWidget extends StatelessWidget {
  final String text;
  final Color color;

  const AdTagBadgeWidget({
    super.key,
    required this.text,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
          fontSize: 10.5,
        ),
      ),
    );
  }
}
