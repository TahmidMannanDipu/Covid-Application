import 'package:covid_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'Service/app_theme/app_color/app_color.dart';
import 'Service/app_theme/text_theme/text_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColor.themeColor,
        brightness: Brightness.dark, // Dark mode

        //// Text Theme
        textTheme: TextTheme(
            bodySmall: AppText.regular18,
            bodyMedium: AppText.bold25,
            titleMedium: AppText.bold16),

        //// Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.themeColor,
            foregroundColor: Colors.white, // Text color
            fixedSize: Size(
                double.maxFinite, MediaQuery.of(context).size.height * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: AppText.bold16,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),

        //// AppBar Theme
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColor.themeColor,
          titleTextStyle: AppText.bold22,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),

      //// Set Home Screen
      home: const SplashScreen(),
    );
  }
}
