import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_web/config/routes/app_routes.dart';
import 'package:flutter_survey_app_web/config/routes/navigator_service.dart';
import 'package:flutter_survey_app_web/config/theme/application_theme.dart';
import 'package:flutter_survey_app_web/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_web/core/init/app_init.dart';
import 'package:flutter_survey_app_web/feature/answer_survey/answer_survey_view.dart';
import 'package:flutter_survey_app_web/feature/home/presentation/view/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  final appInit = AppInitImpl();
  await appInit.run();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, provider, child) => MaterialApp(
        title: StringConstants.appName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: CustomDarkTheme().themeData,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigatorService.navigatorKey,
        routes: AppRoutes.routes,
        onGenerateRoute: (settings) {
          final uri = Uri.parse(settings.name ?? '');
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'answer-survey') {
            final surveyId = uri.queryParameters['surveyId'];
            if (surveyId != null) {
              return MaterialPageRoute(
                builder: (context) => AnswerSurveyView(surveyId: surveyId),
                settings: settings,
              );
            }
          }
          return null;
        },
        onGenerateInitialRoutes: (initialRouteName) {
          final uri = Uri.base;
          final surveyId = uri.queryParameters['surveyId'];
          if (surveyId != null) {
            return [
              MaterialPageRoute(
                builder: (context) => AnswerSurveyView(surveyId: surveyId),
                settings: const RouteSettings(name: '/answer-survey'),
              ),
            ];
          }
          return [
            MaterialPageRoute(
              builder: (context) => const HomeView(),
              settings: const RouteSettings(name: '/navBarView'),
            )
          ];
        },
        initialRoute: AppRoutes.initialRoute,
        // home: CreateQuestionsView(),
      ),
    );
  }
}
