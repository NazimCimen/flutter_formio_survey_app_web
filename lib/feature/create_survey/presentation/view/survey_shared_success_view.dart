import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_survey_app_web/config/export.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/product/componets/export.dart';
import 'package:flutter_survey_app_web/product/export.dart';

class SurveySharedSuccessView extends StatelessWidget {
  const SurveySharedSuccessView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Center(
        child: Padding(
          padding: context.paddingAllMedium,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  ImageEnums.success.toPathPng,
                  height: context.dynamicHeight(0.1),
                ),
                SizedBox(height: context.dynamicHeight(0.02)),
                const CustomTextSubTitleWidget(
                  subTitle: 'Anketiniz Başarılı bir şekilde oluşturuldu.',
                ),
                SizedBox(height: context.dynamicHeight(0.02)),
                const _ShareSurvey(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShareSurvey extends StatelessWidget {
  const _ShareSurvey();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TextButton(
          iconData: Icons.share,
          text: 'Paylaş',
          onPressed: () {
            context.read<CreateSurveyViewModel>().shareSurveyLink();
          },
        ),
        _TextButton(
          iconData: Icons.copy,
          text: 'Copy Link',
          onPressed: () {
            Clipboard.setData(
              ClipboardData(
                text: context.read<CreateSurveyViewModel>().getSurveyLink(),
              ),
            );

            CustomSnackBars.showCustomScaffoldSnackBar(
              context: context,
              text: 'Link kopyalandı!',
            );
          },
        ),
      ],
    );
  }
}

class _TextButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final String text;
  const _TextButton({
    required this.iconData,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Theme.of(context).colorScheme.tertiaryFixed,
      ),
      label: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        TextButton(
          onPressed: () {
            context.read<CreateSurveyViewModel>().resetViewModel();
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeView);
          },
          child: Text(
            'Ana Sayfa',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
