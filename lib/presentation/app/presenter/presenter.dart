import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/domain/ports/session.dart';
import 'package:peristock/domain/ports/storage.dart';
import 'package:peristock/presentation/app/deep_links/deep_links_observer.dart';

typedef AppStateNotifierProvider = StateNotifierProvider<AppStateNotifier, AuthenticationStatus>;

typedef IsAuthenticatedProvider = Provider<bool>;

abstract class AppPresenter {
  static AppStateNotifierProvider get state => _appStateProvider;

  static IsAuthenticatedProvider get isAuthenticated => _isAuthenticatedProvider;
}

final _appStateProvider = AppStateNotifierProvider(
  (ref) => AppStateNotifier(
    sessionRepository: ref.watch(Dependency.sessionRepository),
    storage: ref.read(Dependency.storage),
  ),
  name: 'AppStateNotifierProvider',
);

final _isAuthenticatedProvider = Provider<bool>(
  (ref) => ref.watch(_appStateProvider) == AuthenticationStatus.authenticated,
  name: 'IsAuthenticatedProvider',
);

class AppStateNotifier extends StateNotifier<AuthenticationStatus> with DeepLinkObserverMixin {
  AppStateNotifier({
    required this.sessionRepository,
    required this.storage,
  }) : super(sessionRepository.recoverSession()) {
    startDeeplinkObserver();
  }

  @protected
  final SessionRepositoryInterface sessionRepository;

  @protected
  final StorageInterface storage;

  @override
  Future<void> handleDeeplink(Uri uri) async {
    final status = await sessionRepository.handleDeeplink('$uri');
    if (status != null) state = status;
  }

  @override
  void onErrorReceivingDeeplink(String message) {
    Error.throwWithStackTrace(Exception(message), StackTrace.current);
  }

  Future<void> signOut() async {
    await sessionRepository.signOut();
    state = AuthenticationStatus.unauthenticated;
  }
}
