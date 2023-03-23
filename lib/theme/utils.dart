// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';



final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: const Color(0xff242248),
    accentColor: const Color(0xff8468DD),
    canvasColor: Colors.transparent,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headline5: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 24),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16),
      caption: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14),
    ),
  );
}

