import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/domain/repository/answer_survey_repository.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';

class GetSurveyInfoUseCase {
  final AnswerSurveyRepository repository;
  GetSurveyInfoUseCase(this.repository);
  Future<Either<Failure, SurveyEntity>> call({required String surveyId}) async {
    return repository.getSurveyInfo(surveyId: surveyId);
  }
}
