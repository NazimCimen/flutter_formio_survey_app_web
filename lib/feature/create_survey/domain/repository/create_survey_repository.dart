import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

abstract class CreateSurveyRepository {
  Future<Either<Failure, bool>> shareSurveyInfo({required SurveyEntity entity});
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionEntity> questionEntityList,
  });
  Future<Either<Failure, bool>> removeSurvey({
    required String surveyId,
  });
}
