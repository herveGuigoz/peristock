import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

mixin DeepLinkObserverMixin {
  StreamSubscription<Uri?>? _sub;

  /// The initial Uri - the one the app was started with.
  /// Should be handled only once in the app's lifetime.
  static Uri? _initialLink;

  /// Callback when deeplink receiving succeeds
  FutureOr<void> handleDeeplink(Uri uri);

  /// Callback when deeplink receiving throw error
  void onErrorReceivingDeeplink(String message);

  void startDeeplinkObserver() {
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void stopDeeplinkObserver() {
    _sub?.cancel();
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen(
        (Uri? uri) {
          if (uri != null) handleDeeplink(uri);
        },
        onError: (Object err) {
          onErrorReceivingDeeplink(err.toString());
        },
      );
    }
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = _initialLink ??= await getInitialUri();
      if (uri != null) handleDeeplink(uri);
    } on PlatformException {
      // Platform messages may fail but we ignore the exception
    } on FormatException catch (err) {
      onErrorReceivingDeeplink(err.message);
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
