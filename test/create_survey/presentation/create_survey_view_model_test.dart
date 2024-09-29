// ignore_for_file: inference_failure_on_instance_creation

import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/connection/network_info.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/viewmodel/survey_logic.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/image_helper.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_web/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_web/product/helper/link_sharing_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:image_picker/image_picker.dart';

import 'create_survey_view_model_test.mocks.dart';

@GenerateMocks([
  SurveyLogic,
  LinkSharingHelper,
  INetworkInfo,
  ImageHelper,
  XFile,
  BuildContext,
])
void main() {
  late CreateSurveyViewModel viewModel;
  late MockSurveyLogic mockSurveyLogic;
  late MockINetworkInfo mockNetworkInfo;
  late MockImageHelper mockImageHelper;
  late MockLinkSharingHelper mockLinkSharingHelper;
  late MockXFile mockXFile;
  late MockBuildContext mockContext;
  setUp(() {
    mockSurveyLogic = MockSurveyLogic();
    mockNetworkInfo = MockINetworkInfo();
    mockImageHelper = MockImageHelper();
    mockLinkSharingHelper = MockLinkSharingHelper();
    mockXFile = MockXFile();
    mockContext = MockBuildContext();
    viewModel = CreateSurveyViewModel(
      connectivity: mockNetworkInfo,
      imageHelper: mockImageHelper,
      surveyLogic: mockSurveyLogic,
      shareLink: mockLinkSharingHelper,
    );
  });

  group('shareSurvey success/fail test', () {
    test('success test', () async {
      // Arrange
      viewModel.addNewQuestion(
        entity: const QuestionEntity(),
        selectedQuestionFileBytes: Uint8List(0),
      );

      when(
        mockSurveyLogic.shareSurvey(
          surveyEntity: anyNamed('surveyEntity'),
          selectedSurveyImageBytes: anyNamed('selectedSurveyImageBytes'),
          questionEntityMap: anyNamed('questionEntityMap'),
        ),
      ).thenAnswer((_) async => const Right(true));

      // Act
      await viewModel.publishSurvey();

      // Assert
      expect(viewModel.state, ViewState.success);
    });

    test('fail test', () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'error');
      viewModel.addNewQuestion(
        entity: const QuestionEntity(),
        selectedQuestionFileBytes: Uint8List(0),
      );
      when(
        mockSurveyLogic.shareSurvey(
          surveyEntity: anyNamed('surveyEntity'),
          selectedSurveyImageBytes: anyNamed('selectedSurveyImageBytes'),
          questionEntityMap: anyNamed('questionEntityMap'),
        ),
      ).thenAnswer((_) async => Left(failure));

      // Act
      await viewModel.publishSurvey();

      // Assert
      expect(viewModel.state, ViewState.error);
    });
  });

  group('getImage success/fail test', () {
    test('success test', () async {
      // Arrange
      when(
        mockImageHelper.getImage(
          cropRatio: ImageAspectRatioEnum.questionImage.ratioCrop,
          selectedSource: ImageSource.gallery,
          context: mockContext,
        ),
      ).thenAnswer((_) async => mockXFile);

      when(mockXFile.readAsBytes()).thenAnswer((_) async => Uint8List(0));

      // Act
      await viewModel.getImage(
        cropRatio: ImageAspectRatioEnum.questionImage.ratioCrop,
        selectedSource: ImageSource.gallery,
        context: mockContext,
      );

      // Assert (awaiting listeners)
      await Future<void>.delayed(Duration.zero);
      expect(viewModel.selectedQuestionFileBytes, isNotNull);
    });

    test('fail test', () async {
      // Arrange
      when(
        mockImageHelper.getImage(
          selectedSource: anyNamed('selectedSource'),
          cropRatio: anyNamed('cropRatio'),
          context: mockContext,
        ),
      ).thenAnswer((_) async => null);

      // Act
      await viewModel.getImage(
        selectedSource: ImageSource.gallery,
        cropRatio: ImageAspectRatioEnum.questionImage.ratioCrop,
        context: mockContext,
      );

      // Assert
      expect(viewModel.selectedSurveyImageBytes, isNull);
      expect(viewModel.selectedQuestionFileBytes, isNull);
    });
  });
}
