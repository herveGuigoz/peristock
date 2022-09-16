part of 'theme.dart';

extension ThemeExtensionsProvider on ThemeData {
  Spacing get spacing => extension<Spacing>()!;
  ThemeRadius get radius => extension<ThemeRadius>()!;
}

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
}

class LightTheme extends AppTheme with _MaterialThemeMixin {
  const LightTheme({
    super.radius = const ThemeRadius(),
    super.spacing = const Spacing(),
    required super.palette,
  }) : super(brightness: Brightness.light);
}

mixin _MaterialThemeMixin on AppTheme {
  ThemeData get material {
    final isDark = brightness == Brightness.dark;
    final onPrimaryColor = isDark ? palette.shade50 : palette.shade900;

    return ThemeData(
      scaffoldBackgroundColor: Palette.gray50,
      appBarTheme: AppBarTheme(
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: palette.shade50,
        iconTheme: IconThemeData(
          color: onPrimaryColor,
        ),
        titleTextStyle: TitleTextStyle(
          color: onPrimaryColor,
        ),
      ),
      brightness: brightness,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: palette,
        errorColor: Palette.red500,
      ),
      extensions: [radius, spacing],
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.shade50,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: palette.shade100),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: palette.shade100),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: palette.shade100),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: palette.shade300),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Palette.red500,
          ),
          borderRadius: BorderRadius.all(radius.regular),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: palette.shade600,
          foregroundColor: palette.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radius.regular),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Palette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radius.regular),
        ),
      ),
    );
  }
}
