import 'package:flutter/material.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({
    super.key,
    required this.actions,
  });

  static Future<void> show(BuildContext context, {List<Widget> actions = const []}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => ActionsBottomSheet(actions: actions),
      useRootNavigator: true,
    );
  }

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: ListTileThemeData(
        iconColor: theme.colorScheme.tertiary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    );
  }
}
