import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/answer_survey_view.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/view/survey_shared_success_view.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/view/home_view.dart';
import 'package:flutter_survey_app_web/feature/settings/presentation/view/settings_view.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/view/add_question_view.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/view/create_questions_view.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/view/create_survey_info_view.dart';
import 'package:flutter_survey_app_web/feature/profile/presentation/view/profile_view.dart';

@immutable
final class AppRoutes {
  const AppRoutes._();

  static const String initialRoute = '/homeView';
  static const String homeView = '/homeView';
  static const String profileView = '/profileView';
  static const String createSurveyInfoView = '/createSurveyInfoView';
  static const String createQuestionsView = '/createQuestionsView';
  static const String addQuestionView = '/addQuestionView';
  static const String settingsView = '/settingsView';
  static const String answerSurveyView = '/answerSurveyView';
  static const String surveySharedSuccessView = '/surveySharedSuccessView';

  static Map<String, WidgetBuilder> get routes => {
        homeView: (context) => const HomeView(),
        createSurveyInfoView: (context) => const CreateSurveyInfoView(),
        createQuestionsView: (context) => const CreateQuestionsView(),
        addQuestionView: (context) {
          final questionEntity =
              ModalRoute.of(context)!.settings.arguments! as QuestionEntity;
          return AddQuestionView(entity: questionEntity);
        },
        surveySharedSuccessView: (context) => const SurveySharedSuccessView(),
        profileView: (context) => const ProfileView(),
        // settingsView: (context) => const SettingsView(),
        answerSurveyView: (context) {
          final surveyId =
              ModalRoute.of(context)!.settings.arguments as String?;
          return AnswerSurveyView(surveyId: surveyId);
        },
      };
}
