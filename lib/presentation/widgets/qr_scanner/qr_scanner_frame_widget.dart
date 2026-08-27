import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Decorative corner reticle brackets frame for the QR code (clean, static display).
class QrScannerFrameWidget extends StatelessWidget {
  final Widget child;
  final double size;
  final Color cornerColor;

  const QrScannerFrameWidget({
    super.key,
    required this.child,
    this.size = 200.0,
    this.cornerColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Child QR code
          child,

          // Static Corner brackets painter
          Positioned.fill(
            child: CustomPaint(
              painter: _CornerBracketsPainter(
                color: cornerColor,
                bracketLength: 22,
                strokeWidth: 3.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerBracketsPainter extends CustomPainter {
  final Color color;
  final double bracketLength;
  final double strokeWidth;

  _CornerBracketsPainter({
    required this.color,
    required this.bracketLength,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final l = bracketLength;

    // Top-Left
    canvas.drawLine(const Offset(0, 0), Offset(l, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, l), paint);

    // Top-Right
    canvas.drawLine(Offset(w, 0), Offset(w - l, 0), paint);
    canvas.drawLine(Offset(w, 0), Offset(w, l), paint);

    // Bottom-Left
    canvas.drawLine(Offset(0, h), Offset(l, h), paint);
    canvas.drawLine(Offset(0, h), Offset(0, h - l), paint);

    // Bottom-Right
    canvas.drawLine(Offset(w, h), Offset(w - l, h), paint);
    canvas.drawLine(Offset(w, h), Offset(w, h - l), paint);
  }

  @override
  bool shouldRepaint(covariant _CornerBracketsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.bracketLength != bracketLength ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

