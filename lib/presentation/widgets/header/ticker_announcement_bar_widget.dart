import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Rolling live broadcast ticker bar at the bottom of the kiosk UI.
class TickerAnnouncementBarWidget extends StatefulWidget {
  const TickerAnnouncementBarWidget({super.key});

  @override
  State<TickerAnnouncementBarWidget> createState() =>
      _TickerAnnouncementBarWidgetState();
}

class _TickerAnnouncementBarWidgetState
    extends State<TickerAnnouncementBarWidget> {
  final List<String> _notices = const [
    '⚡ PROMO: 50% discount on all double-sided printouts during finals week.',
    '📱 Tip: You can upload PDF files from your phone or Google Drive without queuing.',
    '🌱 Eco-Friendly: Over 12,400 sheets saved this semester using Smart Duplex printing.',
    '💡 Need Help? Tap the WhatsApp support or visit the Library Helpdesk at Ground Floor.',
    '🖨️ High-speed Laserjet online • 55 Pages Per Minute • Color & Mono supported.',
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _notices.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.glassBorderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.accentTeal.withOpacity(0.4),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.campaign_rounded,
                  size: 13,
                  color: AppColors.accentTeal,
                ),
                const SizedBox(width: 4),
                Text(
                  'NOTICE',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.accentTeal,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRect(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[...previousChildren, ?currentChild],
                  );
                },
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  key: ValueKey<int>(_currentIndex),
                  width: double.infinity,
                  child: Text(
                    _notices[_currentIndex],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
