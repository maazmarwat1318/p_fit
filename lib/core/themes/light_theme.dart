import 'package:flutter/material.dart';

class LightTheme {
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
    ),
    useMaterial3: true,
  );
}
