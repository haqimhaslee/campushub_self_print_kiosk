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

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight;
        final isCompact = cardHeight < 360;
        final hPadding = isCompact ? 24.0 : 36.0;
        final vPadding = isCompact ? 20.0 : 28.0;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: item.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: item.gradientColors.first.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background abstract geometric pattern overlays
              Positioned(
                right: -40,
                bottom: -40,
                child: Container(
                  width: isCompact ? 220 : 320,
                  height: isCompact ? 220 : 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),
              Positioned(
                right: 70,
                top: -50,
                child: Container(
                  width: isCompact ? 160 : 220,
                  height: isCompact ? 160 : 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),
              ),

              // Main Content Container
              Padding(
                padding: EdgeInsets.fromLTRB(hPadding, vPadding, hPadding, vPadding + 20),
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
                          width: isCompact ? 48 : 58,
                          height: isCompact ? 48 : 58,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              item.icon,
                              size: isCompact ? 26 : 32,
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
                          style: (isCompact
                                  ? AppTextStyles.titleLarge
                                  : AppTextStyles.displayMedium)
                              .copyWith(
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.subtitle,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.92),
                            fontSize: isCompact ? 13.5 : 15.5,
                            fontWeight: FontWeight.w400,
                            height: 1.35,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    // Bottom Call To Action & Promo Code Bar (Passive Signage Callout)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (item.promoCode != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.45),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.7),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.discount_rounded,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'USE CODE: ${item.promoCode}',
                                  style: AppTextStyles.monoCode.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
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
                                size: 15,
                                color: Colors.white.withOpacity(0.85),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.validityPeriod!,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        if (item.ctaText != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
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
                                    fontSize: 11.5,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14,
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
      },
    );
  }
}
