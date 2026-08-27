import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Displays the formatted Kiosk ID with a copy / quick action feedback button.
class KioskCodeDisplayWidget extends StatefulWidget {
  final String kioskId;

  const KioskCodeDisplayWidget({
    super.key,
    required this.kioskId,
  });

  @override
  State<KioskCodeDisplayWidget> createState() => _KioskCodeDisplayWidgetState();
}

class _KioskCodeDisplayWidgetState extends State<KioskCodeDisplayWidget> {
  bool _copied = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.kioskId));
    setState(() => _copied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Kiosk ID ${widget.kioskId} copied to clipboard!'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.cardSurfaceLight,
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.35),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              KioskStrings.kioskIdLabel,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            widget.kioskId,
            style: AppTextStyles.monoCode.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(width: 12),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _copyToClipboard,
              child: Tooltip(
                message: 'Copy Kiosk ID',
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _copied
                        ? AppColors.success.withOpacity(0.2)
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _copied ? Icons.check_rounded : Icons.copy_rounded,
                    size: 15,
                    color: _copied ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
