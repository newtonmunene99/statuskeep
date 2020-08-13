import 'package:flutter/material.dart';

final _ligloOrange = Colors.orange;

const _ligloBlack = MaterialColor(
  4280361249,
  {
    50: Color(0xfff2f2f2),
    100: Color(0xffe6e6e6),
    200: Color(0xffcccccc),
    300: Color(0xffb3b3b3),
    400: Color(0xff999999),
    500: Color(0xff808080),
    600: Color(0xff666666),
    700: Color(0xff4d4d4d),
    800: Color(0xff333333),
    900: Color(0xff191919)
  },
);

/// Dark Theme
final ThemeData darkTheme = ThemeData(
  primarySwatch: _ligloBlack,
  brightness: Brightness.dark,
  primaryColor: const Color(0xff000000),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: const Color(0xff9e9e9e),
  primaryColorDark: const Color(0xff000000),
  accentColor: _ligloOrange,
  accentColorBrightness: Brightness.light,
  disabledColor: const Color(0x62ffffff),
);

/// Light Theme
final ThemeData lightTheme = ThemeData(
  primarySwatch: _ligloOrange,
  brightness: Brightness.light,
  primaryColor: _ligloOrange,
  primaryColorBrightness: Brightness.light,
  primaryColorLight: const Color(0xffffe0b2),
  primaryColorDark: const Color(0xfff57c00),
  accentColor: _ligloOrange,
  accentColorBrightness: Brightness.light,
  disabledColor: const Color(0xff999999),
);
