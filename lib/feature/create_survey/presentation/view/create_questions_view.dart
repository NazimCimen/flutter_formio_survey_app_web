import 'package:flutter_survey_app_web/config/export.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/feature/shared_layers/export.dart';
import 'package:flutter_survey_app_web/product/export.dart';
part '../sub_view/create_questions_sub_view.dart';

class CreateQuestionsView extends StatefulWidget {
  const CreateQuestionsView({super.key});

  @override
  CreateQuestionsViewState createState() => CreateQuestionsViewState();
}

class CreateQuestionsViewState extends State<CreateQuestionsView>
    with CreateQuestionsViewMixin {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing:
          context.watch<CreateSurveyViewModel>().state == ViewState.loading,
      child: Scaffold(
        floatingActionButton: _CustomFloatingActionButton(
          isDialOpen: isDialOpen,
        ),
        appBar: _CustomAppBar(
          shareSurvey: publishSurvey,
        ),
        body: SafeArea(
          child: Padding(
            padding: context.paddingAllLow,
            child: Consumer<CreateSurveyViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == ViewState.error) {
                  return const CustomErrorWidget(
                    title: 'Bir Sorun Oluştu Daha Sonra Tekrar Deneyin..',
                    iconData: Icons.error_outline,
                  );
                } else if (viewModel.state == ViewState.loading) {
                  return const CustomProgressIndicator();
                } else if (viewModel.state == ViewState.noInternet) {
                  return NoInternetWidget(
                    title: 'Anketiniz Yayınlanamadı...',
                    refresh: () async {
                      await viewModel.checkConnectivity();
                    },
                  );
                } else if (viewModel.state == ViewState.success) {
                  return const SurveySharedSuccessView();
                } else if (viewModel.questionEntityMap.isNotEmpty ||
                    viewModel.selectedSurveyImageBytes != null) {
                  if (Responsive.isMobile(context)) {
                    return _ShowAddedQuestionsTablet(
                      viewModel: viewModel,
                    );
                  } else {
                    return _ShowAddedQuestionsDesktop(
                      viewModel: viewModel,
                    );
                  }
                } else {
                  return const CustomErrorWidget(
                    title:
                        'Henüz soru oluşturmadınız! Soru eklemek için aşağıdaki butona tıklayın.',
                    iconData: Icons.insert_chart_outlined,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowAddedQuestionsDesktop extends StatelessWidget {
  final CreateSurveyViewModel viewModel;
  const _ShowAddedQuestionsDesktop({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = viewModel.selectedSurveyImageBytes != null
        ? viewModel.questionEntityMap.length + 1
        : viewModel.questionEntityMap.length;
    return MasonryGridView.count(
      crossAxisCount: Responsive.isTablet(context) ? 2 : 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0 && viewModel.selectedSurveyImageBytes != null) {
          return const _ShowAddedCoverImage();
        } else {
          final itemIndex =
              viewModel.selectedSurveyImageBytes != null ? index - 1 : index;
          final questionEntity =
              viewModel.questionEntityMap.keys.elementAt(itemIndex);
          final image = viewModel.questionEntityMap[questionEntity];
          return _AddedQuestionPreview(
            questionEntity: questionEntity,
            image: image,
          );
        }
      },
    );
  }
}

class _ShowAddedQuestionsTablet extends StatelessWidget {
  final CreateSurveyViewModel viewModel;

  const _ShowAddedQuestionsTablet({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = viewModel.selectedSurveyImageBytes != null
        ? viewModel.questionEntityMap.length + 1
        : viewModel.questionEntityMap.length;
    return ListView.builder(
      padding: context.paddingVertBottomXXlarge,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0 && viewModel.selectedSurveyImageBytes != null) {
          return Padding(
            padding: context.cPaddingSmall,
            child: const _ShowAddedCoverImage(),
          );
        } else {
          final itemIndex =
              viewModel.selectedSurveyImageBytes != null ? index - 1 : index;
          final questionEntity =
              viewModel.questionEntityMap.keys.elementAt(itemIndex);
          final image = viewModel.questionEntityMap[questionEntity];
          return Padding(
            padding: context.cPaddingSmall,
            child: _AddedQuestionPreview(
              questionEntity: questionEntity,
              image: image,
            ),
          );
        }
      },
    );
  }
}

class _ShowAddedCoverImage extends StatelessWidget {
  const _ShowAddedCoverImage();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateSurveyViewModel>();
    return Container(
      padding: context.cPaddingMedium,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: context.borderRadiusAllLow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 7,
                child: Text(
                  'Survey Cover Image',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
              Flexible(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    context.read<CreateSurveyViewModel>().resetSurveyImage();
                  },
                  child: const Icon(Icons.remove_circle_outline),
                ),
              ),
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          AspectRatio(
            aspectRatio: ImageAspectRatioEnum.questionImage.ratioCrop.ratioX /
                ImageAspectRatioEnum.questionImage.ratioCrop.ratioY,
            child: Container(
              decoration: CustomBoxDecoration.customBoxDecorationForImage(
                context,
              ),
              child: viewModel.selectedSurveyImageBytes != null
                  ? Image.memory(
                      viewModel.selectedSurveyImageBytes!,
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddedQuestionPreview extends StatelessWidget {
  const _AddedQuestionPreview({
    required this.questionEntity,
    required this.image,
  });

  final QuestionEntity questionEntity;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.cPaddingMedium,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: context.borderRadiusAllLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(questionEntity: questionEntity),
          SizedBox(height: context.dynamicHeight(0.01)),
          _QuestionImage(image: image),
          SizedBox(height: context.dynamicHeight(0.02)),
          _QuestionTitle(questionEntity: questionEntity),
          SizedBox(height: context.dynamicHeight(0.02)),
          _QuestionOptions(questionEntity: questionEntity),
          SizedBox(height: context.dynamicHeight(0.02)),
          _QuestionRules(questionEntity: questionEntity),
        ],
      ),
    );
  }
}
