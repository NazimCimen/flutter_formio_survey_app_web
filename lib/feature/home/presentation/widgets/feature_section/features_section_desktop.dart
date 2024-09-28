import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/product/widgets/custom_primary_text_widget.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';

class FeaturesSectionDesktop extends StatelessWidget {
  const FeaturesSectionDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConstantSizes.largePageHeight.value,
      width: Responsive.getWidth(context),
      alignment: Alignment.center,
      child: Padding(
        padding: context.cPaddingSmall,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstantSizes.large.heightSizedBox,
            const Flexible(
              child: CustomPrimaryTextWidget(text: 'Öne Çıkan Özellikler'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoArea(
                  title: 'Anonim Yanıtlar',
                  desc:
                      'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlı Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın Güvenilir ve\n anonim yanıtlar toplayarak doğru analiz yapın',
                  imagePath: ImageEnums.webtest5.toPathPng,
                ),
                _InfoArea(
                  title: 'Kolay Paylaşım',
                  desc:
                      'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlı  Anket linkinizi çalışanlarınıza veya hedef kitlenize e-posta,Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın  mesaj veya sosyal medya aracılığıyla kolayca gönderin.Anket linkinizi çalışanlarınıza veya hedef Anket linkinizi çalışanlarınıza veya hedef Anket linkinizi çalışanlarınıza veya hedef',
                  imagePath: ImageEnums.webtest6.toPathPng,
                ),
                _InfoArea(
                  title: 'Anında Analiz',
                  desc:
                      'Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlı Gerçek zamanlı yanıtlar ve detaylı analizlerle hızlıca aksiyon alın.Güvenilir ve anonim yanıtlar toplayarak doğru analiz yapın',
                  imagePath: ImageEnums.webtest7.toPathPng,
                ),
              ],
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
    return Expanded(
      child: Padding(
        padding: context.cPaddingxxLarge,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: ConstantSizes.imageHeightMedium.value,
            ),
            ConstantSizes.large.heightSizedBox,
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ConstantSizes.large.heightSizedBox,
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 14,
              textAlign: TextAlign.center,
              desc,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
