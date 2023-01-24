import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/deep_links/deep_links_observer.dart';
import 'package:peristock/domain/domain.dart';

part 'state.dart';

class AppStateNotifier extends StateNotifier<AppState> with DeepLinkObserverMixin {
  AppStateNotifier(this._sessionRepository) : super(const AppState()) {
    startDeeplinkObserver();
  }

  final SessionRepositoryInterface _sessionRepository;

  Future<void> recoverSession() async {
    try {
      state = AppState(status: await _sessionRepository.recoverSession());
    } catch (_) {
      state = const AppState();
    }
  }

  @override
  Future<void> handleDeeplink(Uri uri) async {
    final status = await _sessionRepository.handleDeeplink(uri.toString());
    state = AppState(status: status);
  }

  @override
  void onErrorReceivingDeeplink(String message) {
    log(message, name: 'onErrorReceivingDeeplink');
  }

  Future<void> signOut() async {
    await _sessionRepository.signOut();
    state = const AppState();
  }
}
