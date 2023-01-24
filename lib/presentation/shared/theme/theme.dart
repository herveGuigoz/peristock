import 'dart:ui' as ui show lerpDouble;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'data/colors.dart';
part 'data/radius.dart';
part 'data/spacing.dart';
part 'theme.freezed.dart';

final themeProvider = StateProvider<AppTheme>(
  (ref) => const AppTheme.light(),
);

@freezed
class AppTheme with _$AppTheme {
  const factory AppTheme.light({
    @Default(Palette.light()) Palette palette,
    @Default(Spacing()) Spacing spacing,
    @Default(ThemeRadius()) ThemeRadius radius,
  }) = LightTheme;

  const factory AppTheme.dark({
    @Default(Palette.dark()) Palette palette,
    @Default(Spacing()) Spacing spacing,
    @Default(ThemeRadius()) ThemeRadius radius,
  }) = DarkTheme;
}

final themeDataProvider = Provider<ThemeData>((ref) {
  final theme = ref.watch(themeProvider);

  return theme.map(
    light: (value) => FlexThemeData.light(
      extensions: [theme.palette, theme.spacing, theme.radius],
      useMaterial3: true,
      colors: FlexSchemeColor(
        primary: theme.palette.primary,
        secondary: theme.palette.primary,
        tertiary: theme.palette.tertiary,
        primaryContainer: theme.palette.primaryContainer,
        secondaryContainer: theme.palette.secondaryContainer,
      ),
      subThemesData: FlexSubThemesData(
        defaultRadius: theme.radius.small.x,
      ),
    ),
    dark: (value) => FlexThemeData.dark(
      extensions: [theme.palette, theme.spacing, theme.radius],
      useMaterial3: true,
      colors: FlexSchemeColor(
        primary: theme.palette.primary,
        secondary: theme.palette.primary,
        tertiary: theme.palette.tertiary,
        primaryContainer: theme.palette.primaryContainer,
        secondaryContainer: theme.palette.secondaryContainer,
      ),
      subThemesData: FlexSubThemesData(
        defaultRadius: theme.radius.small.x,
      ),
    ),
  );
});

extension ThemeExtensionsProvider on ThemeData {
  Palette get palette => extension<Palette>()!;
  Spacing get spacing => extension<Spacing>()!;
  ThemeRadius get radius => extension<ThemeRadius>()!;
}
