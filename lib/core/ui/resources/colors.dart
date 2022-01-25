import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppColorsData {
  factory AppColorsData.fromBrightness(Brightness brightness) {
    if (brightness == Brightness.light) {
      return LightAppColorsData();
    } else {
      throw UnimplementedError('AppColors for $brightness not implemented');
    }
  }

  String get tag;

  MaterialColor get primaryMaterialColor;

  Color get primary;

  Color get buttonsPrimary;

  Color get buttonsPrimarySecondary;

  Color get textPrimary;

  Color get shadow;

  Color get activeBottomItem;

  Color get inactiveBottomItem;

  Color get border;

  Color get daysColor;

  Color get personTypeDescription;

  Color get mainBackground;
}

class LightAppColorsData implements AppColorsData {
  const LightAppColorsData();

  String get tag => 'light';

  Color get primary => const Color(0xFF8D88F2);

  MaterialColor get primaryMaterialColor => MaterialColor(0xFFFFFFFF, _getSwatch(primary));

  Color get buttonsPrimary => const Color(0xFFFFB301);

  Color get buttonsPrimarySecondary => const Color(0xFF8D88F2);

  Color get textPrimary => const Color(0xFF121212);

  Color get shadow => const Color(0xFFCDCDCD).withOpacity(0.5);

  Color get activeBottomItem => const Color(0xFF121212);

  Color get inactiveBottomItem => const Color(0xFFC4C6CA);

  Color get border => const Color(0xFFE7E7E7);

  Color get daysColor => const Color(0xFF5B636C);

  Color get personTypeDescription => const Color(0xFFA1A4A9);

  Color get mainBackground => const Color(0xFFFFFFFF);
}

class AppColors extends InheritedWidget {
  AppColors({
    Key? key,
    Brightness brightness = Brightness.light,
    required Widget child,
  })  : colors = AppColorsData.fromBrightness(brightness),
        super(key: key, child: child);

  static AppColorsData of(BuildContext context) {
    final AppColors? result = context.dependOnInheritedWidgetOfExactType<AppColors>();
    assert(result != null, 'No AppColorsProvider found in context');
    return result!.colors;
  }

  final AppColorsData colors;

  @override
  bool updateShouldNotify(AppColors old) => old.colors.tag == colors.tag;
}

extension AppColorsExtension on BuildContext {
  AppColorsData get colors {
    return AppColors.of(this);
  }
}

Map<int, Color> _getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}