import 'package:flutter/material.dart';

// defining colors
const COLOR_PRIMARY = Color(0XFF12519B);
const COLOR_ACCENT = Color(0XFFDCECFF);

// elevated button theme
ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding:
        const EdgeInsetsDirectional.symmetric(vertical: 18, horizontal: 60),
    elevation: 0.2,
    backgroundColor: COLOR_PRIMARY,
  ),
);

var lightThemeData = ThemeData(
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  useMaterial3: true,
  scaffoldBackgroundColor: COLOR_ACCENT,
  elevatedButtonTheme: elevatedButtonThemeData,
);
// ThemeData().copyWith(
//     primaryColor: const Color(0XFF12519B),
//     brightness: Brightness.light,
//     highlightColor: Colors.white,
//     useMaterial3: true,
//     scaffoldBackgroundColor: const Color(0XFFDCECFF));

var darkThemeData = ThemeData(
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.dark,
  highlightColor: Colors.black12,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  elevatedButtonTheme: elevatedButtonThemeData,
);
