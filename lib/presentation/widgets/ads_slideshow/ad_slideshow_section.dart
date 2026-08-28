import 'package:material_ui/material_ui.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/ad_banner_item.dart';
import '../../../services/mock_kiosk_service.dart';
import '../common/glass_container_widget.dart';
import 'ad_carousel_card_widget.dart';
import 'ad_page_indicator_widget.dart';

/// The 16:9 advertisement & campus bulletin slideshow section for see-only digital signage.
class AdSlideshowSection extends StatefulWidget {
  const AdSlideshowSection({super.key});

  @override
  State<AdSlideshowSection> createState() => _AdSlideshowSectionState();
}

class _AdSlideshowSectionState extends State<AdSlideshowSection>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final MockKioskService _kioskService = MockKioskService();
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: AppConstants.adSlideDuration,
    )..forward();

    _kioskService.currentAdIndexNotifier.addListener(_onAdIndexChanged);
  }

  void _onAdIndexChanged() {
    final nextIndex = _kioskService.currentAdIndexNotifier.value;
    if (_pageController.hasClients &&
        _pageController.page?.round() != nextIndex) {
      _pageController.animateToPage(
        nextIndex,
        duration: AppConstants.adTransitionDuration,
        curve: Curves.easeInOutCubic,
      );
    }
    _progressController.reset();
    _progressController.forward();
  }

  @override
  void dispose() {
    _kioskService.currentAdIndexNotifier.removeListener(_onAdIndexChanged);
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<AdBannerItem>>(
      valueListenable: _kioskService.adBannersNotifier,
      builder: (context, banners, child) {
        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }

        return ValueListenableBuilder<int>(
          valueListenable: _kioskService.currentAdIndexNotifier,
          builder: (context, currentIndex, child) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: GlassContainerWidget(
                padding: const EdgeInsets.all(10),
                borderRadius: 22,
                child: Stack(
                  children: [
                    // Carousel View (Passive / Hands-Free Signage - No manual swipe required)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: banners.length,
                        itemBuilder: (context, index) {
                          return AdCarouselCardWidget(item: banners[index]);
                        },
                      ),
                    ),

                    // Bottom Passive Status & Progress Bar (See-only indicators)
                    Positioned(
                      bottom: 14,
                      left: 18,
                      right: 18,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Center Page Indicators (Passive)
                              AdPageIndicatorWidget(
                                totalPages: banners.length,
                                currentIndex: currentIndex,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Slide Cycle Progress Bar Line
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, child) {
                                return LinearProgressIndicator(
                                  value: _progressController.value,
                                  minHeight: 2.5,
                                  backgroundColor: Colors.white.withOpacity(
                                    0.15,
                                  ),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
