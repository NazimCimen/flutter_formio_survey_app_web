import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';
import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';

///c:constant
///d:dynamic
///dLowValue: dynamic low value
///cLowValue: constant low value
extension DynamicSizeExtension on BuildContext {
  double get dXLowValue => dynamicHeight(0.005);
  double get dLowValue => dynamicHeight(0.01);
  double get dMediumValue => dynamicHeight(0.02);
  double get dLargeValue => dynamicHeight(0.025);
  double get dXLargeValue => dynamicHeight(0.03);
  double get dXxLargeValue => dynamicHeight(0.1);

  double get cLowValue => ConstantSizes.small.value;
  double get cMediumValue => ConstantSizes.medium.value;
  double get cLargeValue => ConstantSizes.large.value;
  double get cXLargeValue => ConstantSizes.xLarge.value;
  double get cXxLargeValue => ConstantSizes.xxLarge.value;
}

/// CONSTANT PADDING VALUES
extension ConstantPaddinExtension on BuildContext {
  EdgeInsets get cPaddingSmall => EdgeInsets.all(cLowValue);
  EdgeInsets get cPaddingMedium => EdgeInsets.all(cMediumValue);
  EdgeInsets get cPaddingLarge => EdgeInsets.all(cLargeValue);
  EdgeInsets get cPaddingxLarge => EdgeInsets.all(cXLargeValue);
  EdgeInsets get cPaddingxxLarge => EdgeInsets.all(cXxLargeValue);
}

/// DYNAMIC PADDING VALUES
extension DynamicPaddingExtension on BuildContext {
  EdgeInsets get paddingAllXLow => EdgeInsets.all(dXLowValue);
  EdgeInsets get paddingAllLow => EdgeInsets.all(dLowValue);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(dMediumValue);
  EdgeInsets get paddingAllLarge => EdgeInsets.all(dLargeValue);
  EdgeInsets get paddingAllXlarge => EdgeInsets.all(dXLargeValue);
  EdgeInsets get paddingAllXXlarge => EdgeInsets.all(dXxLargeValue);

  EdgeInsets get paddingHorizAllXLow =>
      EdgeInsets.only(left: dXLowValue, right: dXLowValue);
  EdgeInsets get paddingHorizAllLow =>
      EdgeInsets.only(left: dLowValue, right: dLowValue);
  EdgeInsets get paddingHorizAllMedium =>
      EdgeInsets.only(left: dMediumValue, right: dMediumValue);
  EdgeInsets get paddingHorizAllLarge =>
      EdgeInsets.only(left: dLargeValue, right: dLargeValue);
  EdgeInsets get paddingHorizAllXlarge =>
      EdgeInsets.only(left: dXLargeValue, right: dXLargeValue);
  EdgeInsets get paddingHorizAllXXlarge =>
      EdgeInsets.only(left: dXxLargeValue, right: dXxLargeValue);

  EdgeInsets get paddingHorizLeftLow => EdgeInsets.only(left: dLowValue);
  EdgeInsets get paddingHorizLeftMedium => EdgeInsets.only(left: dMediumValue);
  EdgeInsets get paddingHorizLeftLarge => EdgeInsets.only(left: dLargeValue);
  EdgeInsets get paddingHorizLeftXlarge => EdgeInsets.only(left: dXLargeValue);

  EdgeInsets get paddingHorizRightLow => EdgeInsets.only(right: dLowValue);
  EdgeInsets get paddingHorizRightMedium =>
      EdgeInsets.only(right: dMediumValue);
  EdgeInsets get paddingHorizRightLarge => EdgeInsets.only(right: dLargeValue);
  EdgeInsets get paddingHorizRightXlarge =>
      EdgeInsets.only(right: dXLargeValue);

  EdgeInsets get paddingVertAllLow =>
      EdgeInsets.only(top: dLowValue, bottom: dLowValue);
  EdgeInsets get paddingVertAllMedium =>
      EdgeInsets.only(top: dMediumValue, bottom: dMediumValue);
  EdgeInsets get paddingVertAllLarge =>
      EdgeInsets.only(top: dLargeValue, bottom: dLargeValue);
  EdgeInsets get paddingVertAllXlarge =>
      EdgeInsets.only(top: dXLargeValue, bottom: dXLargeValue);

  EdgeInsets get paddingVertTopLow => EdgeInsets.only(top: dLowValue);
  EdgeInsets get paddingVertTopMedium => EdgeInsets.only(top: dMediumValue);
  EdgeInsets get paddingVertTopLarge => EdgeInsets.only(top: dLargeValue);
  EdgeInsets get paddingVertTopXlarge => EdgeInsets.only(top: dXLargeValue);

  EdgeInsets get paddingVertBottomLow => EdgeInsets.only(bottom: dLowValue);
  EdgeInsets get paddingVertBottomMedium =>
      EdgeInsets.only(bottom: dMediumValue);
  EdgeInsets get paddingVertBottomLarge => EdgeInsets.only(bottom: dLargeValue);
  EdgeInsets get paddingVertBottomXlarge =>
      EdgeInsets.only(bottom: dXLargeValue);
  EdgeInsets get paddingVertBottomXXlarge =>
      EdgeInsets.only(bottom: dXxLargeValue);
}
