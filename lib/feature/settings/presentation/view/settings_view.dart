import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/localization/string_constanrs.dart';
import 'package:flutter_survey_app_web/config/theme/theme_manager.dart';
import 'package:flutter_survey_app_web/core/size/dynamic_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/feature/settings/presentation/atomic_widgets/settings_option_widget.dart';
import 'package:flutter_survey_app_web/feature/settings/presentation/components/language/language_sheet_widget.dart';
import 'package:flutter_survey_app_web/feature/settings/presentation/components/theme/theme_card_widget.dart';
import 'package:provider/provider.dart';

/*class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends SettingsBase<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      padding: context.paddingAllLow,
      children: [
        if (context.watch<ThemeManager>().isLoadingTheme)
          LinearProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        SizedBox(
          height: context.dynamicHeight(0.35),
          child: const ThemeCardWidget(),
        ),
        SettingsOptionWidget(
          icon: Icons.language,
          text: StringConstants.language,
          onTap: () {
            _showLanguageModalBottomSheet(context);
          },
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(StringConstants.settings),
    );
  }

  void _showLanguageModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const LanguageSheetWidget();
      },
    );
  }
}

abstract class SettingsBase<T extends StatefulWidget> extends State<T> {
  void changeLanguage(Locale locale) {
    context.setLocale(locale);
    setState(() {});
  }

  bool isDarkMode = false;

  void changeTheme(bool value, ThemeManager provider, ThemeEnum theme) {
    setState(() {
      isDarkMode = value;
      provider.changeTheme(theme);
    });
  }
}
*/