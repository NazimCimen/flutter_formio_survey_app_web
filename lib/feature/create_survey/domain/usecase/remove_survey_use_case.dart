import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';

class RemoveSurveyUseCase {
  final CreateSurveyRepository repository;
  RemoveSurveyUseCase({required this.repository});
  Future<Either<Failure, bool>> call({required String surveyId}) async {
    return repository.removeSurvey(surveyId: surveyId);
  }
}
