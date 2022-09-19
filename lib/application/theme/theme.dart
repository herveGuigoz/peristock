import 'dart:ui' as ui show lerpDouble;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'data/colors.dart';
part 'light.dart';
part 'data/material.dart';
part 'data/radius.dart';
part 'data/spacing.dart';
part 'data/typography.dart';

final themeProvider = Provider<AppTheme>(
  (ref) => const LightTheme(palette: Palette.gray()),
  name: 'AppThemeProvider',
);

abstract class AppTheme {
  const AppTheme({
    required this.brightness,
    required this.radius,
    required this.spacing,
    required this.palette,
  });

  final Brightness brightness;
  final ThemeRadius radius;
  final Spacing spacing;
  final Palette palette;

  ThemeData get material;
}
