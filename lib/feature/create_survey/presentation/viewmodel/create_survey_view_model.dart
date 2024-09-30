import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/connection/network_info.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/image_process/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';
import 'package:flutter_survey_app_web/product/export.dart';

enum ViewState {
  inActive,
  error,
  success,
  loading,
  noInternet,
  noAddedQuestion
}

class CreateSurveyViewModel extends ChangeNotifier {
  final ImageHelper imageHelper;
  final SurveyLogic surveyLogic;
  final LinkSharingHelper shareLink;
  final INetworkInfo connectivity;
  CreateSurveyViewModel({
    required this.imageHelper,
    required this.surveyLogic,
    required this.shareLink,
    required this.connectivity,
  });

  ViewState _state = ViewState.inActive;
  ViewState get state => _state;
  SurveyEntity _surveyEntity = SurveyEntity(
    userId: const Uuid().v1(),
    surveyId: const Uuid().v1(),
  );
  SurveyEntity get surveyEntity => _surveyEntity;
  Uint8List? selectedSurveyImageBytes;
  Map<QuestionEntity, Uint8List?> _questionEntityMap = {};
  Map<QuestionEntity, Uint8List?> get questionEntityMap => _questionEntityMap;
  Uint8List? selectedQuestionFileBytes;
  bool isSnackBarShown = false;

  /// Sets the current state of the view model and notifies listeners.
  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  /// Resets the ViewModel, clearing survey data and images.
  void resetViewModel() {
    _surveyEntity = SurveyEntity(
      userId: const Uuid().v1(),
      surveyId: const Uuid().v1(),
    );
    _questionEntityMap = {};
    selectedSurveyImageBytes = null;
    setState(ViewState.inActive);
    notifyListeners();
  }

  /// Sets the survey information based on the provided values.
  void setSurveyInfos({
    required String surveyTitle,
    required String surveyDescription,
    required DateTime? startDate,
    required DateTime? endDate,
    required int? surveyTimeInMinute,
  }) {
    _surveyEntity = surveyEntity.copyWith(
      surveyTitle: surveyTitle,
      surveyDescription: surveyDescription,
      startDate: startDate,
      endDate: endDate,
      surveyTimeInMinute: surveyTimeInMinute,
    );
    notifyListeners();
  }

  /// Resets the selected survey image.
  void resetSurveyImage() {
    selectedSurveyImageBytes = null;
    notifyListeners();
  }

  /// Resets the selected question image.
  void resetQuestionImage() {
    selectedQuestionFileBytes = null;
    notifyListeners();
  }

  /// Retrieves an image based on the selected source and crop ratio.
  Future<void> getImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
    required BuildContext context,
  }) async {
    final result = await imageHelper.getImage(
      selectedSource: selectedSource,
      cropRatio: cropRatio,
      context: context,
    );
    if (result != null) {
      if (cropRatio == ImageAspectRatioEnum.surveyImage.ratioCrop) {
        selectedSurveyImageBytes = await result.readAsBytes();
        notifyListeners();
      } else {
        selectedQuestionFileBytes = await result.readAsBytes();
        notifyListeners();
      }
    }
  }

  /// Adds a new question to the question entity map.
  void addNewQuestion({
    required QuestionEntity entity,
    required Uint8List? selectedQuestionFileBytes,
  }) {
    _questionEntityMap[entity] = selectedQuestionFileBytes;
    notifyListeners();
  }

  /// Deletes a question entity from the map.
  void deleteQuestionEntity(QuestionEntity entity) {
    if (_questionEntityMap.containsKey(entity)) {
      _questionEntityMap.remove(entity);
      notifyListeners();
    }
  }

  /// Shares the survey if there are questions; handles loading state.
  /// Rolls back the survey changes in case of a failure.
  Future<void> publishSurvey() async {
    if (_questionEntityMap.isNotEmpty && state != ViewState.error) {
      setState(ViewState.loading);
      Failure? fail;
      final result = await surveyLogic.shareSurvey(
        surveyEntity: _surveyEntity,
        selectedSurveyImageBytes: selectedSurveyImageBytes,
        questionEntityMap: _questionEntityMap,
      );
      result.fold(
        (failure) {
          fail = failure;
        },
        (success) {
          setState(ViewState.success);
        },
      );
      if (fail != null) {
        await _rollbackSurvey(fail: fail!);
      }
    } else {
      if (state != ViewState.error) {
        isSnackBarShown = true;
        setState(ViewState.noAddedQuestion);
      }
    }
  }

  /// Shares the generated survey link.
  void shareSurveyLink() {
    if (_surveyEntity.surveyId != null) {
      shareLink.shareSurveyLink(surveyId: _surveyEntity.surveyId!);
    } else {
      setState(ViewState.error);
    }
  }

  /// Generates the survey link based on the survey ID.
  String getSurveyLink() {
    if (_surveyEntity.surveyId != null) {
      return shareLink.generateSurveyLink(_surveyEntity.surveyId!);
    } else {
      setState(ViewState.error);
      return '';
    }
  }

  /// Rolls back the survey changes in case of a failure.
  Future<void> _rollbackSurvey({required Failure fail}) async {
    if (fail is ConnectionFailure) {
      setState(ViewState.noInternet);
    } else if (fail is ServerFailure) {
      setState(ViewState.error);
      await imageHelper.removeSurveyImages(
        surveyId: _surveyEntity.surveyId,
        userId: _surveyEntity.userId,
      );
      await surveyLogic.removeSurvey(surveyId: _surveyEntity.surveyId);
    } else {
      setState(ViewState.error);
    }
  }

  /// Checks the current internet connectivity status.
  Future<void> checkConnectivity() async {
    setState(ViewState.loading);
    final result = await connectivity.currentConnectivityResult;
    if (result) {
      setState(ViewState.inActive);
    } else {
      setState(ViewState.noInternet);
    }
  }
}
