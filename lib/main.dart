import 'package:flutter/material.dart';
import 'app/app_router.dart';
import 'app/app_theme.dart';

void main() => runApp(const ModyAiApp());

class ModyAiApp extends StatelessWidget {
  const ModyAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mody AI — UI Only',
      theme: AppTheme.dark,
      routerConfig: AppRouter.config,
    );
  }
}
