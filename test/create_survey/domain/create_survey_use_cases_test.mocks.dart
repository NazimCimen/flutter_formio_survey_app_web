// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_survey_app_web/test/create_survey/domain/create_survey_use_cases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_survey_app_web/core/export.dart' as _i4;
import 'package:flutter_survey_app_web/feature/create_survey/export.dart'
    as _i2;
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CreateSurveyRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateSurveyRepository extends _i1.Mock
    implements _i2.CreateSurveyRepository {
  MockCreateSurveyRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i2.Either<_i4.Failure, bool>> shareSurveyInfo(
          {required _i5.SurveyEntity? entity}) =>
      (super.noSuchMethod(
        Invocation.method(
          #shareSurveyInfo,
          [],
          {#entity: entity},
        ),
        returnValue: _i3.Future<_i2.Either<_i4.Failure, bool>>.value(
            _FakeEither_0<_i4.Failure, bool>(
          this,
          Invocation.method(
            #shareSurveyInfo,
            [],
            {#entity: entity},
          ),
        )),
      ) as _i3.Future<_i2.Either<_i4.Failure, bool>>);

  @override
  _i3.Future<_i2.Either<_i4.Failure, bool>> shareQuestions(
          {required List<_i5.QuestionEntity>? questionEntityList}) =>
      (super.noSuchMethod(
        Invocation.method(
          #shareQuestions,
          [],
          {#questionEntityList: questionEntityList},
        ),
        returnValue: _i3.Future<_i2.Either<_i4.Failure, bool>>.value(
            _FakeEither_0<_i4.Failure, bool>(
          this,
          Invocation.method(
            #shareQuestions,
            [],
            {#questionEntityList: questionEntityList},
          ),
        )),
      ) as _i3.Future<_i2.Either<_i4.Failure, bool>>);

  @override
  _i3.Future<_i2.Either<_i4.Failure, bool>> removeSurvey(
          {required String? surveyId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSurvey,
          [],
          {#surveyId: surveyId},
        ),
        returnValue: _i3.Future<_i2.Either<_i4.Failure, bool>>.value(
            _FakeEither_0<_i4.Failure, bool>(
          this,
          Invocation.method(
            #removeSurvey,
            [],
            {#surveyId: surveyId},
          ),
        )),
      ) as _i3.Future<_i2.Either<_i4.Failure, bool>>);
}
