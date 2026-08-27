import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Progress pill indicator showing active slide (passive see-only).
class AdPageIndicatorWidget extends StatelessWidget {
  final int totalPages;
  final int currentIndex;

  const AdPageIndicatorWidget({
    super.key,
    required this.totalPages,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 5,
          width: isActive ? 24 : 6,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(3),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
