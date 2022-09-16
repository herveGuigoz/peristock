// ignore_for_file: strict_raw_type

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    // log(
    //   'didAddProvider($value)',
    //   name: '${provider.name}',
    // );
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // log(
    //   'didUpdateProvider($newValue)',
    //   name: '${provider.name}',
    // );
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    // log(
    //   'providerDidFail($error)',
    //   name: '${provider.name}',
    // );
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('didDisposeProvider', name: '${provider.name}');
  }
}

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
