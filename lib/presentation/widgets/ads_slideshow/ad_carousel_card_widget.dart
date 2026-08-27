import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/ad_banner_item.dart';
import 'ad_tag_badge_widget.dart';

/// The visual presentation card for an advertisement or campus bulletin slide.
class AdCarouselCardWidget extends StatelessWidget {
  final AdBannerItem item;

  const AdCarouselCardWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = item.gradientColors.isNotEmpty
        ? item.gradientColors.last
        : AppColors.primary;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: item.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: item.gradientColors.first.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background abstract geometric pattern overlay
          Positioned(
            right: -40,
            bottom: -40,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            right: 80,
            top: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          // Main Content Container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Tag & Icon Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdTagBadgeWidget(
                      text: item.tag,
                      color: primaryColor,
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          item.icon,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                // Center Title and Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyles.displayMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.subtitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white.withOpacity(0.92),
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),

                // Bottom Call To Action and Promo Code Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.promoCode != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.6),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.discount_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'PROMO: ${item.promoCode}',
                              style: AppTextStyles.monoCode.copyWith(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (item.validityPeriod != null)
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.validityPeriod!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    if (item.ctaText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.ctaText!,
                              style: AppTextStyles.labelLarge.copyWith(
                                color: const Color(0xFF0F172A),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
