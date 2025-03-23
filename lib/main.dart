import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:my_portfolio/core/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rohit Kumar - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}
