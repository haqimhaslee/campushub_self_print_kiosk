import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Progress pill indicator showing active slide and animated progress.
class AdPageIndicatorWidget extends StatelessWidget {
  final int totalPages;
  final int currentIndex;
  final ValueChanged<int> onPageSelected;

  const AdPageIndicatorWidget({
    super.key,
    required this.totalPages,
    required this.currentIndex,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentIndex;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onPageSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: isActive ? 28 : 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(3),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}
