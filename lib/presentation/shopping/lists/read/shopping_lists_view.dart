import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/shopping/commands/delete_list_command.dart';
import 'package:peristock/application/shopping/providers.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shopping/items/read/view/shopping_list_view.dart';
import 'package:peristock/presentation/shopping/lists/upsert/view/upsert_shopping_list.dart';
import 'package:peristock/presentation/shopping/shared/modal_actions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShoppingListsView extends ConsumerWidget {
  const ShoppingListsView({super.key});

  static const String name = 'ShoppingLists';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final lists = ref.watch(findShoppingListsQueryHandler);

    return Scaffold(
      body: lists.when(data: ShoppingListsLayout.new, error: ErrorLayout.new, loading: LoadingLayout.new),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: theme.colorScheme.tertiary,
        onPressed: () => UpsertListModal.show(context),
        child: const Icon(PhosphorIcons.plus),
      ),
    );
  }
}

class ShoppingListsLayout extends ConsumerWidget {
  const ShoppingListsLayout(this.lists, {super.key});

  final List<ShoppingList> lists;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(findShoppingListsQueryHandler),
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Shopping Lists'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ShoppingListTile(lists[index]),
              childCount: lists.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingListTile extends StatefulWidget {
  const ShoppingListTile(this.value, {super.key});

  final ShoppingList value;

  @override
  State<ShoppingListTile> createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> with SingleTickerProviderStateMixin {
  static final _easeInTween = CurveTween(curve: Curves.easeIn);
  static final _halfTween = Tween<double>(begin: 0, end: 0.5);

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          // ignore: no-empty-block
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closed = !_isExpanded && _controller.isDismissed;

    final children = Offstage(
      offstage: closed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular),
        child: DefaultTextStyle(
          style: theme.textTheme.bodySmall!,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total items: ${widget.value.listItems.length}'),
            ],
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(widget.value.name),
            trailing: IconButton(
              onPressed: expand,
              icon: RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),
            ),
            onTap: () => context.pushNamed(ShoppingListView.name, params: {'id': '${widget.value.id}'}),
            onLongPress: () => ActionsBottomSheet.show(
              context,
              actions: [
                EditActionButon(list: widget.value),
                DeleteActionButon(list: widget.value),
              ],
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
      child: children,
    );
  }
}

class EditActionButon extends ConsumerWidget {
  const EditActionButon({super.key, required this.list});

  final ShoppingList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(PhosphorIcons.pencil),
      title: const Text('Edit'),
      onTap: () => Future.sync(context.pop).then((_) => UpsertListModal.show(context, instance: list)),
    );
  }
}

class DeleteActionButon extends HookConsumerWidget {
  const DeleteActionButon({super.key, required this.list});

  final ShoppingList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tapped = useState(false);

    return ListTile(
      leading: const Icon(PhosphorIcons.trashSimple),
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: tapped.value
            ? Text('Click to confirm', style: TextStyle(color: theme.colorScheme.error))
            : const Text('Delete'),
      ),
      onTap: () {
        if (tapped.value) {
          ref.read(deleteShoppingListCommandHandler).call(DeleteShoppingListCommand(item: list));
          context.pop();
        } else {
          tapped.value = true;
        }
      },
    );
  }
}
