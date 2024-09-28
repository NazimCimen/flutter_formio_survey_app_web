import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';
import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/core/utils/app_validators.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/mixin/survey_info_input_widget_mixin.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/viewmodel/create_survey_view_model.dart';
import 'package:flutter_survey_app_web/feature/create_survey/presentation/widgets/custom_input_text_field.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:provider/provider.dart';

class CreateSurveyInfoView extends StatefulWidget {
  const CreateSurveyInfoView({super.key});

  @override
  State<CreateSurveyInfoView> createState() => _CreateSurveyInfoViewState();
}

class _CreateSurveyInfoViewState extends State<CreateSurveyInfoView> {
  @override
  Widget build(BuildContext context) {
    final isMobil = Responsive.isMobile(context);
    return Scaffold(
      body: Row(
        children: [
          if (!isMobil)
            const Expanded(
              flex: 40,
              child: _LeftSide(),
            ),
          const Expanded(
            flex: 60,
            child: SurveyInfoInputWidget(),
          ),
        ],
      ),
    );
  }
}

class SurveyInfoInputWidget extends StatefulWidget {
  const SurveyInfoInputWidget({super.key});

  @override
  State<SurveyInfoInputWidget> createState() => _SurveyInfoInputWidgetState();
}

class _SurveyInfoInputWidgetState extends State<SurveyInfoInputWidget>
    with SurveyInfoInputWidgetMixin {
  bool isImageSelected = true;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          onPopInvoked();
        }
      },
      child: AbsorbPointer(
        absorbing:
            context.watch<CreateSurveyViewModel>().state == ViewState.loading,
        child: SingleChildScrollView(
          child: Padding(
            padding: context.cPaddingxLarge,
            child: Form(
              key: formKey,
              autovalidateMode: validateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Lets Get Start to \nCreate Your Survey',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: ConstantSizes.medium.value),
                  CustomInputField(
                    title: 'Survey Title',
                    hintText: 'Survey Title',
                    maxLines: 1,
                    controller: surveyTitleController,
                    validator: (value) =>
                        AppValidators().surveyTitleValidator(value),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: ConstantSizes.medium.value),
                  CustomInputField(
                    title: 'Survey Description',
                    hintText: 'Survey Description',
                    maxLines: 4,
                    controller: surveyDescriptionController,
                    validator: (value) =>
                        AppValidators().surveyDescriptionValidator(value),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.none,
                  ),
                  ConstantSizes.medium.heightSizedBox,
                  GestureDetector(
                    onTap: () => selectStartDate(context),
                    child: AbsorbPointer(
                      child: CustomInputField(
                        title: 'Start Date',
                        hintText: 'Select Start Date',
                        controller: startDateController,
                        validator: (value) =>
                            AppValidators().startDateValidator(value),
                        keyboardType: TextInputType.none,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: ConstantSizes.medium.value),
                  GestureDetector(
                    onTap: () => selectEndDate(context),
                    child: AbsorbPointer(
                      child: CustomInputField(
                        title: 'End Date',
                        hintText: 'Select End Date',
                        controller: endDateController,
                        validator: (value) =>
                            AppValidators().endDateValidator(value),
                        maxLines: 1,
                        keyboardType: TextInputType.none,
                      ),
                    ),
                  ),
                  SizedBox(height: ConstantSizes.medium.value),
                  CustomInputField(
                    title: 'Duration (in minutes)',
                    hintText: 'Duration (in minutes)',
                    maxLines: 1,
                    controller: surveyTimeInMinute,
                    validator: (value) =>
                        AppValidators().durationInMinuteValidator(value),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: ConstantSizes.medium.value),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: ConstantSizes.medium.borderRadius,
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryFixed,
                        fixedSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        navigateAndSetSurveyInfoValues();
                      },
                      child: Text(
                        'NEXT',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.scrim,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LeftSide extends StatelessWidget {
  const _LeftSide();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ConstantSizes.small.value,
        left: ConstantSizes.small.value,
        right: ConstantSizes.small.value,
      ),
      color: Theme.of(context).colorScheme.tertiaryFixed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Image.asset(
              ImageEnums.webtest14.toPathPng,
              fit: BoxFit.contain,
            ),
          ),
          const Flexible(
            child: Align(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _TitleText(
                      text: 'Anonim Yanıtlar',
                    ),
                    _TitleText(
                      text: 'Kolay Paylaşım',
                    ),
                    _TitleText(
                      text: 'Anında Analiz',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                ImageEnums.webtest13.toPathPng,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  const _TitleText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.scrim,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
            height: 2,
          ),
    );
  }
}
