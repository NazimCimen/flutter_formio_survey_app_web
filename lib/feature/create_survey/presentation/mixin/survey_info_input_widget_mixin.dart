import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';

mixin SurveyInfoInputWidgetMixin on State<SurveyInfoInputWidget> {
  late TextEditingController surveyTitleController;
  late TextEditingController surveyDescriptionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController surveyTimeInMinute;
  late GlobalKey<FormState> formKey;
  late AutovalidateMode validateMode;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    validateMode = AutovalidateMode.disabled;
    getSurveyInfoDefaultValues();
    super.initState();
  }

  @override
  void dispose() {
    surveyTitleController.dispose();
    surveyDescriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    surveyTimeInMinute.dispose();
    super.dispose();
  }

  void setValidateMode(AutovalidateMode mode) {
    setState(() {
      validateMode = mode;
    });
  }

  ///it used to validate the form fields
  bool validateFields() {
    if (formKey.currentState!.validate()) {
      setValidateMode(AutovalidateMode.always);
      return true;
    } else {
      setValidateMode(AutovalidateMode.disabled);
      return false;
    }
  }

  void navigateAndSetSurveyInfoValues() {
    final isValidate = validateFields();
    if (isValidate) {
      context.read<CreateSurveyViewModel>().setSurveyInfos(
            surveyTitle: surveyTitleController.text.trim(),
            surveyDescription: surveyDescriptionController.text.trim(),
            startDate:
                TypeParser.parseDateTime(startDateController.text.trim()),
            endDate: TypeParser.parseDateTime(
              endDateController.text.trim(),
            ),
            surveyTimeInMinute:
                TypeParser.parseInt(surveyTimeInMinute.text.trim()),
          );
      NavigatorService.pushNamed(
        AppRoutes.createQuestionsView,
        withAnimation: true,
      );
    }
  }

  /// Initializes the form controllers with default values from the ViewModel
  void getSurveyInfoDefaultValues() {
    final survey = context.read<CreateSurveyViewModel>().surveyEntity;
    surveyTitleController = TextEditingController(text: survey.surveyTitle);
    surveyDescriptionController =
        TextEditingController(text: survey.surveyDescription);
    startDateController = TextEditingController(
      text: survey.startDate != null ? survey.startDate.toString() : '',
    );
    endDateController = TextEditingController(
      text: survey.endDate != null ? survey.endDate.toString() : '',
    );
    surveyTimeInMinute = TextEditingController(
      text: survey.surveyTimeInMinute != null
          ? survey.surveyTimeInMinute.toString()
          : '',
    );
  }

  /// Resets the ViewModel state when navigating back
  void onPopInvoked() {
    context.read<CreateSurveyViewModel>().resetViewModel();
  }

  /// Closes the page and resets the ViewModel state
  void closePage() {
    context.read<CreateSurveyViewModel>().resetViewModel();
    NavigatorService.goBack();
  }

  /// Opens a date picker to select the start date, updating the startDateController with the selected date
  Future<void> selectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: endDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(endDateController.text)
          : DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  /// Opens a date picker to select the end date, updating the endDateController with the selected date
  Future<void> selectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(startDateController.text)
          : DateTime.now(),
      firstDate: startDateController.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(startDateController.text)
          : DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
