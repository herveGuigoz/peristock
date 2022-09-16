import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/products/domain/products.dart';
import 'package:peristock/products/products.dart';

final router = Provider(
  (ref) => GoRouter(
    initialLocation: '/products',
    routes: [
      GoRoute(
        name: 'ProductList',
        path: '/products',
        builder: (context, state) => const ProductsListView(),
        routes: [
          GoRoute(
            name: 'ReadProduct',
            path: r':id(\d+)',
            builder: (context, state) => ReadProductView(
              id: int.parse(state.params['id']!),
            ),
          ),
          GoRoute(
            name: 'EditProduct',
            path: 'edit',
            pageBuilder: (context, state) => SlideTransitionPage(
              key: state.pageKey,
              child: EditProductView(product: state.extra! as Product),
            ),
          ),
        ],
      ),
      GoRoute(
        name: 'CreateProduct',
        path: '/create',
        pageBuilder: (context, state) => SlideTransitionPage(
          key: state.pageKey,
          child: const CreateProductView(),
        ),
      ),
    ],
  ),
);

/// Custom transition page with no transition.
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
    const begin = Offset(0, 1);
    const end = Offset.zero;
    final curve = CurveTween(curve: Curves.ease);

    return SlideTransition(
      position: animation.drive(Tween(begin: begin, end: end).chain(curve)),
      child: child,
    );
  }
}
