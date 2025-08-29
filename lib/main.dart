import 'package:flutter/material.dart';

import 'app/app_router.dart';

void main() => runApp(const ModyAiApp());

class AppColors {
  static const background = Color(0xFF0B0B0F);
  static const surface = Color(0xFF121318);
  static const border = Color(0x22FFFFFF);
  static const primary = Color(0xFFFF1744);
  static const primaryVariant = Color(0xFFFF4A68);
  static const text = Colors.white;
}

class ModyAiApp extends StatelessWidget {
  const ModyAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mody AI — UI Only',
      theme: theme,
      routerConfig: AppRouter.config,
    );
  }
}
