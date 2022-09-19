import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/shared/result.dart';

typedef UsecaseCreate<O, C> = Usecase<C, O> Function(
  FutureProviderRef<Result<O>> ref,
);

typedef AutoDisposeUsecaseCreate<O, C> = Usecase<C, O> Function(
  AutoDisposeFutureProviderRef<Result<O>> ref,
);

@immutable
abstract class Usecase<Command, Output> {
  const Usecase();

  FutureOr<Result<Output>> execute(Command command);
}

// ignore: subtype_of_sealed_class
class UsecaseProvider<Command, State> extends FutureProviderFamily<Result<State>, Command> {
  UsecaseProvider(
    UsecaseCreate<State, Command> _create,
  ) : super((ref, command) => _create(ref).execute(command));
}

// ignore: subtype_of_sealed_class
class AutoDisposeUsecaseProvider<Command, State> extends AutoDisposeFutureProviderFamily<Result<State>, Command> {
  AutoDisposeUsecaseProvider(
    AutoDisposeUsecaseCreate<State, Command> _create,
  ) : super((ref, command) => _create(ref).execute(command));
}
