import 'package:flutter/material.dart';

class CustomTheme {
  final Color lightPrimaryColor = const Color(0xFFFF8080); 
  final Color secondaryColor = const Color(0xFFF6FDC3);
  final Color accentColor = const Color(0xFFFFCF96);
  final Color surfaceColor = const Color(0xFFCDFAD5);

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _customTheme.lightPrimaryColor,
      secondary: _customTheme.secondaryColor,
      surface: _customTheme.surfaceColor,
      tertiary: _customTheme.accentColor,
    )
  );

  static ThemeData darkTheme = ThemeData(

  );
}

CustomTheme _customTheme = CustomTheme();
