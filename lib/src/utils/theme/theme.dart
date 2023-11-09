import 'package:flutter/material.dart';

// defining colors
const COLOR_PRIMARY = Color(0XFF12519B);
const COLOR_ACCENT = Color(0XFFDCECFF);
final BoxShadow cardBoxShadow =
    BoxShadow(color: Colors.black38, blurRadius: 0.1, spreadRadius: 1);

// elevated button theme
ElevatedButtonThemeData setElevatedButtonThemeData({required bool isDark}) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 60),
        elevation: 0.2,
        backgroundColor: COLOR_PRIMARY,
        foregroundColor: isDark ? Colors.white : Colors.white),
  );
}

// add text theme
TextTheme textTheme = TextTheme(
  headlineMedium: TextStyle(fontWeight: FontWeight.bold),
);

var lightThemeData = ThemeData(
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  useMaterial3: true,
  scaffoldBackgroundColor: COLOR_ACCENT,
  elevatedButtonTheme: setElevatedButtonThemeData(isDark: false),
  textTheme: textTheme,
);

var darkThemeData = ThemeData(
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.dark,
  highlightColor: Colors.black,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  elevatedButtonTheme: setElevatedButtonThemeData(isDark: true),
  textTheme: textTheme,
);
