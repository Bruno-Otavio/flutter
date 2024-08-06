import 'package:flutter/material.dart';

ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey.shade300,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade300,
    )
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade600,
    tertiary: Colors.grey.shade300,
  ),
);

