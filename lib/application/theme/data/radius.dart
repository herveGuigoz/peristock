part of '../theme.dart';

@immutable
class ThemeRadius extends ThemeExtension<ThemeRadius> {
  const ThemeRadius({
    this.small = const Radius.circular(4),
    this.regular = const Radius.circular(8),
    this.big = const Radius.circular(16),
  });

  final Radius small;
  final Radius regular;
  final Radius big;

  @override
  ThemeExtension<ThemeRadius> copyWith({
    Radius? small,
    Radius? regular,
    Radius? big,
  }) {
    return ThemeRadius(
      small: small ?? this.small,
      regular: regular ?? this.regular,
      big: big ?? this.big,
    );
  }

  @override
  ThemeExtension<ThemeRadius> lerp(
    ThemeExtension<ThemeRadius>? other,
    double t,
  ) {
    if (other is! ThemeRadius) {
      return this;
    }

    return ThemeRadius(
      small: Radius.lerp(small, other.small, t)!,
      regular: Radius.lerp(regular, other.regular, t)!,
      big: Radius.lerp(big, other.big, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeRadius &&
        other.small == small &&
        other.regular == regular &&
        other.big == big;
  }

  @override
  int get hashCode => small.hashCode ^ regular.hashCode ^ big.hashCode;
}
