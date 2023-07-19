import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 41, 41, 41),
    surface: Color(0xFF121212),
    primary: Color.fromARGB(255, 32, 20, 255),
    secondary: Color.fromARGB(255, 20, 255, 231),
    tertiary: Color.fromARGB(255, 106, 106, 106),
  ),
);
