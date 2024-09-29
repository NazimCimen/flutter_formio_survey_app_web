import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

class ShareSurveyInfoUseCase {
  final CreateSurveyRepository repository;
  ShareSurveyInfoUseCase({required this.repository});
  Future<Either<Failure, bool>> call({required SurveyEntity entity}) async {
    return repository.shareSurveyInfo(entity: entity);
  }
}
