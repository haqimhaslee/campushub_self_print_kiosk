import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// A reusable glassmorphic container with frosted backdrop blur,
/// gradient fill, and subtle neon border.
class GlassContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final double blur;
  final double? width;
  final double? height;
  final List<BoxShadow>? shadows;

  const GlassContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16.0,
    this.borderColor,
    this.borderWidth = 1.0,
    this.backgroundColor,
    this.blur = 12.0,
    this.width,
    this.height,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.glassBorderSubtle;
    final effectiveBgColor = backgroundColor ?? AppColors.cardSurface.withOpacity(0.75);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: effectiveBgColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
