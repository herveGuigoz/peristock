import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/settings/presenter/presenter.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const String path = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SettingsLayout(),
    );
  }
}

class SettingsLayout extends ConsumerWidget {
  const SettingsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LogOutButton(),
        ],
      ),
    );
  }
}

class LogOutButton extends ConsumerWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => SettingsPresenter.logOut(ref),
      child: const Text('Log out'),
    );
  }
}
