import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/product/componets/export.dart';

mixin CreateQuestionsViewMixin on State<CreateQuestionsView> {
  ///Punlish survey and refresh state according to result
  Future<void> publishSurvey() async {
    await context.read<CreateSurveyViewModel>().publishSurvey();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (context.read<CreateSurveyViewModel>().state ==
            ViewState.noAddedQuestion) {
          CustomSnackBars.showCustomScaffoldSnackBar(
            context: context,
            text: 'Lütfen Anketinize soru ekleyin',
          );
        } else if (context.read<CreateSurveyViewModel>().state ==
            ViewState.success) {
          NavigatorService.pushNamedAndRemoveUntil(
            AppRoutes.surveySharedSuccessView,
            arguments: context.read<CreateSurveyViewModel>().getSurveyLink(),
          );
        }
      },
    );
  }
}
