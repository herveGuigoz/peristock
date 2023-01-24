part of '../theme.dart';

@immutable
class Spacing extends ThemeExtension<Spacing> {
  const Spacing({
    this.small = 8,
    this.regular = 16,
    this.big = 24,
  });

  final double small;
  final double regular;
  final double big;

  Spacing scale(double scaleFactor) {
    return copyWith(
      small: small * scaleFactor,
      regular: regular * scaleFactor,
      big: big * scaleFactor,
    );
  }

  @override
  Spacing copyWith({double? small, double? regular, double? big}) {
    return Spacing(
      small: small ?? this.small,
      regular: regular ?? this.regular,
      big: big ?? this.big,
    );
  }

  @override
  ThemeExtension<Spacing> lerp(ThemeExtension<Spacing>? other, double t) {
    if (other is! Spacing) {
      return this;
    }

    return Spacing(
      small: ui.lerpDouble(small, other.small, t)!,
      regular: ui.lerpDouble(regular, other.regular, t)!,
      big: ui.lerpDouble(big, other.big, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Spacing && other.small == small && other.regular == regular && other.big == big;
  }

  @override
  int get hashCode => small.hashCode ^ regular.hashCode ^ big.hashCode;
}
