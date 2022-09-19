import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async => runApp(
      ProviderScope(observers: [AppObserver()], child: await builder()),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class AppObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (provider.name != null) log('didAddProvider($value)', name: '${provider.name}');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (provider.name != null) log('didUpdateProvider($newValue)', name: '${provider.name}');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    if (provider.name != null) log('providerDidFail($error)', name: '${provider.name}');
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    if (provider.name != null) log('didDisposeProvider', name: '${provider.name}');
  }
}
