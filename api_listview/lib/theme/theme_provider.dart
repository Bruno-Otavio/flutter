import 'package:api_listview/theme/dark_theme.dart';
import 'package:api_listview/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _theme = LightTheme().theme;

  ThemeData get theme => _theme;

  set theme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_theme == LightTheme().theme) {
      theme = DarkTheme().theme;
    } else {
      theme = LightTheme().theme;
    }
  }
}