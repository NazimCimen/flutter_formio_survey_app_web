import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';

/// this path is used to make crud operation on storage.
extension SurveyPathExtension on SurveyEntity {
  String get surveyStoragePath {
    return 'user/$userId/survey/$surveyId/';
  }
}
