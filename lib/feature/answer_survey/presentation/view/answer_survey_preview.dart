import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/export.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/presentation/mixin/answer_survey_view_mixin.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/presentation/viewmodel/answer_survey_view_model.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/product/export.dart';
part '../sub_view/answer_survey_preview_sub_view.dart';

class AnswerSurveyPreview extends StatefulWidget {
  final String? surveyId;

  const AnswerSurveyPreview({
    required this.surveyId,
    super.key,
  });

  @override
  State<AnswerSurveyPreview> createState() => _AnswerSurveyPreviewState();
}

class _AnswerSurveyPreviewState extends State<AnswerSurveyPreview>
    with SurveyPreviewMixin {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: !isMobile
              ? EdgeInsets.only(
                  top: ConstantSizes.xxLarge.value,
                  bottom: ConstantSizes.medium.value,
                )
              : context.paddingAllMedium,
          child: Row(
            children: [
              if (!isMobile) const Spacer(),
              Expanded(
                flex: isDesktop
                    ? 1
                    : isTablet
                        ? 2
                        : 1,
                child: const _SurveyInfo(),
              ),
              if (!isMobile) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SurveyInfo extends StatelessWidget {
  const _SurveyInfo();

  @override
  Widget build(BuildContext context) {
    return Consumer<AnswerSurveyViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.surveyEntity != null) {
          final surveyCoverImage = viewModel.surveyEntity?.surveyImageUrl;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PublisherInfo(),
              SizedBox(
                height: ConstantSizes.small.value,
              ),
              if (surveyCoverImage != null)
                _ShowSurveyCoverImage(
                  surveyCoverImage: surveyCoverImage,
                ),
              SizedBox(
                height: ConstantSizes.medium.value,
              ),
              Text(
                viewModel.surveyEntity?.surveyTitle ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              SizedBox(
                height: ConstantSizes.small.value,
              ),
              Text(
                maxLines: 5,
                viewModel.surveyEntity?.surveyDescription ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              SizedBox(
                height: ConstantSizes.medium.value,
              ),
              Wrap(
                children: [
                  _SurveyDetails(
                    icon: Icons.calendar_month,
                    title: '  Başlangıç Tarihi',
                    text:
                        viewModel.surveyEntity?.startDate?.toLocal().toString(),
                  ),
                  _SurveyDetails(
                    icon: Icons.calendar_month,
                    title: '  Bitiş Tarihi',
                    text: viewModel.surveyEntity?.endDate?.toLocal().toString(),
                  ),
                  _SurveyDetails(
                    icon: Icons.timer_outlined,
                    title: '  Yanıtlama Süresi',
                    text: viewModel.surveyEntity?.surveyTimeInMinute.toString(),
                  ),
                ],
              ),
              SizedBox(
                height: ConstantSizes.medium.value,
              ),
              Align(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryFixed,
                    fixedSize: const Size(160, 30),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ANSWER',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _SurveyDetails extends StatelessWidget {
  const _SurveyDetails({
    required this.icon,
    required this.text,
    required this.title,
  });
  final IconData icon;
  final String title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Text(
            text ?? 'Belirtilmemiş',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ],
      ),
    );
  }
}
