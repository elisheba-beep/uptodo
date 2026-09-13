import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness, Color bgColor) {
  return ThemeData(
    brightness: brightness,
    fontFamily: 'Lato', 
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
