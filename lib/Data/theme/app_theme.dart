import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      fontFamily: 'Manrope',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Manrope'),
        displayMedium: TextStyle(fontFamily: 'Manrope'),
        displaySmall: TextStyle(fontFamily: 'Manrope'),
        headlineLarge: TextStyle(fontFamily: 'Manrope'),
        headlineMedium: TextStyle(fontFamily: 'Manrope'),
        headlineSmall: TextStyle(fontFamily: 'Manrope'),
        titleLarge: TextStyle(fontFamily: 'Manrope'),
        titleMedium: TextStyle(fontFamily: 'Manrope'),
        titleSmall: TextStyle(fontFamily: 'Manrope'),
        bodyLarge: TextStyle(fontFamily: 'Manrope'),
        bodyMedium: TextStyle(fontFamily: 'Manrope'),
        bodySmall: TextStyle(fontFamily: 'Manrope'),
        labelLarge: TextStyle(fontFamily: 'Manrope'),
        labelMedium: TextStyle(fontFamily: 'Manrope'),
        labelSmall: TextStyle(fontFamily: 'Manrope'),
      ),
    );
  }
}
