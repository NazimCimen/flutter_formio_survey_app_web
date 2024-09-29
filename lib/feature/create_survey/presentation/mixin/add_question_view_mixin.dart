import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';

mixin AddQuestionViewMixin on State<AddQuestionView> {
  late TextEditingController titleController;
  late List<TextEditingController> inputOptions;
  bool isRequiredCheckBoxValue = false;
  bool isMultipleChoiceCheckBoxValue = false;
  bool isOtherCheckBoxValue = false;
  Uint8List? selectedImageBytes;
  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    for (final option in inputOptions) {
      option.dispose();
    }
    inputOptions.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    selectedImageBytes =
        context.watch<CreateSurveyViewModel>().selectedQuestionFileBytes;
    super.didChangeDependencies();
  }

  /// Method to show a snackbar with an error message, overridden in the view
  void showSnackBar({required String errorMsg});

  /// Method to delete the selected image
  void deleteImage() {
    context.read<CreateSurveyViewModel>().resetQuestionImage();
  }

  /// Method to handle the cancel button action
  void cancelButton() {
    context.read<CreateSurveyViewModel>().resetQuestionImage();
    NavigatorService.goBack();
  }

  /// Method to save the question with its input data
  void saveQuestion() {
    final options = <String>[];
    for (final option in inputOptions) {
      if (option.text.isNotEmpty) {
        options.add(option.text.trim());
      }
    }
    if (titleController.text.trim().isEmpty) {
      showSnackBar(errorMsg: 'Soru Metnini girmeden ilerleyemezsiniz');
    } else if (widget.entity.type != QuestionType.openEnded &&
        options.isEmpty) {
      showSnackBar(errorMsg: 'Please fill in the option fields.');
    } else if (widget.entity.type != QuestionType.openEnded &&
        options.length == 1) {
      showSnackBar(errorMsg: 'Please add at least two options.');
    } else {
      final entity = widget.entity.copyWith(
        title: titleController.text.trim(),
        addOptionOther: isOtherCheckBoxValue,
        isRequired: isRequiredCheckBoxValue,
        multipleChoices: isMultipleChoiceCheckBoxValue,
        options: options,
      );
      context.read<CreateSurveyViewModel>().addNewQuestion(
            entity: entity,
            selectedQuestionFileBytes:
                context.read<CreateSurveyViewModel>().selectedQuestionFileBytes,
          );
      context.read<CreateSurveyViewModel>().resetQuestionImage();
      NavigatorService.goBack();
    }
  }

  /// Method to initialize default values for the input fields
  void getDefaultValues() {
    selectedImageBytes =
        context.read<CreateSurveyViewModel>().selectedQuestionFileBytes;
    titleController = TextEditingController(text: widget.entity.title ?? '');
    inputOptions = [];
    if (widget.entity.options != null) {
      inputOptions = List.generate(
        widget.entity.options!.length,
        (index) => TextEditingController(text: widget.entity.options![index]),
      );
    }
    if (inputOptions.isEmpty) {
      inputOptions.add(TextEditingController());
    }
  }

  /// Method to add a new option field
  void addNewOption() {
    final isValidate = validateOptionFields();
    if (isValidate) {
      inputOptions.add(TextEditingController());
    }
  }

  /// Method to delete an option field
  void deleteOption(int index) {
    if (inputOptions.length != 1) {
      setState(() {
        inputOptions.removeAt(index);
      });
    }
  }

  /// Method to validate the option fields
  bool validateOptionFields() {
    var isEmpty = false;
    setState(() {});
    for (var i = 0; i < inputOptions.length; i++) {
      if (i != (inputOptions.length - 1)) {
        if (inputOptions[i].text.isEmpty) {
          isEmpty = true;
        }
      }
    }
    if (isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  /// Method to toggle the 'required' checkbox
  void isRequiredCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isRequiredCheckBoxValue = value;
      });
    }
  }

  /// Method to toggle the 'multiple choice' checkbox
  void isMultipleChoiceCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isMultipleChoiceCheckBoxValue = value;
      });
    }
  }

  /// Method to toggle the 'other' checkbox
  void isOtherCheckBoxPressed({bool? value}) {
    if (value != null) {
      setState(() {
        isOtherCheckBoxValue = value;
      });
    }
  }
}
