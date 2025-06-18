import 'package:bookia/core/Utils/themes.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.routers,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme(),
    );
  }
}
