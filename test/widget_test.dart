import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campushub_self_print_kiosk/app.dart';
import 'package:campushub_self_print_kiosk/core/constants/kiosk_strings.dart';
import 'package:campushub_self_print_kiosk/services/clock_service.dart';
import 'package:campushub_self_print_kiosk/services/mock_kiosk_service.dart';

void main() {
  testWidgets('Campus Hub Kiosk Dashboard renders primary sections',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const CampusHubKioskApp());
    await tester.pump(const Duration(milliseconds: 200));

    // Verify brand header
    expect(find.text(KioskStrings.brandTitle), findsOneWidget);

    // Verify Scan to Print section
    expect(find.text(KioskStrings.scanToPrintTitle), findsOneWidget);

    // Verify Printer Telemetry section
    expect(find.text(KioskStrings.printerStatusTitle), findsOneWidget);

    // Clean up
    MockKioskService().stopTimers();
    ClockService().dispose();
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 100));

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
