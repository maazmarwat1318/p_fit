import 'package:flutter/material.dart';

class DarkTheme {
  static final data = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurpleAccent,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
