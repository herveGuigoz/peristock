import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
