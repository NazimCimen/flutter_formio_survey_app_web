import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/product/widgets/custom_primary_text_widget.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';

class FeatureSectionMobile extends StatelessWidget {
  const FeatureSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.getWidth(context),
      child: Padding(
        padding: context.paddingAllMedium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstantSizes.xLarge.heightSizedBox,
            const CustomPrimaryTextWidget(text: 'Öne Çıkan Özellikler'),
            _InfoArea(
              title: 'Anonim Yanıtlar',
              desc:
                  'Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın',
              imagePath: ImageEnums.webtest5.toPathPng,
            ),
            _InfoArea(
              title: 'Kolay Paylaşım',
              desc:
                  'Anket linkinizi çalışanlarınıza veya hedef kitlenize e-posta,Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın  mesaj veya sosyal medya aracılığıyla kolayca gönderin.',
              imagePath: ImageEnums.webtest6.toPathPng,
            ),
            _InfoArea(
              title: 'Anında Analiz',
              desc:
                  'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlıca aksiyon alın.Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın',
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
    return Padding(
      padding: context.paddingAllXXlarge,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: ConstantSizes.imageHeightLarge.value,
          ),
          ConstantSizes.medium.heightSizedBox,
          Text(
            textAlign: TextAlign.center,
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ConstantSizes.small.heightSizedBox,
          Text(
            textAlign: TextAlign.center,
            desc,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
