import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/navigation/transitions/fade_transition.dart';
import 'package:peristock/application/navigation/transitions/slide_transition.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/app/presenter/notifier.dart';
import 'package:peristock/presentation/app/view/main.dart';
import 'package:peristock/presentation/login/view/login_view.dart';
import 'package:peristock/presentation/products/favorite/view/favorite_products.dart';
import 'package:peristock/presentation/products/search/view/search_view.dart';
import 'package:peristock/presentation/settings/settings.dart';
import 'package:peristock/presentation/shopping/items/read/list_items.dart';
import 'package:peristock/presentation/shopping/lists/read/view/shopping_list.dart';
import 'package:peristock/presentation/trends/view/trends.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    refreshListenable: AppStateRefreshStream(
      ref.read(AppPresenter.state.notifier).stream,
    ),
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/products',
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
        redirect: (context, state) {
          final isAuthenticated = ref.read(AppPresenter.isAuthenticated);
          return isAuthenticated ? '/products' : null;
        },
      ),
      ShellRoute(
        builder: (context, state, child) => Main(child: child),
        routes: [
          GoRoute(
            name: 'ProductList',
            path: '/products',
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const FavoriteProductsView(),
            ),
            routes: [
              GoRoute(
                name: 'CreateProduct',
                path: 'create',
                pageBuilder: (context, state) => SlideTransitionPage(
                  key: state.pageKey,
                  child: Container(),
                ),
              ),
              GoRoute(
                name: 'EditProduct',
                path: 'edit',
                pageBuilder: (context, state) => SlideTransitionPage(
                  key: state.pageKey,
                  child: Container(),
                ),
              ),
            ],
          ),
          GoRoute(
            name: 'ShoppingList',
            path: ShoppingListsView.path,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const ShoppingListsView(),
            ),
            routes: [
              GoRoute(
                name: 'ReadShoppingList',
                path: r':id(\d+)',
                builder: (context, state) => ListItemsView(
                  id: int.parse(state.params['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            name: 'Trends',
            path: TrendsView.path,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const TrendsView(),
            ),
          ),
          GoRoute(
            name: 'Settings',
            path: SettingsView.path,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const SettingsView(),
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = ref.read(AppPresenter.isAuthenticated);
      final location = state.location;

      if (!isAuthenticated && location != LoginView.path) {
        return LoginView.path;
      }

      if (isAuthenticated && location == LoginView.path) {
        return '/products';
      }

      return null;
    },
  ),
  name: 'RouterProvider',
);

class AppStateRefreshStream extends ChangeNotifier {
  AppStateRefreshStream(Stream<AuthenticationStatus> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<Object> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
