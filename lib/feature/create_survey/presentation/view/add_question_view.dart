import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';
import 'package:flutter_survey_app_web/product/componets/custom_snack_bars.dart';
import 'package:flutter_survey_app_web/product/export.dart';
part '../sub_view/add_question_sub_view.dart';

class AddQuestionView extends StatefulWidget {
  final QuestionEntity entity;
  const AddQuestionView({required this.entity, super.key});

  @override
  State<AddQuestionView> createState() => _AddQuestionViewState();
}

class _AddQuestionViewState extends State<AddQuestionView>
    with AddQuestionViewMixin {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateSurveyViewModel>();

    return AbsorbPointer(
      absorbing: viewModel.state == ViewState.loading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllMedium,
            child: Responsive(
              mobile: _addQuestionMobile(context),
              tablet: _addQuestionDesktop(context),
              desktop: _addQuestionDesktop(context),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _addQuestionDesktop(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      reverse: true,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: context.cPaddingSmall,
                  child: ImageInputWidget(
                    title: 'Question Image',
                    cropAspectRatio:
                        ImageAspectRatioEnum.questionImage.ratioCrop,
                    selectedFileBytes: selectedImageBytes,
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: context.cPaddingSmall,
                  child: Column(
                    children: [
                      CustomInputField(
                        maxLines: 3,
                        hintText: 'Metninizi girin',
                        title: 'Soru Metni',
                        controller: titleController,
                        validator: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      SizedBox(height: context.dynamicHeight(0.02)),
                      if (widget.entity.type != QuestionType.openEnded)
                        _buildOptionsSection(context),
                      SizedBox(height: context.dynamicHeight(0.05)),
                      _buildCheckBoxSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          _BottomActionButtons(
            onPressedCancel: cancelButton,
            onPressedSave: saveQuestion,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _addQuestionMobile(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      reverse: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageInputWidget(
            title: 'Question Image',
            cropAspectRatio: ImageAspectRatioEnum.questionImage.ratioCrop,
            selectedFileBytes: selectedImageBytes,
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          CustomInputField(
            maxLines: 2,
            hintText: 'Metninizi girin',
            title: 'Soru Metni',
            controller: titleController,
            validator: null,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          if (widget.entity.type != QuestionType.openEnded)
            _buildOptionsSection(context),
          SizedBox(height: context.dynamicHeight(0.02)),
          _buildCheckBoxSection(),
          SizedBox(height: context.dynamicHeight(0.02)),
          _BottomActionButtons(
            onPressedCancel: cancelButton,
            onPressedSave: saveQuestion,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        widget.entity.type == QuestionType.multipleChoice
            ? 'Çoktan Seçmeli'
            : widget.entity.type == QuestionType.openEnded
                ? 'Açık Uçlu'
                : 'Aşağı Açılır Menu',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomTextSubTitleWidget(subTitle: 'Seçenekler'),
        SizedBox(height: context.dynamicHeight(0.01)),
        Column(
          children: inputOptions
              .map((controller) => _buildOptionField(context, controller))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildOptionField(
    BuildContext context,
    TextEditingController controller,
  ) {
    return Padding(
      padding: context.paddingVertAllLow,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              onTap: addNewOption,
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
              decoration: CustomInputDecoration.inputDecoration(
                context: context,
                hintText: 'Seçenek girin',
              ),
            ),
          ),
          SizedBox(width: context.dynamicWidht(0.02)),
          GestureDetector(
            onTap: () => deleteOption(inputOptions.indexOf(controller)),
            child: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxSection() {
    return Column(
      children: [
        _buildCheckBoxRow(
          title: 'Cevaplaması zorunlu soru',
          value: isRequiredCheckBoxValue,
          onChanged: (value) => isRequiredCheckBoxPressed(value: value),
        ),
        if (widget.entity.type == QuestionType.multipleChoice)
          _buildCheckBoxRow(
            title: 'Çoklu seçim özelliği',
            value: isMultipleChoiceCheckBoxValue,
            onChanged: (value) => isMultipleChoiceCheckBoxPressed(value: value),
          ),
        if (widget.entity.type != QuestionType.openEnded)
          _buildCheckBoxRow(
            title: 'Seçeneklere diğer ekle',
            value: isOtherCheckBoxValue,
            onChanged: (value) => isOtherCheckBoxPressed(value: value),
          ),
      ],
    );
  }

  Widget _buildCheckBoxRow({
    required String title,
    required bool value,
    required void Function(bool?)? onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }

  @override
  void showSnackBar({required String errorMsg}) {
    FocusScope.of(context).unfocus();
    CustomSnackBars.showCustomScaffoldSnackBar(
      context: context,
      text: errorMsg,
    );
  }
}
