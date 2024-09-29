import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/image_process/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

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

  /// Shares the survey along with its questions and images.
  /// This method handles the process of uploading the survey image, converting
  /// question images to URLs, updating the survey entity with image URLs, and
  /// sharing both the survey and its questions.
  Future<Either<Failure, bool>> shareSurvey({
    required SurveyEntity surveyEntity,
    required Uint8List? selectedSurveyImageBytes,
    required Map<QuestionEntity, Uint8List?> questionEntityMap,
  }) async {
    // 1. Uploads the survey image if it exists.
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
    // 2. Converts question images to URLs and updates each question entity.
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
    // 3. Shares the survey by updating its metadata and saving it in the database.
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

    // 4. Shares the questions by uploading their details to the database.
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

  /// Removes the survey from the database by its survey ID.
  /// This method ensures that the survey is deleted from the database
  /// if the `surveyId` is provided.
  Future<void> removeSurvey({required String? surveyId}) async {
    if (surveyId != null) {
      await removeSurveyUseCase.call(surveyId: surveyId);
    }
  }

  /// Converts a map of questions and images to a list of `QuestionEntity` objects.
  /// If a question has an associated image, the image is uploaded and its URL
  /// is added to the question entity. If no image is provided, the question is
  /// added with its existing data.
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
