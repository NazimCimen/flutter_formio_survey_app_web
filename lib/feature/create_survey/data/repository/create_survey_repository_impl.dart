import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

class CreateSurveyRepositoryImpl implements CreateSurveyRepository {
  final CreateSurveyRemoteDataSource remoteDataSource;
  CreateSurveyRepositoryImpl({
    required this.remoteDataSource,
  });

  /// IT IS USED TO SAVE SURVEY INFO DATAS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareSurveyInfo({
    required SurveyEntity entity,
  }) async {
    final model = SurveyModel.fromEntity(entity);
    final result = await remoteDataSource.shareSurveyInfo(model: model);
    return result;
  }

  /// IT IS USED TO SAVE QUESTIONS IN FIRESTORE
  @override
  Future<Either<Failure, bool>> shareQuestions({
    required List<QuestionEntity> questionEntityList,
  }) async {
    final questionModelList = <QuestionModel>[];
    for (final model in questionEntityList) {
      final questionModel = QuestionModel.fromEntity(model);
      questionModelList.add(questionModel);
    }
    final result = await remoteDataSource.shareQuestions(
      questionModelList: questionModelList,
    );
    return result;
  }

  /// IT IS USED TO REMOVE SURVEY DATAS FROM STORAGE AND FIRESTORE
  @override
  Future<Either<Failure, bool>> removeSurvey({required String surveyId}) async {
    final result = await remoteDataSource.removeSurvey(surveyId: surveyId);
    return result;
  }
}
