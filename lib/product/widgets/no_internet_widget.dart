import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';
import 'package:flutter_survey_app_web/product/widgets/custom_text_widgets.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback refresh;
  final String title;
  const NoInternetWidget({
    required this.refresh,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.paddingAllMedium,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageEnums.noInternet.toPathPng,
                height: context.dynamicHeight(0.1),
              ),
              SizedBox(height: context.dynamicHeight(0.01)),
              CustomTextSubTitleWidget(
                subTitle: title,
              ),
              SizedBox(height: context.dynamicHeight(0.01)),
              const CustomTextGreySubTitleWidget(
                maxLine: 3,
                subTitle:
                    'İnternet Bağlantınız yok. Bağlantınızı kontrol edip tekrar deneyin',
              ),
              SizedBox(height: context.dynamicHeight(0.01)),
              TextButton(
                onPressed: refresh,
                child: Text(
                  'Yeniden Dene',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
