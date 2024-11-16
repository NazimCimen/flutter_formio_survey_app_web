import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/domain/usecase/get_survey_info_use_case.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/domain/entity/survey_entity.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';
import 'package:flutter_survey_app_web/product/enum/state_enum.dart';
import 'package:flutter_survey_app_web/product/firebase/export.dart';
import 'package:flutter_survey_app_web/product/firebase/service/base_firebase_service.dart';
import 'package:flutter_survey_app_web/product/firebase/service/firebase_service_impl.dart';

class AnswerSurveyViewModel extends ChangeNotifier {
  final GetSurveyInfoUseCase getSurveyInfoUseCase;
  AnswerSurveyViewModel({required this.getSurveyInfoUseCase});
  SurveyEntity? surveyEntity;
  Failure? failure;
  List<QuestionEntity?>? questions = [];

  ViewState _state = ViewState.inActive;
  ViewState get state => _state;
  BaseFirebaseService service = FirebaseServiceImpl<SurveyModel>(
    firestore: FirebaseFirestore.instance,
  );
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<void> getSurvey({required String surveyId}) async {
    setState(ViewState.loading);
    final response = await getSurveyInfoUseCase.call(surveyId: surveyId);
    response.fold(
      (fail) {
        failure = fail;
      },
      (entity) {
        surveyEntity = entity;
      },
    );
    notifyListeners();
  }

  Future<void> getQuestions() async {}
  Future<void> sendAnsweredSurvey() async {}
}
