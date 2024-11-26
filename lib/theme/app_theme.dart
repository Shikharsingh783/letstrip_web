import 'package:flutter/material.dart';
import 'package:letstrip/theme/color_scheme.dart';

class AppTheme {
  ///light theme for the app
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      colorScheme: AppColorScheme.lightColorScheme);

  ///dark theme for the app
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.white,
      colorScheme: AppColorScheme.darkColorScheme);
}
