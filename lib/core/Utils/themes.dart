import 'package:bookia/core/Constants/AppFonts.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme() => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: Appfonts.DMSerifDisplay,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      onSurface: AppColors.dark,
    ),
    dividerTheme: DividerThemeData(color: AppColors.border),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.accent,
      filled: true,
      hintStyle: TextStyles.getSmall(),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.border),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );
}
