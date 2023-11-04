import 'package:flutter/material.dart';

var lightThemeData = ThemeData().copyWith(
    primaryColor: const Color(0XFF12519B),
    brightness: Brightness.light,
    highlightColor: const Color(0XFFDCECFF),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white);

var darkThemeData = ThemeData().copyWith(
    primaryColor: const Color(0XFF12519B),
    brightness: Brightness.dark,
    highlightColor: const Color(0XFFDCECFF),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black);
