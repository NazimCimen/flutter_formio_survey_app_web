import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/core/error/failure_handler.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';
import 'package:flutter_survey_app_web/product/firebase/firebase_collection_enum.dart';
import 'package:flutter_survey_app_web/product/firebase/service/base_firebase_service.dart';

abstract class AnswerSurveyRemoteDataSource {
  Future<Either<Failure, SurveyModel>> getSurveyInfo({
    required String surveyId,
  });
}

class AnswerSurveyRemoteDataSourceImpl extends AnswerSurveyRemoteDataSource {
  final BaseFirebaseService service;
  AnswerSurveyRemoteDataSourceImpl({required this.service});
  @override
  Future<Either<Failure, SurveyModel>> getSurveyInfo({
    required String surveyId,
  }) async {
    try {
      final data = await service.getItem(
        collectionPath: FirebaseCollectionEnum.surveys.name,
        docId: surveyId,
      );
      return Right(const SurveyModel().fromJson(data));
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }
}
