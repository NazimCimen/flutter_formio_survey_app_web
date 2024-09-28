import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/remove_survey_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/share_questions_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/share_survey_info_use_case.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/image_helper.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity_extension.dart';

class SurveyLogic {
  final ImageHelper imageHelper;
  final RemoveSurveyUseCase removeSurveyUseCase;
  final ShareSurveyInfoUseCase shareSurveyInfoUseCase;
  final ShareQuestionsUseCase shareQuestionsUseCase;
  SurveyLogic({
    required this.imageHelper,
    required this.removeSurveyUseCase,
    required this.shareSurveyInfoUseCase,
    required this.shareQuestionsUseCase,
  });

  Future<Either<Failure, bool>> shareSurvey({
    required SurveyEntity surveyEntity,
    required Uint8List? selectedSurveyImageBytes,
    required Map<QuestionEntity, Uint8List?> questionEntityMap,
  }) async {
    // 1. Anketin görseli yüklenir
    String? imageUrl;
    Failure? failure;
    if (selectedSurveyImageBytes != null) {
      final result = await imageHelper.getImageUrl(
        imageByte: selectedSurveyImageBytes,
        path: surveyEntity.surveyStoragePath,
      );
      result.fold(
        (fail) {
          failure = fail;
        },
        (url) {
          imageUrl = url;
        },
      );
    }
    if (failure != null) {
      return Left(failure!);
    }
    // 2. Soruların image url'leri alınır ve question entity'ye eklenir
    final questionsResult = await _convertFromMapToEntityList(
      questionEntityMap: questionEntityMap,
      path: surveyEntity.surveyStoragePath,
    );
    var questions = <QuestionEntity>[];
    questionsResult.fold(
      (fail) {
        failure = fail;
      },
      (questionList) {
        questions = questionList;
      },
    );
    if (failure != null) {
      return Left(failure!);
    }
    // 3. Anket paylaşılır
    final updatedSurveyEntity = surveyEntity.copyWith(
      surveyImageUrl: imageUrl,
      publicationDate: DateTime.now().toUtc(),
      questionCount: questions.length,
      startDate: surveyEntity.startDate?.toUtc(),
      endDate: surveyEntity.endDate?.toUtc(),
    );

    final surveyResult =
        await shareSurveyInfoUseCase.call(entity: updatedSurveyEntity);
    surveyResult.fold(
      (fail) {
        failure = fail;
      },
      (success) {
        if (!success) {
          failure = ServerFailure(errorMessage: 'errorMessage');
        }
      },
    );
    if (failure != null) {
      return Left(failure!);
    }

    // 4. Sorular paylaşılır
    final questionsResultUpload =
        await shareQuestionsUseCase.call(questionEntityList: questions);
    questionsResultUpload.fold(
      (fail) {
        failure = fail;
      },
      (succes) {
        if (!succes) {
          failure = ServerFailure(errorMessage: 'errorMessage');
        }
      },
    );
    if (failure != null) {
      return Left(failure!);
    } else {
      return const Right(true);
    }
  }

  Future<void> removeSurvey({required String? surveyId}) async {
    if (surveyId != null) {
      final response = await removeSurveyUseCase.call(surveyId: surveyId);
      response.fold(
        (fail) {
          if (fail is! ConnectionFailure) {
            /// crashlytics+loglama
          }
        },
        (succes) {
          if (!succes) {
            /// crashlytics+loglama
          }
        },
      );
    }
  }

  Future<Either<Failure, List<QuestionEntity>>> _convertFromMapToEntityList({
    required Map<QuestionEntity, Uint8List?> questionEntityMap,
    required String path,
  }) async {
    final questionEntityList = <QuestionEntity>[];
    for (final entry in questionEntityMap.entries) {
      final question = entry.key;
      final imageBytes = entry.value;
      if (imageBytes != null) {
        final imageUrl = await imageHelper.getImageUrl(
          imageByte: imageBytes,
          path: path,
        );
        imageUrl.fold(
          (fail) {
            return fail;
          },
          (url) {
            final questionEntity = question.copyWith(
              imageUrl: url,
              surveyId: question.surveyId,
            );
            questionEntityList.add(questionEntity);
          },
        );
      } else {
        final questionEntity = question.copyWith(
          surveyId: question.surveyId,
        );
        questionEntityList.add(questionEntity);
      }
    }
    return Right(questionEntityList);
  }
}
