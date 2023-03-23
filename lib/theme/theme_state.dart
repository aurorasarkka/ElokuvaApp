import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart';

enum ThemeStateEnum { light, dark, amoled }

class ThemeState extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  ThemeData _themeData = kDarkTheme;

  ThemeData get themeData => _themeData;
  set themeData(ThemeData val) {
    _themeData = val;
    notifyListeners();
  }
ThemeStateEnum _getOption() {
    int option = _sharedPreferences?.get('theme_option') as int? ?? 1;
    return ThemeStateEnum.values[option];
  }

  void setDarkTheme() {}
}
