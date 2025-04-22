import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology_app/core/themes/app_theme.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();
    return GetMaterialApp(
      title: 'Logiology',
      theme: appTheme.themeData.copyWith(
        textTheme: appTheme.textTheme,
      ),
      // initialRoute: AppRoutes.login,
      initialRoute: AppRoutes.home,//for testing homepage

      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}