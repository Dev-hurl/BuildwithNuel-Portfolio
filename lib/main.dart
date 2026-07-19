import 'package:buildwithnuel/core/constants/app_colors.dart';
import 'package:buildwithnuel/core/constants/app_fonts.dart';
import 'package:buildwithnuel/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Buildwithnuel - Flutter Developer & UX/UI Designer',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      routerConfig: appRouter,
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontFamily: AppFonts.heading,
          fontWeight: AppFonts.headingWeight,
          fontSize: AppFonts.headingSize,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: AppFonts.heading,
          fontWeight: AppFonts.titleWeight,
          fontSize: AppFonts.titleSize,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: AppFonts.body,
          fontWeight: AppFonts.subheadingWeight,
          fontSize: AppFonts.subheadingSize,
          color: AppColors.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppFonts.heading,
          fontWeight: AppFonts.subheadingWeight,
          fontSize: AppFonts.bodySize,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        labelLarge: TextStyle(
          fontFamily: AppFonts.heading,
          fontWeight: AppFonts.headingWeight,
          fontSize: AppFonts.bodySize,
          color: AppColors.textSecondary,
        ),
        labelMedium: TextStyle(
          fontFamily: AppFonts.body,
          fontWeight: AppFonts.captionWeight,
          fontSize: AppFonts.smallSize,
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontFamily: AppFonts.heading,
          fontWeight: FontWeight.normal,
          fontSize: AppFonts.smallSize,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
