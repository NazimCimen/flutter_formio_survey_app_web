import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/config/theme/custom_color_sheme.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ApplicationTheme {
  ThemeData get themeData;
  ColorScheme get colorScheme;
}

/// Custom light theme for project design
final class CustomLightTheme implements ApplicationTheme {
  @override
  ColorScheme get colorScheme => CustomColorScheme.lightScheme;
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: CustomColorScheme.lightScheme,
        /* textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.surface,
          ),
        ),*/
      );
}

/// Custom Dark theme for project design
final class CustomDarkTheme implements ApplicationTheme {
  @override
  ColorScheme get colorScheme => CustomColorScheme.darkScheme;
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorScheme.darkScheme,
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: Colors.black,
      );
}
