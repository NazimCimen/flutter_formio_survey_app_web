import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/error/failure.dart';
import 'package:flutter_survey_app_web/feature/create_survey/domain/usecase/cache_datas_no_internet_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/viewmodel/survey_logic.dart';
import 'package:flutter_survey_app_web/feature/image_process/presentation/image_helper.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/question_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity_extension.dart';
import 'package:flutter_survey_app_web/product/constants/image_aspect_ratio.dart';
import 'package:flutter_survey_app_web/product/helper/link_sharing_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

enum ViewState {
  inActive,
  error,
  success,
  loading,
  noInternet,
  noAddedQuestion
}

class CreateSurveyViewModel extends ChangeNotifier {
  final CacheDatasNoInternetUseCase cacheDatasNoInternetUseCase;
  final ImageHelper imageHelper;
  final SurveyLogic surveyLogic;
  final LinkSharingHelper shareLink;
  CreateSurveyViewModel({
    required this.cacheDatasNoInternetUseCase,
    required this.imageHelper,
    required this.surveyLogic,
    required this.shareLink,
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

  /// Sets the recipe title and description based on the provided values.
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

  void resetSurveyImage() {
    selectedSurveyImageBytes = null;
    notifyListeners();
  }

  /// Selects and crops the survey image
  ///
  Future<void> getImage({
    required ImageSource selectedSource,
    required CropAspectRatio cropRatio,
    required BuildContext context,
  }) async {
    final result = await imageHelper.getImage(
        selectedSource: selectedSource, cropRatio: cropRatio, context: context);
    if (result != null) {
      if (cropRatio == ImageAspectRatioEnum.surveyImage.ratioCrop) {
        selectedSurveyImageBytes = await result.readAsBytes();
        notifyListeners();
      } else {
        selectedQuestionFileBytes = await result.readAsBytes();
        notifyListeners();
      }
    } else {
      /// uyarı mesajı.
    }
  }

  void addNewQuestion({
    required QuestionEntity entity,
    required Uint8List? selectedQuestionFileBytes,
  }) {
    _questionEntityMap[entity] = selectedQuestionFileBytes;
    notifyListeners();
  }

  void resetQuestionImage() {
    selectedQuestionFileBytes = null;
    notifyListeners();
  }

  void deleteQuestionEntity(QuestionEntity entity) {
    if (_questionEntityMap.containsKey(entity)) {
      _questionEntityMap.remove(entity);
      notifyListeners();
    }
  }

  Future<void> shareSurvey() async {
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

  ///MARK:NULL
  void shareSurveyLink() {
    shareLink.shareSurveyLink(surveyId: _surveyEntity.surveyId!);
  }

  ///MARK:NULL
  String getSurveyLink() {
    return shareLink.generateSurveyLink(_surveyEntity.surveyId!);
  }

  ///MARK:CHECK CACHE ON SPLASH
  Future<void> _rollbackSurvey({required Failure fail}) async {
    await _cacheSurveyDatas();
    if (fail is ConnectionFailure) {
      setState(ViewState.noInternet);
    } else if (fail is ServerFailure) {
      setState(ViewState.error);
      await imageHelper.removeSurveyImages(
        surveyId: _surveyEntity.surveyId,
        userId: _surveyEntity.userId,
      );
      await surveyLogic.removeSurvey(surveyId: _surveyEntity.surveyId);
      //internet harici bir sorun olursa log+crashlytics
    } else {
      //log+crashlytics
    }
  }

/*  Future<void> checkConnectivity() async {
    setState(ViewState.loading);
    final result = await connectivity.currentConnectivityResult;
    if (result) {
      setState(ViewState.inActive);
    } else {
      setState(ViewState.noInternet);
    }
  }*/

  Future<void> _cacheSurveyDatas() async {
    if (_surveyEntity.surveyId == null) return;
    await cacheDatasNoInternetUseCase.call(
      path: _surveyEntity.surveyStoragePath,
      surveyId: _surveyEntity.surveyId!,
    );
  }
}
