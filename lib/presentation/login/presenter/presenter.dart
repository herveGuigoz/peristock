import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/domain/ports/session.dart';
import 'package:peristock/presentation/shared/shared.dart';

part 'notifier.dart';
part 'state.dart';

typedef LoginFormNotifierProvider = AutoDisposeStateNotifierProvider<_LoginFormNotifier, LoginState>;

abstract class LoginFormPresenter {
  static LoginFormNotifierProvider get state => _loginStateProvider;
}

final _loginStateProvider = LoginFormNotifierProvider(
  (ref) => _LoginFormNotifier(sessionRepository: ref.read(Dependency.sessionRepository)),
  name: 'LoginFormNotifierProvider',
);
