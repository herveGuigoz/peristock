part of 'theme.dart';

class LightTheme extends AppTheme with _MaterialThemeMixin {
  const LightTheme({
    super.radius = const ThemeRadius(),
    super.spacing = const Spacing(),
    required super.palette,
  }) : super(brightness: Brightness.light);
}
