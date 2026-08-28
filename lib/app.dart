import 'package:material_ui/material_ui.dart';
import 'core/constants/kiosk_strings.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/kiosk_dashboard_screen.dart';

/// The root widget of the Campus Hub Self-Print Kiosk application.
class CampusHubKioskApp extends StatelessWidget {
  const CampusHubKioskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: KioskStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const KioskDashboardScreen(),
    );
  }
}
