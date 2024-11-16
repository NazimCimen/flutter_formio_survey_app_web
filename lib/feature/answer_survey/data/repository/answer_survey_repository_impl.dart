import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/data/data_source/answer_survey_remote_data_source.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/domain/repository/answer_survey_repository.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';

class AnswerSurveyRepositoryImpl extends AnswerSurveyRepository {
  final AnswerSurveyRemoteDataSource remoteDataSource;
  AnswerSurveyRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, SurveyEntity>> getSurveyInfo({
    required String surveyId,
  }) async {
    final response = await remoteDataSource.getSurveyInfo(surveyId: surveyId);
    return response.fold(
      (fail) => Left(fail),
      (model) => Right(model.toEntity()),
    );
  }
}
