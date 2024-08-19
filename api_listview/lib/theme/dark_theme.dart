import 'package:flutter/material.dart';

class DarkTheme {
  final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 202, 202, 202),
      surface: Color(0xFF050505),
    ),
  );
}