import 'package:flutter/material.dart';

class AnswerSurveyView extends StatelessWidget {
  final String? surveyId;

  AnswerSurveyView({required this.surveyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anket Yanıtla'),
      ),
      body: Center(
        child: surveyId != null
            ? SurveyForm(surveyId: surveyId!)
            : Text('Anket bulunamadı.'),
      ),
    );
  }
}

class SurveyForm extends StatelessWidget {
  final String surveyId;

  SurveyForm({required this.surveyId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Anket ID: $surveyId'),
      ],
    );
  }
}
