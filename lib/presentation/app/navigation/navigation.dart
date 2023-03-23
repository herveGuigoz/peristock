import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/ports/session.dart';
import 'package:peristock/presentation/app/navigation/transitions/fade_transition.dart';
import 'package:peristock/presentation/app/presenter/presenter.dart';
import 'package:peristock/presentation/app/views/main.dart';
import 'package:peristock/presentation/login/view/login_view.dart';
import 'package:peristock/presentation/settings/settings.dart';
import 'package:peristock/presentation/shopping/items/read/view/shopping_list_view.dart';
import 'package:peristock/presentation/shopping/lists/read/shopping_lists_view.dart';
import 'package:peristock/presentation/trends/view/trends.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/shopping',
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
            path: '/shopping',
            name: ShoppingListsView.name,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const ShoppingListsView(),
            ),
          ),
          GoRoute(
            path: '/trends',
            name: TrendsView.name,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const TrendsView(),
            ),
          ),
          GoRoute(
            path: '/settings',
            name: SettingsView.name,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const SettingsView(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: r'/shopping-list/:id(\d+)',
        name: ShoppingListView.name,
        builder: (context, state) => ShoppingListView(
          id: int.parse(state.params['id']!),
        ),
      ),
    ],
    redirect: (context, GoRouterState state) {
      final isAuthenticated = ref.read(AppPresenter.isAuthenticated);
      final location = state.location;

      if (!isAuthenticated && location != LoginView.path) {
        return LoginView.path;
      }

      if (isAuthenticated && location == LoginView.path) {
        return '/shopping';
      }

      return null;
    },
    refreshListenable: AppStateRefreshStream(
      ref.read(AppPresenter.state.notifier).stream,
    ),
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
