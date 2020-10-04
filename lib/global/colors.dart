// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class FeelingsThemeData {
  static const _lightFillColor = Colors.black87;
  static const _darkFillColor = Colors.white70;

  static final Color _lightFocusColor =
      Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor =
      Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData =
      themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(
      ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        textTheme:
            _textTheme.apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle:
            _textTheme.subtitle1.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF448AFF),
    primaryVariant: Color(0xFF346ADF),
    secondary: Color(0xFF00B8D4),
    secondaryVariant: Color(0xFF0098A4),
    background: Color(0xFFF6F7F7),
    onBackground: Color(0xFF241E20),
    surface: Color(0xFFF0EFEF),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: Color(0xFF342E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF00B8D4),
    primaryVariant: Color(0xFF10E8F4),
    secondary: Color(0xFF448AFF),
    secondaryVariant: Color(0xFF64AAFF),
    background: Color(0xFF241E20),
    surface: Color(0xFF1F1920),
    onBackground: Color(0xFFF6F7F7),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: Color(0xFFCBCCCC),
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: TextStyle(fontWeight: _bold, fontSize: 20.0),
    caption: TextStyle(fontWeight: _semiBold, fontSize: 16.0),
    headline5: TextStyle(fontWeight: _medium, fontSize: 16.0),
    subtitle1: TextStyle(fontWeight: _medium, fontSize: 16.0),
    overline: TextStyle(fontWeight: _medium, fontSize: 12.0),
    bodyText1: TextStyle(fontWeight: _regular, fontSize: 14.0),
    subtitle2: TextStyle(fontWeight: _medium, fontSize: 14.0),
    bodyText2: TextStyle(fontWeight: _regular, fontSize: 16.0),
    headline6: TextStyle(fontWeight: _bold, fontSize: 16.0),
    button: TextStyle(fontWeight: _semiBold, fontSize: 14.0),
  );

  static ThemeData getTheme(String type) {
    switch (type) {
      case "dark":
        return darkThemeData;
      case "light":
        return lightThemeData;
    }
    return lightThemeData;
  }
}
