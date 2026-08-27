import 'package:flutter/material.dart';

/// Represents a single slide item in the advertisement & announcements carousel.
class AdBannerItem {
  final String id;
  final String title;
  final String subtitle;
  final String tag;
  final IconData icon;
  final List<Color> gradientColors;
  final String? promoCode;
  final String? validityPeriod;
  final String? ctaText;
  final String? imageUrl;

  const AdBannerItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.icon,
    required this.gradientColors,
    this.promoCode,
    this.validityPeriod,
    this.ctaText,
    this.imageUrl,
  });

  /// Factory sample items for the Kiosk demonstration
  static List<AdBannerItem> get sampleBanners => const [
        AdBannerItem(
          id: 'ad_exam_season',
          title: 'Final Exam Rush? 50% Off Duplex Printing',
          subtitle:
              'Print your thesis, past papers & lecture notes in bulk. Save ink, money, and trees with auto-duplex.',
          tag: 'PROMO OF THE WEEK',
          icon: Icons.school_rounded,
          gradientColors: [Color(0xFF1E3A8A), Color(0xFF3B82F6), Color(0xFF06B6D4)],
          promoCode: 'FINALS50',
          validityPeriod: 'Valid until 30 Sept 2026',
          ctaText: 'Auto-Applied in App',
        ),
        AdBannerItem(
          id: 'ad_cloud_library',
          title: 'Direct Google Drive & OneDrive Sync',
          subtitle:
              'No thumb drive needed. Connect your cloud storage directly in the CampusHub app for instant 1-tap print.',
          tag: 'FEATURE HIGHLIGHT',
          icon: Icons.cloud_done_rounded,
          gradientColors: [Color(0xFF4C1D95), Color(0xFF7C3AED), Color(0xFFEC4899)],
          promoCode: null,
          validityPeriod: '24/7 Cloud Service',
          ctaText: 'Try on Mobile App',
        ),
        AdBannerItem(
          id: 'ad_hackathon',
          title: 'Campus Hackathon 2026 • Design Submission',
          subtitle:
              'Free high-res A3 poster & diagram printing for all registered participating engineering teams.',
          tag: 'CAMPUS EVENT',
          icon: Icons.rocket_launch_rounded,
          gradientColors: [Color(0xFF064E3B), Color(0xFF059669), Color(0xFF10B981)],
          promoCode: 'HACKFEST',
          validityPeriod: 'Sept 1 - Sept 5, 2026',
          ctaText: 'Show Badge to Claim',
        ),
        AdBannerItem(
          id: 'ad_cashless',
          title: 'Go Cashless with Touch \'n Go & Apple Pay',
          subtitle:
              'Instant student wallet checkout. Reload via DuitNow QR, credit card, or student ID card tap.',
          tag: 'SMART WALLET',
          icon: Icons.contactless_rounded,
          gradientColors: [Color(0xFF78350F), Color(0xFFD97706), Color(0xFFF59E0B)],
          promoCode: 'CASHLESS10',
          validityPeriod: 'Instant Cashless Cashback',
          ctaText: 'Fast & Secure',
        ),
      ];
}
