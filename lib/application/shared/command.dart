import 'dart:async';

import 'package:peristock/application/shared/result.dart';

abstract class CommandInterface {}

abstract class CommandHandlerInterface<T extends CommandInterface, R> {
  const CommandHandlerInterface();

  FutureOr<Result<R>> call(T command);
}
