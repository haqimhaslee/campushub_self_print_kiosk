import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/ad_banner_item.dart';
import '../../../services/mock_kiosk_service.dart';
import '../common/glass_container_widget.dart';
import 'ad_carousel_card_widget.dart';
import 'ad_nav_button_widget.dart';
import 'ad_page_indicator_widget.dart';

/// The main advertisement & campus bulletin slideshow section of the kiosk UI.
class AdSlideshowSection extends StatefulWidget {
  const AdSlideshowSection({super.key});

  @override
  State<AdSlideshowSection> createState() => _AdSlideshowSectionState();
}

class _AdSlideshowSectionState extends State<AdSlideshowSection> {
  final PageController _pageController = PageController();
  final MockKioskService _kioskService = MockKioskService();

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _kioskService.currentAdIndexNotifier.removeListener(_onAdIndexChanged);
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
            return GlassContainerWidget(
              padding: const EdgeInsets.all(12),
              borderRadius: 22,
              child: Stack(
                children: [
                  // Carousel View
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: banners.length,
                      onPageChanged: (index) {
                        _kioskService.goToAd(index);
                      },
                      itemBuilder: (context, index) {
                        return AdCarouselCardWidget(
                          item: banners[index],
                        );
                      },
                    ),
                  ),

                  // Left Navigation Button
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AdNavButtonWidget(
                        icon: Icons.chevron_left_rounded,
                        tooltip: 'Previous Announcement',
                        onTap: () {
                          _kioskService.previousAd();
                        },
                      ),
                    ),
                  ),

                  // Right Navigation Button
                  Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AdNavButtonWidget(
                        icon: Icons.chevron_right_rounded,
                        tooltip: 'Next Announcement',
                        onTap: () {
                          _kioskService.nextAd();
                        },
                      ),
                    ),
                  ),

                  // Bottom Controls Bar (Indicators & Slideshow Status)
                  Positioned(
                    bottom: 18,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Slide Counter badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            '${currentIndex + 1} / ${banners.length}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        // Center Page Indicators
                        AdPageIndicatorWidget(
                          totalPages: banners.length,
                          currentIndex: currentIndex,
                          onPageSelected: (index) {
                            _kioskService.goToAd(index);
                          },
                        ),

                        // Auto-play Toggle Button
                        ValueListenableBuilder<bool>(
                          valueListenable: _kioskService.isAutoSlidePlaying,
                          builder: (context, isPlaying, child) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  _kioskService
                                      .toggleSlideshowPlay(!isPlaying);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.45),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isPlaying
                                          ? AppColors.primary
                                          : Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    size: 14,
                                    color: isPlaying
                                        ? AppColors.primary
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
