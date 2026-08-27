import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Interactive glass navigation arrow button for sliding ads.
class AdNavButtonWidget extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const AdNavButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  State<AdNavButtonWidget> createState() => _AdNavButtonWidgetState();
}

class _AdNavButtonWidgetState extends State<AdNavButtonWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.25)
                  : Colors.black.withOpacity(0.4),
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: Center(
              child: Icon(
                widget.icon,
                color: _isHovered ? AppColors.primary : Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
