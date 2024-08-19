import 'package:flutter/material.dart';

class LightTheme {
  final ThemeData _theme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF787878),
      surface: Color(0xFFF5F5F5),
    ),
  );

  ThemeData get theme => _theme;
}
