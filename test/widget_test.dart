import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ch_self_print_kiosk/app.dart';
import 'package:ch_self_print_kiosk/core/constants/kiosk_strings.dart';
import 'package:ch_self_print_kiosk/presentation/widgets/ads_slideshow/ad_slideshow_section.dart';
import 'package:ch_self_print_kiosk/services/clock_service.dart';
import 'package:ch_self_print_kiosk/services/mock_kiosk_service.dart';

void main() {
  testWidgets(
    'Campus Hub Kiosk Dashboard renders primary sections and 16:9 ads',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const CampusHubKioskApp());
      await tester.pump(const Duration(milliseconds: 200));

      // 1. Verify brand header & location
      expect(find.text(KioskStrings.brandTitle), findsOneWidget);

      // 2. Verify 16:9 AspectRatio widget is present in the Ad slideshow
      final aspectRatioFinder = find.descendant(
        of: find.byType(AdSlideshowSection),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is AspectRatio &&
              (widget.aspectRatio - (16.0 / 9.0)).abs() < 0.001,
        ),
      );
      expect(aspectRatioFinder, findsOneWidget);

      // 3. Verify PageView has NeverScrollableScrollPhysics (hands-free / see-only)
      final pageView = tester.widget<PageView>(find.byType(PageView));
      expect(pageView.physics, isA<NeverScrollableScrollPhysics>());

      // 4. Verify Scan to Print section is present
      expect(find.text(KioskStrings.scanToPrintTitle), findsOneWidget);

      // 5. Verify Printer Telemetry section is removed from main kiosk view
      expect(find.text(KioskStrings.printerStatusTitle), findsNothing);

      // 6. Verify Notice Ticker is present in Header
      expect(find.text('NOTICE'), findsOneWidget);

      // 7. Verify WhatsApp & Helpdesk Support contacts are present in QR section
      expect(find.text(KioskStrings.whatsappSupport), findsOneWidget);
      expect(find.text(KioskStrings.helpdeskHotline), findsOneWidget);

      // 8. Verify no public interactive simulate buttons exist on main screen
      expect(find.text('Simulate Mobile Scan & Print'), findsNothing);

      // Clean up
      MockKioskService().stopTimers();
      ClockService().dispose();
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 100));

      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    },
  );

  testWidgets('Dashboard renders on 1366x768 and 1280x720 without overflow', (
    WidgetTester tester,
  ) async {
    for (final size in [const Size(1366, 768), const Size(1280, 720)]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const CampusHubKioskApp());
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text(KioskStrings.brandTitle), findsOneWidget);
      expect(find.text(KioskStrings.scanToPrintTitle), findsOneWidget);
      expect(find.text('NOTICE'), findsOneWidget);
      expect(find.text(KioskStrings.whatsappSupport), findsOneWidget);
      expect(find.text(KioskStrings.printerStatusTitle), findsNothing);

      MockKioskService().stopTimers();
      ClockService().dispose();
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 100));
    }

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
