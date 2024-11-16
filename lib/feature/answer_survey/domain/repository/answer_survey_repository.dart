import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

abstract class AnswerSurveyRepository {
  Future<Either<Failure, SurveyEntity>> getSurveyInfo({
    required String surveyId,
  });
}
