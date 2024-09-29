import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';
import 'package:flutter_survey_app_web/product/firebase/service/base_firebase_service.dart';
import 'package:flutter_survey_app_web/product/firebase/export.dart';

abstract class CreateSurveyRemoteDataSource {
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyModel model,
  });

  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionModel> questionModelList,
  });

  Future<Either<Failure, bool>> removeSurvey({
    required String surveyId,
  });
}

class CreateSurveyRemoteDataSourceImpl extends CreateSurveyRemoteDataSource {
  final BaseFirebaseService<SurveyModel> surveyFirebaseService;
  final BaseFirebaseService<QuestionModel> questionFirebaseService;

  CreateSurveyRemoteDataSourceImpl({
    required this.surveyFirebaseService,
    required this.questionFirebaseService,
  });

  /// IT IS USED TO SAVE SURVEY INFO DATAS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyModel model,
  }) async {
    try {
      await surveyFirebaseService.setItem(
        FirebaseCollectionEnum.surveys.name,
        model,
      );
      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  /// IT IS USED TO SAVE QUESTIONS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionModel> questionModelList,
  }) async {
    try {
      final surveyId = questionModelList[0].surveyId;
      if (surveyId == null) {
        return Left(
          ServerFailure(errorMessage: 'Survey Id is null'),
        );
      }
      for (final model in questionModelList) {
        await questionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(
            surveyId: surveyId,
          ),
          model,
        );
      }

      return const Right(true);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e: e));
    }
  }

  /// IT IS USED TO REMOVE SURVEY DATAS FROM STORAGE AND FIRESTORE
  @override
  Future<Either<Failure, bool>> removeSurvey({required String surveyId}) async {
    try {
      await surveyFirebaseService.deleteSubCollections([
        FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
      ]);

      await surveyFirebaseService.deleteItem(
        FirebaseCollectionEnum.surveys.name,
        surveyId,
      );

      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
