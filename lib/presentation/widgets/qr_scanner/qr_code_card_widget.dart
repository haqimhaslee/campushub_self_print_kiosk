import 'package:material_ui/material_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_colors.dart';
import 'qr_scanner_frame_widget.dart';

/// Renders the QR code within a high-contrast glowing card with scan reticle.
class QrCodeCardWidget extends StatelessWidget {
  final String qrData;
  final double size;

  const QrCodeCardWidget({
    super.key,
    required this.qrData,
    this.size = 180.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1527),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: QrScannerFrameWidget(
        size: size,
        cornerColor: AppColors.primary,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: size - 32,
            backgroundColor: Colors.white,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Color(0xFF0F172A),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
      ),
    );
  }
}
