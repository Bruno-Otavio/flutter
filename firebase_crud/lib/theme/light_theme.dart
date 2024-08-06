import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey.shade700,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade700,
    )
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade100,
    secondary: Colors.grey.shade300,
    tertiary: Colors.grey.shade700,
  )
);
