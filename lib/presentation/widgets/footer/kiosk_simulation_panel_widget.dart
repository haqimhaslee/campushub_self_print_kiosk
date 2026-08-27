import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/printer_status_model.dart';
import '../../../services/mock_kiosk_service.dart';

/// Modal bottom sheet / dialog allowing quick simulation of kiosk states, hardware faults, and print jobs.
class KioskSimulationPanelWidget extends StatelessWidget {
  const KioskSimulationPanelWidget({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const KioskSimulationPanelWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kioskService = MockKioskService();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: AppColors.glassBorderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.tune_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Kiosk Simulation & Control Panel',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Test real-time UI reactions to printer states, print jobs, and consumables:',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Printer State Row
          Text(
            'CHANGE PRINTER STATE',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: PrinterState.values.map((state) {
              return ActionChip(
                avatar: Icon(state.icon, size: 14, color: state.color),
                label: Text(
                  state.displayName,
                  style: TextStyle(
                    color: state.color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: state.color.withOpacity(0.12),
                side: BorderSide(color: state.color.withOpacity(0.4)),
                onPressed: () {
                  kioskService.setPrinterState(state);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Text(
            'HARDWARE & NETWORK SIMULATION',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  kioskService.simulateIncomingPrintJob(
                    user: 'Demo Student #8821',
                    pages: 8,
                  );
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.print_rounded, size: 16),
                label: const Text('Send Test Print Job (8 pgs)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  foregroundColor: AppColors.primary,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  kioskService.refillPaperTrays();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.layers_rounded, size: 16),
                label: const Text('Refill Paper Trays (100%)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success.withOpacity(0.2),
                  foregroundColor: AppColors.success,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  kioskService.replaceToners();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.color_lens_rounded, size: 16),
                label: const Text('Replace All Toners (100%)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentPurple.withOpacity(0.2),
                  foregroundColor: AppColors.accentPurple,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  kioskService.toggleOnlineStatus();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.wifi_rounded, size: 16),
                label: const Text('Toggle Cloud Online/Offline'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warning.withOpacity(0.2),
                  foregroundColor: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
