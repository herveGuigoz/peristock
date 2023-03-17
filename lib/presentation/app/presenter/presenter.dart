import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/deep_links/deep_links_observer.dart';
import 'package:peristock/domain/domain.dart';

class AppStateNotifier extends StateNotifier<AuthenticationStatus> with DeepLinkObserverMixin {
  AppStateNotifier(this._sessionRepository) : super(_sessionRepository.recoverSession()) {
    startDeeplinkObserver();
  }

  final SessionRepositoryInterface _sessionRepository;

  @override
  Future<void> handleDeeplink(Uri uri) async {
    final status = await _sessionRepository.handleDeeplink('$uri');
    if (status != null) state = status;
  }

  @override
  void onErrorReceivingDeeplink(String message) {
    log(message, name: 'onErrorReceivingDeeplink');
  }

  Future<void> signOut() async {
    await _sessionRepository.signOut();
    state = AuthenticationStatus.unauthenticated;
  }
}
