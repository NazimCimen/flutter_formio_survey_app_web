import 'package:flutter/material.dart';

@immutable
final class FeatureItems {
  const FeatureItems._();
  static List<FeatureItem> drawerItems = const [
    FeatureItem(
      icon: Icons.home_outlined,
      text: 'Home',
    ),
    FeatureItem(
      icon: Icons.star_outline,
      text: 'Features',
    ),
    FeatureItem(
      icon: Icons.sentiment_satisfied_outlined,
      text: 'Use Case',
    ),
    FeatureItem(
      icon: Icons.app_shortcut_outlined,
      text: 'About',
    ),
  ];
}

@immutable
final class FeatureItem {
  final IconData icon;
  final String text;

  const FeatureItem({
    required this.icon,
    required this.text,
  });
}
