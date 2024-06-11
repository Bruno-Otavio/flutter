import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF006989),
        onSecondary: const Color(0xFF005C78),
        surface: const Color(0xFFF3F7EC),
        onTertiary: const Color(0xFFE88D67),
      ),
      useMaterial3: true,

      appBarTheme: const AppBarTheme(
        color: Color(0xFFE88D67),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF3F7EC),
        ) 
      ),

      scaffoldBackgroundColor: const Color(0xFFF3F7EC),

      fontFamily: 'Poppings'
    );
  }
}