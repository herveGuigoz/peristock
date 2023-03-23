part of '../theme.dart';

extension ThemeExtensionsProvider on ThemeData {
  Spacing get spacing => extension<Spacing>()!;
  ThemeRadius get radius => extension<ThemeRadius>()!;
}

mixin MaterialThemeMixin on AppTheme {
  @override
  ThemeData get materialTheme {
    final inversedBrightness = colorScheme.brightness.inversed;

    return ThemeData(
      extensions: [radius, spacing],
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: ManropeTextStyle(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: ManropeTextStyle(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.all(spacing.big),
        iconColor: colorScheme.onSurface,
        prefixIconColor: colorScheme.onSurface,
        filled: true,
        fillColor: colorScheme.surface,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error),
          borderRadius: BorderRadius.all(radius.regular),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(radius.regular),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(radius.regular),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(radius.regular),
        ),
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      fontFamily: 'Manrope',
      textTheme: const TextTheme(titleMedium: ManropeTextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      appBarTheme: AppBarTheme(
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: appBarIconColor),
        centerTitle: true,
        titleTextStyle: ManropeTextStyle(color: colorScheme.primary, fontSize: 16, fontWeight: FontWeight.w600),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: colorScheme.background,
          systemNavigationBarIconBrightness: inversedBrightness,
          systemNavigationBarContrastEnforced: false,
          statusBarColor: Colors.transparent,
          statusBarBrightness: colorScheme.brightness,
          statusBarIconBrightness: inversedBrightness,
          systemStatusBarContrastEnforced: false,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.background,
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: bottomNavigationBarUnselectedColor,
        selectedLabelStyle: const ManropeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const ManropeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.background,
        surfaceTintColor: colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: radius.big, topRight: radius.big)),
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        color: colorScheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius.big)),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.background,
        surfaceTintColor: colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius.big)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          minimumSize: const Size(64, 52),
          maximumSize: const Size.fromHeight(52),
          elevation: 0,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius.regular)),
          textStyle: const ManropeTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(colorScheme.primary),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: tabLabelColor,
        labelStyle: const ManropeTextStyle(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.4),
        unselectedLabelColor: tabUnselectedLabelColor,
        unselectedLabelStyle: const ManropeTextStyle(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.4),
        splashFactory: NoSplash.splashFactory,
      ),
    );
  }
}

extension on Brightness {
  Brightness get inversed {
    return this == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
