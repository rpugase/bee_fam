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
        backgroundColor: MaterialStateProperty.all<Color>(context.colors.primary),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 15.0,
            fontFamily: AppFonts.sfProText,
          ),
        ),
        shape: MaterialStateProperty.all(
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
      headline5: TextStyle(
        fontSize: 24,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600,
      ),
      headline6: TextStyle(
        fontSize: 18,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        fontFamily: AppFonts.sfProText,
      ),
      bodyText1: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.sfProText,
        fontWeight: FontWeight.w600,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontFamily: AppFonts.sfProText,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
