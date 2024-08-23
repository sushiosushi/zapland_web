import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorSchemeSeed: const Color(0xffFFEA2C),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffE6E6E6),
    foregroundColor: Color(0xff000000),
  ),
  fontFamily: 'CarterOne',
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  colorSchemeSeed: const Color(0xffFFD53C),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff2E2E2E),
    foregroundColor: Color(0xffFFFFFF),
  ),
  fontFamily: 'CarterOne',
  brightness: Brightness.dark,
);
