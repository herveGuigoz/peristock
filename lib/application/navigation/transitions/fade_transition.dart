import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  const FadeTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
    super.transitionDuration = kThemeAnimationDuration,
  }) : super(transitionsBuilder: _transitionsBuilder);

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
