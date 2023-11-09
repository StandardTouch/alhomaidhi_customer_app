import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

// defining colors
const COLOR_PRIMARY = Color(0XFF12519B);
const COLOR_ACCENT = Color(0XFFDCECFF);

// elevated button theme
ElevatedButtonThemeData getElevatedButtonThemeData({required isDark}) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 18, horizontal: 60),
        elevation: 0.2,
        backgroundColor: COLOR_PRIMARY,
        // can change accordingly if asked.
        foregroundColor: isDark ? Colors.white : Colors.white),
  );
}

// add text theme
TextTheme getTextTheme({required bool isDark}) {
  return TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: isDark ? Colors.white : Colors.black,
      ));
}

// pinput themes
PinTheme getDefaultPinTheme(BuildContext context) {
  return PinTheme(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: COLOR_PRIMARY,
        width: 1,
      ),
    ),
    padding: const EdgeInsets.all(8),
    textStyle: getTextTheme(isDark: DeviceInfo.isDarkMode(context)).bodyMedium,
    width: 50,
    height: 50,
  );
}

PinTheme getSubmittedPinTheme(BuildContext context) {
  return getDefaultPinTheme(context).copyDecorationWith(
    border: Border.all(
      width: 1,
    ),
    color: COLOR_PRIMARY,
  );
}

var lightThemeData = ThemeData(
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  useMaterial3: true,
  scaffoldBackgroundColor: COLOR_ACCENT,
  elevatedButtonTheme: getElevatedButtonThemeData(isDark: false),
  textTheme: getTextTheme(isDark: false),
);

var darkThemeData = ThemeData(
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.dark,
  highlightColor: Colors.black,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  elevatedButtonTheme: getElevatedButtonThemeData(isDark: true),
  textTheme: getTextTheme(isDark: true),
);
