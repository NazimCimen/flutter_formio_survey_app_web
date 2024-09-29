// ignore_for_file: inference_failure_on_instance_creation
import 'package:dartz/dartz.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/data/data_source/create_survey_remote_data_source.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/question_model.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/data/model/survey_model.dart';
import 'package:flutter_survey_app_web/product/firebase/firebase_collection_enum.dart';
import 'package:flutter_survey_app_web/product/firebase/service/base_firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_survey_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([
  BaseFirebaseService,
])
void main() {
  late CreateSurveyRemoteDataSourceImpl dataSource;
  late MockBaseFirebaseService<SurveyModel> mockSurveyFirebaseService;
  late MockBaseFirebaseService<QuestionModel> mockQuestionFirebaseService;

  setUp(() {
    mockSurveyFirebaseService = MockBaseFirebaseService<SurveyModel>();
    mockQuestionFirebaseService = MockBaseFirebaseService<QuestionModel>();
    dataSource = CreateSurveyRemoteDataSourceImpl(
      questionFirebaseService: mockQuestionFirebaseService,
      surveyFirebaseService: mockSurveyFirebaseService,
    );
  });

  group('shareSurveyInfo', () {
    test('success test', () async {
      // Arrange
      const surveyModel = SurveyModel(
        surveyId: '123',
      );
      when(mockSurveyFirebaseService.setItem('surveys', surveyModel))
          .thenAnswer((_) async {});

      // Act
      final result = await dataSource.shareSurveyInfo(model: surveyModel);

      // Assert
      expect(result, const Right(true));
      verify(mockSurveyFirebaseService.setItem('surveys', surveyModel))
          .called(1);
    });

    test('fail test', () async {
      // Arrange
      const surveyModel = SurveyModel(
        surveyId: '123',
      );
      when(mockSurveyFirebaseService.setItem('surveys', surveyModel))
          .thenThrow(Exception('error'));

      // Act
      final result = await dataSource.shareSurveyInfo(model: surveyModel);

      // Assert
      verify(mockSurveyFirebaseService.setItem('surveys', surveyModel))
          .called(1);
      expect(result, isA<Left<Failure, bool>>());
    });
  });
  group('shareQuestions', () {
    const surveyId = '123';

    test('success test', () async {
      // Arrange
      const questionModelList = [
        QuestionModel(surveyId: surveyId, questionId: 'q1'),
        QuestionModel(surveyId: surveyId, questionId: 'q2'),
      ];

      when(
        mockQuestionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
          any,
        ),
      ).thenAnswer((_) async {});

      // Act
      final result =
          await dataSource.shareQuestions(questionModelList: questionModelList);

      // Assert
      expect(result, const Right(true));
      verify(
        mockQuestionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
          questionModelList[0],
        ),
      ).called(1);
      verify(
        mockQuestionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
          questionModelList[1],
        ),
      ).called(1);
    });

    test('fail test - Survey Id is null', () async {
      // Arrange
      const questionModelList = [
        QuestionModel(questionId: 'q1'),
      ];

      // Act
      final result =
          await dataSource.shareQuestions(questionModelList: questionModelList);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test('fail test - Exception during setItem', () async {
      // Arrange
      const questionModelList = [
        QuestionModel(surveyId: surveyId, questionId: 'q1'),
      ];
      when(
        mockQuestionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
          any,
        ),
      ).thenThrow(Exception('error'));

      // Act
      final result =
          await dataSource.shareQuestions(questionModelList: questionModelList);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
      verify(
        mockQuestionFirebaseService.setItem(
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
          questionModelList[0],
        ),
      ).called(1);
    });
  });
  group('removeSurvey', () {
    const surveyId = 'testSurveyId';

    test('success test', () async {
      // Arrange
      when(mockSurveyFirebaseService.deleteSubCollections(any))
          .thenAnswer((_) async {});
      when(
        mockSurveyFirebaseService.deleteItem(
          FirebaseCollectionEnum.surveys.name,
          surveyId,
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await dataSource.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, const Right(true));
      verify(
        mockSurveyFirebaseService.deleteSubCollections([
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
        ]),
      ).called(1);
      verify(
        mockSurveyFirebaseService.deleteItem(
          FirebaseCollectionEnum.surveys.name,
          surveyId,
        ),
      ).called(1);
    });

    test('fail test - Exception during deleteSubCollections', () async {
      // Arrange
      when(mockSurveyFirebaseService.deleteSubCollections(any))
          .thenThrow(Exception('Error deleting subcollections'));

      // Act
      final result = await dataSource.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test('fail test - Exception during deleteItem', () async {
      // Arrange
      when(mockSurveyFirebaseService.deleteSubCollections(any))
          .thenAnswer((_) async {});
      when(
        mockSurveyFirebaseService.deleteItem(
          FirebaseCollectionEnum.surveys.name,
          surveyId,
        ),
      ).thenThrow(Exception('Error deleting item'));

      // Act
      final result = await dataSource.removeSurvey(surveyId: surveyId);

      // Assert
      expect(result, isA<Left<Failure, bool>>());
      verify(
        mockSurveyFirebaseService.deleteSubCollections([
          FirebaseCollectionEnum.surveys.getQuestionsPath(surveyId: surveyId),
        ]),
      ).called(1);
    });
  });
}
