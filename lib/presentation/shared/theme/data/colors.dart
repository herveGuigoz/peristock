part of '../theme.dart';

class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.primaryContainer,
    required this.secondaryContainer,
  });

  const Palette.light({
    this.primary = const Color(0xFF0E1114),
    this.secondary = const Color(0xFF616C76),
    this.tertiary = const Color(0xFF8FA0AF),
    this.primaryContainer = const Color(0xFF181C20),
    this.secondaryContainer = const Color(0xFF0E1114),
  });

  const Palette.dark({
    this.primary = const Color(0xFFEEF1F4),
    this.secondary = const Color(0xFFABBBC9),
    this.tertiary = const Color(0xFF778592),
    this.primaryContainer = const Color(0xFF181C20),
    this.secondaryContainer = const Color(0xFF0E1114),
  });

  final Color primary;

  final Color secondary;

  final Color tertiary;

  final Color primaryContainer;

  final Color secondaryContainer;

  @override
  ThemeExtension<Palette> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? primaryContainer,
    Color? secondaryContainer,
  }) {
    return Palette(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
    );
  }

  @override
  ThemeExtension<Palette> lerp(ThemeExtension<Palette>? other, double t) {
    if (other is! Palette) {
      return this;
    }

    return Palette(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      secondaryContainer: Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
    );
  }
}
