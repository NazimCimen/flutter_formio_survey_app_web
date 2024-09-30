import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';

class UseCaseSectionDesktop extends StatelessWidget {
  const UseCaseSectionDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.getWidth(context),
      child: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Kullanım Alanları',
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const _TextRich(
                          title: 'Kullanım Alanları',
                          description:
                              ' : Çalışanlarınızdan geri bildirim alın.Çalışanlarınızdan geri bildirim alın.',
                        ),
                        const SizedBox(height: 20),
                        const _TextRich(
                          title: 'Müşteri Memnuniyeti',
                          description: ' : Müşteri deneyimlerini ölçün.',
                        ),
                        const SizedBox(height: 20),
                        const _TextRich(
                          title: 'Pazar Araştırması',
                          description:
                              ' : Hedef kitlenizden değerli içgörüler elde edin.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Flexible(
                    child: Image.asset(
                  ImageEnums.webtest8.toPathPng,
                )),
              ],
            ),
            const SizedBox(height: 200)
          ],
        ),
      ),
    );
  }
}

class _TextRich extends StatelessWidget {
  final String title;
  final String description;
  const _TextRich({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 26,
        ),
        children: [
          TextSpan(
            text: description,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        ],
      ),
    );
  }
}
