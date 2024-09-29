import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/localization/locale_constants.dart';
import 'package:flutter_survey_app_web/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_web/dependency_injection/dependency_injection.dart';
import 'package:flutter_survey_app_web/feature/create_survey/export.dart';
import 'package:flutter_survey_app_web/firebase_options.dart';
import 'package:flutter_survey_app_web/main.dart';

abstract class AppInit {
  Future<void> initialize();
  Future<void> run();
  Widget getApp();
}

class AppInitImpl extends AppInit {
  @override
  Widget getApp() {
    return EasyLocalization(
      supportedLocales: const [
        LocaleConstants.enLocale,
        LocaleConstants.trLocale,
        LocaleConstants.frLocale,
        LocaleConstants.arLocale,
        LocaleConstants.esLocale,
        LocaleConstants.deLocale,
        LocaleConstants.itLocale,
        LocaleConstants.ptLocale,
        LocaleConstants.zhLocale,
        LocaleConstants.jaLocale,
        LocaleConstants.ruLocale,
      ],
      path: LocaleConstants.localePath,
      fallbackLocale: LocaleConstants.enLocale,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeManager>(
            create: (context) => ThemeManager(),
          ),
          ChangeNotifierProvider<CreateSurveyViewModel>(
            create: (_) => serviceLocator<CreateSurveyViewModel>(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }

  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    setupLocator();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> run() async {
    await initialize();
    runApp(getApp());
  }
}
