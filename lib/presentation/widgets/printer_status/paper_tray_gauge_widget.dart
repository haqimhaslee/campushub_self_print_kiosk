import 'package:material_ui/material_ui.dart';
import '../../../core/constants/kiosk_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/printer_status_model.dart';
import '../common/progress_bar_gauge_widget.dart';

/// Renders Tray 1 and Tray 2 capacity status gauges with sheet counts.
class PaperTrayGaugeWidget extends StatelessWidget {
  final PrinterStatusModel printerStatus;

  const PaperTrayGaugeWidget({
    super.key,
    required this.printerStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProgressBarGaugeWidget(
          label: KioskStrings.paperTrayA4,
          value: printerStatus.tray1Level,
          valueText:
              '${(printerStatus.tray1Level * 100).toInt()}% (${printerStatus.tray1Sheets} sheets)',
          activeColor: printerStatus.tray1Level < 0.2
              ? AppColors.warning
              : AppColors.success,
          icon: Icons.layers_rounded,
          height: 9,
        ),
        const SizedBox(height: 12),
        ProgressBarGaugeWidget(
          label: KioskStrings.paperTrayA3,
          value: printerStatus.tray2Level,
          valueText:
              '${(printerStatus.tray2Level * 100).toInt()}% (${printerStatus.tray2Sheets} sheets)',
          activeColor: printerStatus.tray2Level < 0.2
              ? AppColors.warning
              : AppColors.primary,
          icon: Icons.layers_outlined,
          height: 9,
        ),
      ],
    );
  }
}
