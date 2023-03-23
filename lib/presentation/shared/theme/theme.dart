import 'dart:ui' as ui show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'data/colors.dart';
part 'data/material.dart';
part 'data/radius.dart';
part 'data/spacing.dart';
part 'data/typography.dart';

final themeProvider = Provider((_) => const LightTheme());

abstract class AppTheme {
  const AppTheme({
    required this.radius,
    required this.spacing,
    required this.colorScheme,
    required this.appBarIconColor,
    required this.tabLabelColor,
    required this.tabUnselectedLabelColor,
    required this.bottomNavigationBarUnselectedColor,
  });

  /// The radius values for the application.
  final ThemeRadius radius;

  /// The spacing values for the application.
  final Spacing spacing;

  /// The color scheme for the application.
  final ColorScheme colorScheme;

  /// The color of the app bar's icon.
  final Color appBarIconColor;

  /// The color of the tab bar's selected label.
  final Color tabLabelColor;

  /// The color of the tab bar's unselected label.
  final Color tabUnselectedLabelColor;

  /// The color of the bottom navigation bar's unselected item.
  final Color bottomNavigationBarUnselectedColor;

  ThemeData get materialTheme;
}

class LightTheme extends AppTheme with MaterialThemeMixin {
  const LightTheme({
    super.radius = const ThemeRadius(),
    super.spacing = const Spacing(),
    super.colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFC80C0F),
      onPrimary: Color(0XFFFFFFFF),
      secondary: Color(0xFFD75053),
      onSecondary: Color(0XFFFFFFFF),
      tertiary: Palette.gray700,
      onTertiary: Color(0XFFFFFFFF),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      onBackground: Palette.gray700,
      surface: Palette.gray100,
      onSurface: Palette.gray700,
    ),
    super.appBarIconColor = Palette.gray500,
    super.tabLabelColor = const Color(0xFF272728),
    super.tabUnselectedLabelColor = Palette.gray300,
    super.bottomNavigationBarUnselectedColor = Palette.gray500,
  });
}
