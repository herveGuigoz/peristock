import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/presentation/settings/presenter/presenter.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';

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
    return ListTileTheme(
      dense: true,
      child: ListView(
        children: const [
          ThemeSetting(),
          LogOutButton(),
        ],
      ),
    );
  }
}

class ThemeSetting extends ConsumerWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return SwitchListTile(
      value: theme is LightTheme,
      title: const Text('Dark Theme'),
      onChanged: (isDark) => ref.read(themeProvider.notifier).state = isDark ? const DarkTheme() : const LightTheme(),
    );
  }
}

class LogOutButton extends ConsumerWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () => SettingsPresenter.logOut(ref),
      title: const Text('Log out'),
    );
  }
}
