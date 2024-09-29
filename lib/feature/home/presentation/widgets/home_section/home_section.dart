import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/routes/app_routes.dart';
import 'package:flutter_survey_app_web/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:flutter_survey_app_web/core/size/app_border_radius_extensions.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    required this.isMobile,
    super.key,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750,
      width: Responsive.getWidth(context),
      child: const Row(
        children: [
          Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 90,
            child: _BodyContent(),
          ),
          Spacer(
            flex: 10,
          ),
        ],
      ),
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Text(
            textAlign: TextAlign.center,
            'Capture Voices,\nUncover Trends',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 50,
            ),
          ),
        ),
        const SizedBox(height: 50),
        const Text(
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
          'Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.Formio ile dakikalar içinde anketinizi oluşturun, linki paylaşın ve anonim yanıtlar toplayın.Anket sonuçlarını zahmetsizce analiz edin ve daha iyi kararlar alın.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: context.cPaddingMedium,
            backgroundColor: Colors.transparent,
            shape: ContinuousRectangleBorder(
              borderRadius: context.borderRadiusAllLow,
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
            ),
          ),
          onPressed: () {
            NavigatorService.pushNamed(AppRoutes.createSurveyInfoView);
          },
          child: Text(
            'HEMEN OLUŞTUR',
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 50),
        Flexible(
          child: Image.asset(
            ImageEnums.webtest4.toPathPng,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
