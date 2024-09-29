// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app_web/feature/create_survey/data/repository/create_survey_repository_impl.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_survey_repository_impl_test.mocks.dart';

@GenerateMocks([
  CreateSurveyRemoteDataSource,
])
void main() {
  late MockCreateSurveyRemoteDataSource mockRemoteDataSource;
  late CreateSurveyRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockCreateSurveyRemoteDataSource();
    repository =
        CreateSurveyRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('shareSurveyInfo', () {
    const surveyEntity = SurveyEntity(surveyId: '123');
    const surveyModel = SurveyModel(surveyId: '123');

    test('success test', () async {
      // Arrange
      when(mockRemoteDataSource.shareSurveyInfo(model: surveyModel))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.shareSurveyInfo(entity: surveyEntity);

      // Assert
      expect(result, const Right(true));
      verify(mockRemoteDataSource.shareSurveyInfo(model: surveyModel))
          .called(1);
    });

    test('fail test', () async {
      // Arrange
      when(mockRemoteDataSource.shareSurveyInfo(model: surveyModel)).thenAnswer(
        (_) async => Left(ServerFailure(errorMessage: 'error')),
      );

      // Act
      final result = await repository.shareSurveyInfo(entity: surveyEntity);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('shareQuestions', () {
    const questionEntityList = [
      QuestionEntity(surveyId: '123', title: 'What is your name?'),
    ];
    const questionModelList = [
      QuestionModel(surveyId: '123', title: 'What is your name?'),
    ];

    test('success test', () async {
      // Arrange
      when(
        mockRemoteDataSource.shareQuestions(
          questionModelList: questionModelList,
        ),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.shareQuestions(
        questionEntityList: questionEntityList,
      );

      // Assert
      expect(result, const Right(true));
      verify(
        mockRemoteDataSource.shareQuestions(
          questionModelList: questionModelList,
        ),
      ).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(
        mockRemoteDataSource.shareQuestions(
          questionModelList: questionModelList,
        ),
      ).thenAnswer(
        (_) async => Left(ServerFailure(errorMessage: 'error')),
      );

      // Act
      final result = await repository.shareQuestions(
        questionEntityList: questionEntityList,
      );

      // Assert
      expect(result, isA<Left<Failure, bool>>());
    });
  });

  group('removeSurvey', () {
    const surveyId = 'testSurveyId';

    test('success test', () async {
      // Arrange
      when(mockRemoteDataSource.removeSurvey(surveyId: surveyId))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await repository.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, const Right(true));
      verify(mockRemoteDataSource.removeSurvey(surveyId: surveyId)).called(1);
    });

    test('fail test', () async {
      // Arrange
      when(mockRemoteDataSource.removeSurvey(surveyId: surveyId)).thenAnswer(
        (_) async => Left(ServerFailure(errorMessage: 'error')),
      );

      // Act
      final result = await repository.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
    });
  });
}
