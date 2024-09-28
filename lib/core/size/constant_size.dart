import 'package:flutter/material.dart';

enum ConstantSizes {
  small(8),
  medium(16),
  large(24),
  xLarge(32),
  xxLarge(70),
  smallPageHeight(600),
  mediumPageHeight(750),
  largePageHeight(940),
  imageHeightMedium(135),
  imageHeightLarge(150);

  final double size;
  const ConstantSizes(this.size);
}

extension AppSizeExtension on ConstantSizes {
  double get value => size;

  SizedBox get heightSizedBox => SizedBox(height: size);
  SizedBox get widthSizedBox => SizedBox(width: size);

  BorderRadius get borderRadius => BorderRadius.circular(size);
}
