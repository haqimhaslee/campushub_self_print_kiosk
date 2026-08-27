import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

enum PrinterState {
  ready,
  printing,
  lowPaper,
  maintenance,
  offline;

  String get displayName {
    switch (this) {
      case PrinterState.ready:
        return 'READY TO PRINT';
      case PrinterState.printing:
        return 'PRINTING JOB...';
      case PrinterState.lowPaper:
        return 'LOW PAPER TRAY';
      case PrinterState.maintenance:
        return 'MAINTENANCE';
      case PrinterState.offline:
        return 'OFFLINE';
    }
  }

  Color get color {
    switch (this) {
      case PrinterState.ready:
        return AppColors.success;
      case PrinterState.printing:
        return AppColors.primary;
      case PrinterState.lowPaper:
        return AppColors.warning;
      case PrinterState.maintenance:
        return AppColors.accentIndigo;
      case PrinterState.offline:
        return AppColors.error;
    }
  }

  IconData get icon {
    switch (this) {
      case PrinterState.ready:
        return Icons.check_circle_rounded;
      case PrinterState.printing:
        return Icons.print_rounded;
      case PrinterState.lowPaper:
        return Icons.warning_amber_rounded;
      case PrinterState.maintenance:
        return Icons.build_rounded;
      case PrinterState.offline:
        return Icons.cloud_off_rounded;
    }
  }
}

/// Model encapsulating real-time hardware status and telemetry for the kiosk's printer.
class PrinterStatusModel {
  final String modelName;
  final String serialNumber;
  final String ipAddress;
  final String locationZone;
  final String floorName;
  final PrinterState state;
  final double tray1Level; // 0.0 - 1.0 (A4 Plain)
  final int tray1Sheets;
  final double tray2Level; // 0.0 - 1.0 (A3 / Special)
  final int tray2Sheets;
  final double tonerBlack; // 0.0 - 1.0
  final double tonerCyan;
  final double tonerMagenta;
  final double tonerYellow;
  final int jobsInQueue;
  final int pagesPrintedToday;
  final String currentJobUser;
  final int printSpeedPpm;
  final String maxResolution;
  final bool hasDuplex;
  final bool hasColor;
  final bool hasStapler;

  const PrinterStatusModel({
    required this.modelName,
    required this.serialNumber,
    required this.ipAddress,
    required this.locationZone,
    required this.floorName,
    required this.state,
    required this.tray1Level,
    required this.tray1Sheets,
    required this.tray2Level,
    required this.tray2Sheets,
    required this.tonerBlack,
    required this.tonerCyan,
    required this.tonerMagenta,
    required this.tonerYellow,
    required this.jobsInQueue,
    required this.pagesPrintedToday,
    this.currentJobUser = '',
    this.printSpeedPpm = 55,
    this.maxResolution = '1200 x 1200 DPI',
    this.hasDuplex = true,
    this.hasColor = true,
    this.hasStapler = true,
  });

  PrinterStatusModel copyWith({
    String? modelName,
    String? serialNumber,
    String? ipAddress,
    String? locationZone,
    String? floorName,
    PrinterState? state,
    double? tray1Level,
    int? tray1Sheets,
    double? tray2Level,
    int? tray2Sheets,
    double? tonerBlack,
    double? tonerCyan,
    double? tonerMagenta,
    double? tonerYellow,
    int? jobsInQueue,
    int? pagesPrintedToday,
    String? currentJobUser,
    int? printSpeedPpm,
    String? maxResolution,
    bool? hasDuplex,
    bool? hasColor,
    bool? hasStapler,
  }) {
    return PrinterStatusModel(
      modelName: modelName ?? this.modelName,
      serialNumber: serialNumber ?? this.serialNumber,
      ipAddress: ipAddress ?? this.ipAddress,
      locationZone: locationZone ?? this.locationZone,
      floorName: floorName ?? this.floorName,
      state: state ?? this.state,
      tray1Level: tray1Level ?? this.tray1Level,
      tray1Sheets: tray1Sheets ?? this.tray1Sheets,
      tray2Level: tray2Level ?? this.tray2Level,
      tray2Sheets: tray2Sheets ?? this.tray2Sheets,
      tonerBlack: tonerBlack ?? this.tonerBlack,
      tonerCyan: tonerCyan ?? this.tonerCyan,
      tonerMagenta: tonerMagenta ?? this.tonerMagenta,
      tonerYellow: tonerYellow ?? this.tonerYellow,
      jobsInQueue: jobsInQueue ?? this.jobsInQueue,
      pagesPrintedToday: pagesPrintedToday ?? this.pagesPrintedToday,
      currentJobUser: currentJobUser ?? this.currentJobUser,
      printSpeedPpm: printSpeedPpm ?? this.printSpeedPpm,
      maxResolution: maxResolution ?? this.maxResolution,
      hasDuplex: hasDuplex ?? this.hasDuplex,
      hasColor: hasColor ?? this.hasColor,
      hasStapler: hasStapler ?? this.hasStapler,
    );
  }

  static PrinterStatusModel initialMock() {
    return const PrinterStatusModel(
      modelName: 'HP PageWide Enterprise Color 780dn',
      serialNumber: 'HP-PRNT-99824X',
      ipAddress: '10.128.4.155',
      locationZone: 'Central Library, Zone B (Near Quiet Study)',
      floorName: 'Level 2, West Wing',
      state: PrinterState.ready,
      tray1Level: 0.88,
      tray1Sheets: 440,
      tray2Level: 0.65,
      tray2Sheets: 325,
      tonerBlack: 0.94,
      tonerCyan: 0.82,
      tonerMagenta: 0.76,
      tonerYellow: 0.89,
      jobsInQueue: 0,
      pagesPrintedToday: 1248,
      currentJobUser: '',
    );
  }
}
