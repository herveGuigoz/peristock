part of '../theme.dart';

class Palette extends MaterialColor {
  const Palette(super.primary, super.swatch);

  const Palette.gray()
      : super(
          0xFF868687,
          const {
            50: Palette.gray50,
            100: Palette.gray100,
            200: Palette.gray200,
            300: Palette.gray300,
            400: Palette.gray400,
            500: Palette.gray500,
            600: Palette.gray600,
            700: Palette.gray700,
            800: Palette.gray800,
            900: Palette.gray900,
          },
        );

  static const Color gray50 = Color(0xFFf9fafb);
  static const Color gray100 = Color(0xFFF9F9F9);
  static const Color gray200 = Color(0xFFEAEAEA);
  static const Color gray300 = Color(0xFFD2D2D2);
  static const Color gray400 = Color(0xFF9ca3af);
  static const Color gray500 = Color(0xFF868687);
  static const Color gray600 = Color(0xFF4b5563);
  static const Color gray700 = Color(0xFF383838);
  static const Color gray800 = Color(0xFF1f2937);
  static const Color gray900 = Color(0xFF111827);
}
