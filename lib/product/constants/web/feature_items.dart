import 'package:flutter/material.dart';

class FeatureItem {
  final IconData icon;
  final String text;

  FeatureItem({
    required this.icon,
    required this.text,
  });
}

class FeatureItems {
  FeatureItems._();
  static List<FeatureItem> drawerItems = [
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
