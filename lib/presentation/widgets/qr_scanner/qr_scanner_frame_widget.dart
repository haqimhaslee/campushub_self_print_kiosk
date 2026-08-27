import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Decorative corner reticle brackets and animated laser scanning line painter for the QR code.
class QrScannerFrameWidget extends StatefulWidget {
  final Widget child;
  final double size;
  final Color cornerColor;
  final bool animateBeam;

  const QrScannerFrameWidget({
    super.key,
    required this.child,
    this.size = 200.0,
    this.cornerColor = AppColors.primary,
    this.animateBeam = true,
  });

  @override
  State<QrScannerFrameWidget> createState() => _QrScannerFrameWidgetState();
}

class _QrScannerFrameWidgetState extends State<QrScannerFrameWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _beamController;
  late final Animation<double> _beamAnimation;

  @override
  void initState() {
    super.initState();
    _beamController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _beamAnimation = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(parent: _beamController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _beamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Child QR code
          widget.child,

          // Corner brackets painter
          Positioned.fill(
            child: CustomPaint(
              painter: _CornerBracketsPainter(
                color: widget.cornerColor,
                bracketLength: 22,
                strokeWidth: 3.5,
              ),
            ),
          ),

          // Scanning Beam
          if (widget.animateBeam)
            AnimatedBuilder(
              animation: _beamAnimation,
              builder: (context, child) {
                return Positioned(
                  top: widget.size * _beamAnimation.value,
                  left: 12,
                  right: 12,
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.cornerColor.withOpacity(0.0),
                          widget.cornerColor,
                          widget.cornerColor.withOpacity(0.0),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.cornerColor.withOpacity(0.8),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
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
