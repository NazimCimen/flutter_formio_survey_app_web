import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

class ShareQuestionsUseCase {
  final CreateSurveyRepository repository;
  ShareQuestionsUseCase({required this.repository});
  Future<Either<Failure, bool>> call({
    required List<QuestionEntity> questionEntityList,
  }) async {
    return repository.shareQuestions(questionEntityList: questionEntityList);
  }
}
