import '../core/constants/app_constants.dart';

/// Model representing metadata and network status of the Kiosk station.
class KioskInfoModel {
  final String kioskId;
  final String kioskName;
  final String building;
  final String campusLocation;
  final bool isOnline;
  final int pingMs;
  final DateTime lastHeartbeat;
  final String scanQrUrl;
  final int activeUsersToday;

  const KioskInfoModel({
    required this.kioskId,
    required this.kioskName,
    required this.building,
    required this.campusLocation,
    required this.isOnline,
    required this.pingMs,
    required this.lastHeartbeat,
    required this.scanQrUrl,
    required this.activeUsersToday,
  });

  KioskInfoModel copyWith({
    String? kioskId,
    String? kioskName,
    String? building,
    String? campusLocation,
    bool? isOnline,
    int? pingMs,
    DateTime? lastHeartbeat,
    String? scanQrUrl,
    int? activeUsersToday,
  }) {
    return KioskInfoModel(
      kioskId: kioskId ?? this.kioskId,
      kioskName: kioskName ?? this.kioskName,
      building: building ?? this.building,
      campusLocation: campusLocation ?? this.campusLocation,
      isOnline: isOnline ?? this.isOnline,
      pingMs: pingMs ?? this.pingMs,
      lastHeartbeat: lastHeartbeat ?? this.lastHeartbeat,
      scanQrUrl: scanQrUrl ?? this.scanQrUrl,
      activeUsersToday: activeUsersToday ?? this.activeUsersToday,
    );
  }

  static KioskInfoModel initialMock() {
    return KioskInfoModel(
      kioskId: AppConstants.kioskId,
      kioskName: AppConstants.kioskName,
      building: AppConstants.building,
      campusLocation: AppConstants.campusLocation,
      isOnline: true,
      pingMs: 14,
      lastHeartbeat: DateTime.now(),
      scanQrUrl: AppConstants.printPortalBaseUrl,
      activeUsersToday: 184,
    );
  }
}
