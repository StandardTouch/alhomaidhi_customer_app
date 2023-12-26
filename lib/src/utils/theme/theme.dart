import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

// defining colors
const COLOR_PRIMARY = Color(0XFF12519B);
const COLOR_ACCENT = Color(0XFFDCECFF);
const COLOR_SECONDARY = Color(0XFFFFB800);

// elevated button theme
ElevatedButtonThemeData getElevatedButtonThemeData({required isDark}) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 18,
          horizontal: 60,
        ),
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
    ),
    bodyLarge: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    labelLarge: const TextStyle(color: Colors.black, fontSize: 16),
    labelMedium: const TextStyle(color: Colors.grey, fontSize: 16),
  );
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
    textStyle: getTextTheme(isDark: true).bodyMedium!,
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

const AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
);

TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: IconButton.styleFrom(
  foregroundColor: Colors.black,
));

const PopupMenuThemeData popupMenuTheme = PopupMenuThemeData(
  surfaceTintColor: Colors.white,
);

const FloatingActionButtonThemeData floatingButtonTheme =
    FloatingActionButtonThemeData(
  backgroundColor: COLOR_PRIMARY,
  foregroundColor: Colors.white,
);

var lightThemeData = ThemeData(
  colorScheme:
      const ColorScheme.light(error: Colors.red, onSecondary: COLOR_SECONDARY),
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  useMaterial3: true,
  scaffoldBackgroundColor: COLOR_ACCENT,
  elevatedButtonTheme: getElevatedButtonThemeData(isDark: false),
  textTheme: getTextTheme(isDark: false),
  textButtonTheme: textButtonThemeData,
  appBarTheme: appBarTheme,
  popupMenuTheme: popupMenuTheme,
  floatingActionButtonTheme: floatingButtonTheme,
);

var darkThemeData = ThemeData(
  colorScheme:
      const ColorScheme.dark(error: Colors.red, onSecondary: COLOR_SECONDARY),
  primaryColor: COLOR_PRIMARY,
  brightness: Brightness.dark,
  highlightColor: Colors.black,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  elevatedButtonTheme: getElevatedButtonThemeData(isDark: true),
  textTheme: getTextTheme(isDark: true),
  textButtonTheme: textButtonThemeData,
  appBarTheme: appBarTheme,
  popupMenuTheme: popupMenuTheme,
  floatingActionButtonTheme: floatingButtonTheme,
);
