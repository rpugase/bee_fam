import 'package:birthday_gift/core/ui/resources/colors.dart';
import 'package:birthday_gift/core/ui/resources/fonts.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ThemeData AppThemeData(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: context.colors.primary,
      onPrimary: context.colors.textPrimary,
      secondary: context.colors.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(context.colors.primary),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 15.0,
            fontFamily: AppFonts.sfProText,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: context.colors.textPrimary,
        fontSize: 16.0,
        fontFamily: AppFonts.sfProText,
      ),
      floatingLabelStyle: TextStyle(
        color: context.colors.primary,
        fontSize: 14.0,
        fontFamily: AppFonts.sfProText,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: context.colors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: context.colors.primary,
        ),
      ),
      hintStyle: const TextStyle(
        fontSize: 16.0,
        fontFamily: AppFonts.sfProText,
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: AppFonts.sfProText,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.sfProText,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
