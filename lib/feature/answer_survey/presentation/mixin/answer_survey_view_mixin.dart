import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/presentation/view/answer_survey_preview.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/presentation/viewmodel/answer_survey_view_model.dart';
import 'package:provider/provider.dart';

mixin SurveyPreviewMixin on State<AnswerSurveyPreview> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await context
            .read<AnswerSurveyViewModel>()
            .getSurvey(surveyId: widget.surveyId!);
      },
    );
    super.initState();
  }
}
