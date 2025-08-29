import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text.dart';

class AppTheme {
  static const _primary = Color(0xFF6C5CE7);
  static const _bgDark = Color(0xFF0B0F16);

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bgLight,
        textTheme: AppText.textTheme,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: _bgDark,
        colorScheme: const ColorScheme.dark(primary: _primary),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      );
}
