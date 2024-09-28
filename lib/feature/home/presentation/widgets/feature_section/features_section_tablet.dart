import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';
import 'package:flutter_survey_app_web/product/widgets/custom_primary_text_widget.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';

class FeaturesSectionTablet extends StatelessWidget {
  const FeaturesSectionTablet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConstantSizes.largePageHeight.value,
      width: Responsive.getWidth(context),
      alignment: Alignment.center,
      child: Padding(
        padding: context.cPaddingxxLarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: CustomPrimaryTextWidget(text: 'Öne Çıkan Özellikler'),
            ),
            ConstantSizes.xxLarge.heightSizedBox,
            _InfoArea(
              title: 'Anonim Yanıtlar',
              desc:
                  'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlı Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın Güvenilir ve\n anonim yanıtlar toplayarak doğru analiz yapın',
              imagePath: ImageEnums.webtest5.toPathPng,
            ),
            ConstantSizes.xLarge.heightSizedBox,
            _InfoArea(
              title: 'Kolay Paylaşım',
              desc:
                  'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlı  Anket linkinizi çalışanlarınıza veya hedef kitlenize e-posta,Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın  mesaj veya sosyal medya aracılığıyla kolayca gönderin.Anket linkinizi çalışanlarınıza veya hedef Anket linkinizi çalışanlarınıza veya hedef Anket linkinizi çalışanlarınıza veya hedef',
              imagePath: ImageEnums.webtest6.toPathPng,
            ),
            ConstantSizes.xLarge.heightSizedBox,
            _InfoArea(
              title: 'Anında Analiz',
              desc:
                  'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlı Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlıca aksiyon alın.Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın',
              imagePath: ImageEnums.webtest7.toPathPng,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoArea extends StatelessWidget {
  final String title;
  final String desc;
  final String imagePath;
  const _InfoArea({
    required this.desc,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Image.asset(
            imagePath,
            height: ConstantSizes.imageHeightMedium.value,
          ),
        ),
        ConstantSizes.xLarge.widthSizedBox,
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ConstantSizes.small.heightSizedBox,
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                textAlign: TextAlign.start,
                desc,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        )
      ],
    );
  }
}
