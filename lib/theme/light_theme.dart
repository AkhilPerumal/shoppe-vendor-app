import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xFFf7d417),
  // primaryColor: Colors.amber,
  secondaryHeaderColor: Color(0xFF4B4B4D),
  disabledColor: Color(0xFFA0A4A8),
  errorColor: Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(
      primary: Color(0xFFFbdb04), secondary: Color(0xFFfbc204)),
  textButtonTheme:
      TextButtonThemeData(style: TextButton.styleFrom(primary: Colors.amber)),
);
