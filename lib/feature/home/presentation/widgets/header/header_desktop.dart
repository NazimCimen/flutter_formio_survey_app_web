import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';
import 'package:flutter_survey_app_web/product/constants/feature_items.dart';
import 'package:flutter_survey_app_web/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/widgets/register_button_widget.dart';

class HeaderDesktop extends StatelessWidget {
  final void Function(int) sectionNavButton;
  const HeaderDesktop({required this.sectionNavButton, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 40,
        right: 40,
      ),
      child: Container(
        height: 60,
        width: double.maxFinite,
        padding: const EdgeInsets.all(12),
        decoration: CustomBoxDecoration.customBoxDecoration(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageEnums.logo.toPathPng,
              fit: BoxFit.cover,
              height: 27,
            ),
            const Spacer(),
            for (int i = 0; i < FeatureItems.drawerItems.length; i++)
              FeatureButton(
                text: FeatureItems.drawerItems[i].text,
                onPressed: () {
                  sectionNavButton(i);
                },
                isFocused: false,
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
