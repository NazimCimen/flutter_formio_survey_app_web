// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/repository/create_survey_repository.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/remove_survey_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/share_questions_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/share_survey_info_use_case.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_survey_use_cases_test.mocks.dart';

@GenerateMocks([CreateSurveyRepository])
void main() {
  late MockCreateSurveyRepository mockRepository;
  late RemoveSurveyUseCase removeSurveyUseCase;
  late ShareQuestionsUseCase shareQuestionsUseCase;
  late ShareSurveyInfoUseCase shareSurveyInfoUseCase;

  setUp(() {
    mockRepository = MockCreateSurveyRepository();
    removeSurveyUseCase = RemoveSurveyUseCase(repository: mockRepository);
    shareQuestionsUseCase = ShareQuestionsUseCase(repository: mockRepository);
    shareSurveyInfoUseCase = ShareSurveyInfoUseCase(repository: mockRepository);
  });

  group('RemoveSurveyUseCase', () {
    const surveyId = 'testSurveyId';

    test('success test', () async {
      // Arrange
      when(mockRepository.removeSurvey(surveyId: surveyId))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await removeSurveyUseCase.call(surveyId: surveyId);

      // Assert
      expect(result, const Right(true));
      verify(mockRepository.removeSurvey(surveyId: surveyId)).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(mockRepository.removeSurvey(surveyId: surveyId)).thenAnswer(
        (_) async => Left(ServerFailure(errorMessage: 'error')),
      );

      // Act
      final result = await removeSurveyUseCase.call(surveyId: surveyId);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('ShareQuestionsUseCase', () {
    const questionEntityList = [
      QuestionEntity(surveyId: '123', title: 'What is your name?'),
    ];

    test('success test', () async {
      // Arrange
      when(
        mockRepository.shareQuestions(
          questionEntityList: questionEntityList,
        ),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result = await shareQuestionsUseCase.call(
        questionEntityList: questionEntityList,
      );

      // Assert
      expect(result, const Right(true));
      verify(
        mockRepository.shareQuestions(
          questionEntityList: questionEntityList,
        ),
      ).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(
        mockRepository.shareQuestions(
          questionEntityList: questionEntityList,
        ),
      ).thenAnswer(
        (_) async => Left(ServerFailure(errorMessage: 'error')),
      );

      // Act
      final result = await shareQuestionsUseCase.call(
        questionEntityList: questionEntityList,
      );

      // Assert
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('ShareSurveyInfoUseCase', () {
    const surveyEntity = SurveyEntity(surveyId: '123');

    test('success test', () async {
      // Arrange
      when(mockRepository.shareSurveyInfo(entity: surveyEntity))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await shareSurveyInfoUseCase.call(entity: surveyEntity);

      // Assert
      expect(result, const Right(true));
      verify(mockRepository.shareSurveyInfo(entity: surveyEntity)).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(mockRepository.shareSurveyInfo(entity: surveyEntity)).thenAnswer(
        (_) async => Left(ServerFailure(errorMessage: 'error')),
      );

      // Act
      final result = await shareSurveyInfoUseCase.call(entity: surveyEntity);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
    });
  });
}
