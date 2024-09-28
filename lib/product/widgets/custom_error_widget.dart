import 'package:flutter/material.dart';

import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/product/widgets/custom_text_widgets.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  const CustomErrorWidget({
    required this.title,
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.paddingHorizAllXlarge,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                iconData,
                size: context.dynamicWidht(0.28),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              SizedBox(height: context.dynamicHeight(0.02)),
              Center(
                child: CustomTextGreySubTitleWidget(
                  maxLine: 3,
                  subTitle: title,
                ),
              ),
              SizedBox(height: context.dynamicHeight(0.02)),
            ],
          ),
        ),
      ),
    );
  }
}
