import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/di.dart';
import 'package:peristock/presentation/settings/presenter/presenter.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';

final userProvider = FutureProvider((ref) async => ref.read(Dependency.sessionRepository).getCurrentUser());

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  static const String name = 'Settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return user.when(
      data: (value) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const SettingsLayout(),
      ),
      error: ErrorLayout.new,
      loading: LoadingLayout.new,
    );
  }
}

class SettingsLayout extends ConsumerWidget {
  const SettingsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return ListTileTheme(
      dense: true,
      child: ListView(
        children: [
          ListTile(
            title: const Text('Email'),
            subtitle: Text(user.requireValue.email),
          ),
          const LogOutButton(),
        ],
      ),
    );
  }
}

class LogOutButton extends ConsumerWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Log out'),
      onTap: () => SettingsPresenter.logOut(ref),
    );
  }
}
