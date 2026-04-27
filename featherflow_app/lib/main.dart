import 'package:flutter/material.dart';
import 'core/routes.dart';
import 'core/theme.dart';

void main() {
  runApp(const FeatherflowApp());
}

class FeatherflowApp extends StatelessWidget {
  const FeatherflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}