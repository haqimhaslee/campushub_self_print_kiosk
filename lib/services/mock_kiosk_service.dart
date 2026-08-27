import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/ad_banner_item.dart';
import '../models/kiosk_info_model.dart';
import '../models/printer_status_model.dart';
import '../core/constants/app_constants.dart';

/// Mock service providing real-time telemetry and state updates for the kiosk.
class MockKioskService {
  static MockKioskService _instance = MockKioskService._internal();
  factory MockKioskService() => _instance;

  MockKioskService._internal() {
    _startHeartbeatTimer();
    _startSlideshowTimer();
  }

  // Reactive state notifiers
  final ValueNotifier<PrinterStatusModel> printerNotifier =
      ValueNotifier<PrinterStatusModel>(PrinterStatusModel.initialMock());

  final ValueNotifier<KioskInfoModel> kioskInfoNotifier =
      ValueNotifier<KioskInfoModel>(KioskInfoModel.initialMock());

  final ValueNotifier<List<AdBannerItem>> adBannersNotifier =
      ValueNotifier<List<AdBannerItem>>(AdBannerItem.sampleBanners);

  final ValueNotifier<int> currentAdIndexNotifier = ValueNotifier<int>(0);

  final ValueNotifier<bool> isAutoSlidePlaying = ValueNotifier<bool>(true);

  Timer? _heartbeatTimer;
  Timer? _slideshowTimer;
  Timer? _jobSimulationTimer;

  void _startHeartbeatTimer() {
    _heartbeatTimer = Timer.periodic(AppConstants.statusRefreshInterval, (timer) {
      final current = kioskInfoNotifier.value;
      // Slight ping jitter for realistic telemetry
      final newPing = (12 + (DateTime.now().second % 8));
      kioskInfoNotifier.value = current.copyWith(
        lastHeartbeat: DateTime.now(),
        pingMs: newPing,
      );
    });
  }

  void _startSlideshowTimer() {
    _slideshowTimer?.cancel();
    _slideshowTimer = Timer.periodic(AppConstants.adSlideDuration, (timer) {
      if (isAutoSlidePlaying.value && adBannersNotifier.value.isNotEmpty) {
        nextAd();
      }
    });
  }

  void nextAd() {
    final next = (currentAdIndexNotifier.value + 1) % adBannersNotifier.value.length;
    currentAdIndexNotifier.value = next;
  }

  void previousAd() {
    final total = adBannersNotifier.value.length;
    final prev = (currentAdIndexNotifier.value - 1 + total) % total;
    currentAdIndexNotifier.value = prev;
  }

  void goToAd(int index) {
    if (index >= 0 && index < adBannersNotifier.value.length) {
      currentAdIndexNotifier.value = index;
    }
  }

  void toggleSlideshowPlay(bool play) {
    isAutoSlidePlaying.value = play;
  }

  /// Change printer state (e.g. for testing UI states)
  void setPrinterState(PrinterState state) {
    final current = printerNotifier.value;
    printerNotifier.value = current.copyWith(state: state);
  }

  /// Simulates a user scanning the QR code and printing a document
  void simulateIncomingPrintJob({
    String user = 'Student #20240982 (Ahmad F.)',
    int pages = 6,
  }) {
    final current = printerNotifier.value;

    // Set to printing
    printerNotifier.value = current.copyWith(
      state: PrinterState.printing,
      currentJobUser: user,
      jobsInQueue: current.jobsInQueue + 1,
    );

    _jobSimulationTimer?.cancel();
    _jobSimulationTimer = Timer(const Duration(seconds: 4), () {
      final updated = printerNotifier.value;
      final newTray1 = (updated.tray1Level - 0.04).clamp(0.05, 1.0);
      final newTray1Sheets = (newTray1 * 500).round();
      final newBlack = (updated.tonerBlack - 0.01).clamp(0.01, 1.0);

      printerNotifier.value = updated.copyWith(
        state: newTray1 < 0.15 ? PrinterState.lowPaper : PrinterState.ready,
        currentJobUser: '',
        jobsInQueue: (updated.jobsInQueue - 1).clamp(0, 99),
        pagesPrintedToday: updated.pagesPrintedToday + pages,
        tray1Level: newTray1,
        tray1Sheets: newTray1Sheets,
        tonerBlack: newBlack,
      );
    });
  }

  /// Refills paper trays to 100%
  void refillPaperTrays() {
    final current = printerNotifier.value;
    printerNotifier.value = current.copyWith(
      tray1Level: 1.0,
      tray1Sheets: 500,
      tray2Level: 1.0,
      tray2Sheets: 500,
      state: current.state == PrinterState.lowPaper ? PrinterState.ready : current.state,
    );
  }

  /// Refills toners to 100%
  void replaceToners() {
    final current = printerNotifier.value;
    printerNotifier.value = current.copyWith(
      tonerBlack: 1.0,
      tonerCyan: 1.0,
      tonerMagenta: 1.0,
      tonerYellow: 1.0,
    );
  }

  /// Toggles kiosk online/offline status
  void toggleOnlineStatus() {
    final current = kioskInfoNotifier.value;
    final newStatus = !current.isOnline;
    kioskInfoNotifier.value = current.copyWith(isOnline: newStatus);

    final printer = printerNotifier.value;
    printerNotifier.value = printer.copyWith(
      state: newStatus ? PrinterState.ready : PrinterState.offline,
    );
  }

  void stopTimers() {
    _heartbeatTimer?.cancel();
    _slideshowTimer?.cancel();
    _jobSimulationTimer?.cancel();
    _heartbeatTimer = null;
    _slideshowTimer = null;
    _jobSimulationTimer = null;
  }

  void dispose() {
    stopTimers();
    printerNotifier.dispose();
    kioskInfoNotifier.dispose();
    adBannersNotifier.dispose();
    currentAdIndexNotifier.dispose();
    isAutoSlidePlaying.dispose();
  }

  static void resetForTesting() {
    _instance.stopTimers();
    _instance = MockKioskService._internal();
  }
}
