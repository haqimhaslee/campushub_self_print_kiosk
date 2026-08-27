import 'package:flutter/material.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/printer_status_model.dart';
import '../common/glass_container_widget.dart';
import '../common/section_header_widget.dart';
import 'paper_tray_gauge_widget.dart';
import 'printer_info_card_widget.dart';
import 'printer_specs_grid_widget.dart';
import 'queue_status_widget.dart';
import 'toner_level_gauge_widget.dart';

/// The main Printer Telemetry & Status section of the kiosk UI.
class PrinterStatusSection extends StatelessWidget {
  final PrinterStatusModel printerStatus;

  const PrinterStatusSection({
    super.key,
    required this.printerStatus,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainerWidget(
      padding: const EdgeInsets.all(22),
      borderRadius: 22,
      borderColor: AppColors.secondary.withOpacity(0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Title
          const SectionHeaderWidget(
            icon: Icons.monitor_heart_rounded,
            title: KioskStrings.printerStatusTitle,
            subtitle: 'Real-time telemetry, paper capacity & toner meters',
            iconColor: AppColors.secondary,
          ),
          const SizedBox(height: 16),

          // Printer Info & Health
          PrinterInfoCardWidget(printerStatus: printerStatus),
          const SizedBox(height: 14),

          // Live Queue Bar
          QueueStatusWidget(printerStatus: printerStatus),
          const SizedBox(height: 16),

          // Paper Tray Levels
          PaperTrayGaugeWidget(printerStatus: printerStatus),
          const SizedBox(height: 14),

          // Toner Cartridges CMYK
          TonerLevelGaugeWidget(printerStatus: printerStatus),
          const SizedBox(height: 14),

          // Hardware Capabilities Chips
          PrinterSpecsGridWidget(printerStatus: printerStatus),
        ],
      ),
    );
  }
}
