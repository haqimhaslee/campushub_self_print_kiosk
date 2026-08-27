import 'dart:async';

/// Service providing a reactive 1-second interval stream for the kiosk live clock.
class ClockService {
  static ClockService _instance = ClockService._internal();
  factory ClockService() => _instance;

  ClockService._internal() {
    _initStream();
  }

  late StreamController<DateTime> _clockController;
  Timer? _timer;

  void _initStream() {
    _clockController = StreamController<DateTime>.broadcast();
    _clockController.add(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_clockController.isClosed) {
        _clockController.add(DateTime.now());
      }
    });
  }

  Stream<DateTime> get clockStream => _clockController.stream;

  DateTime get now => DateTime.now();

  void dispose() {
    _timer?.cancel();
    _timer = null;
    if (!_clockController.isClosed) {
      _clockController.close();
    }
  }

  static void resetForTesting() {
    _instance.dispose();
    _instance = ClockService._internal();
  }
}
