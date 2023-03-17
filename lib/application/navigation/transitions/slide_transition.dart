import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideTransitionPage<T> extends CustomTransitionPage<T> {
  const SlideTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 450),
  }) : super(transitionsBuilder: _transitionsBuilder);

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    final curve = CurveTween(curve: Curves.ease);

    return SlideTransition(
      position: animation.drive(Tween(begin: begin, end: end).chain(curve)),
      child: child,
    );
  }
}
