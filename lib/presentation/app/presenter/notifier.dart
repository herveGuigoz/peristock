import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/app/presenter/presenter.dart';
import 'package:peristock/presentation/di.dart';

typedef AppStateNotifierProvider = StateNotifierProvider<AppStateNotifier, AuthenticationStatus>;

typedef IsAuthenticatedProvider = Provider<bool>;

abstract class AppPresenter {
  static AppStateNotifierProvider get state => _appStateProvider;

  static IsAuthenticatedProvider get isAuthenticated => _isAuthenticatedProvider;
}

final _appStateProvider = AppStateNotifierProvider(
  (ref) => AppStateNotifier(ref.watch(Dependency.sessionRepository)),
  name: 'AppStateNotifierProvider',
);

final _isAuthenticatedProvider = Provider<bool>(
  (ref) => ref.watch(_appStateProvider) == AuthenticationStatus.authenticated,
  name: 'IsAuthenticatedProvider',
);
