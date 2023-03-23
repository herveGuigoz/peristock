import 'package:flutter/material.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    super.key,
    this.size = const Size.square(48),
    this.borderRadius,
    this.child,
  });

  final Size size;

  final BorderRadiusGeometry? borderRadius;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: borderRadius ?? BorderRadius.all(theme.radius.small),
      ),
      constraints: BoxConstraints.tight(size),
      child: Center(child: child),
    );
  }
}
