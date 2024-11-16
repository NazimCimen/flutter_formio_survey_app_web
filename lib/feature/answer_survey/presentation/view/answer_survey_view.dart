import 'package:flutter/material.dart';

class AnswerSurveyView extends StatefulWidget {
  final String? surveyId;

  const AnswerSurveyView({
    required this.surveyId,
    super.key,
  });

  @override
  State<AnswerSurveyView> createState() => _AnswerSurveyViewState();
}

class _AnswerSurveyViewState extends State<AnswerSurveyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anket Yanıtla'),
      ),
      body: Center(
        child: widget.surveyId != null
            ? SurveyForm(surveyId: widget.surveyId!)
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
