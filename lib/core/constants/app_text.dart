import 'package:flutter/material.dart';

class AppText {
  static const title = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
  static const subtitle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static TextTheme get textTheme => const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
  );
}
