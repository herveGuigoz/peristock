import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/domain.dart';
import 'package:peristock/domain/providers/shopping.dart';
import 'package:peristock/presentation/shared/layouts/layouts.dart';
import 'package:peristock/presentation/shared/theme/theme.dart';
import 'package:peristock/presentation/shopping/lists/upsert/view/upsert_shopping_list.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShoppingListsView extends ConsumerWidget {
  const ShoppingListsView({super.key});

  static const String path = '/shopping';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final lists = ref.watch(shoppingListsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: theme.palette.secondaryContainer,
        onPressed: () => UpsertListModal.show(context),
        child: const Icon(PhosphorIcons.plus),
      ),
      body: lists.when(
        data: ShoppingListsLayout.new,
        error: ErrorLayout.new,
        loading: LoadingLayout.new,
      ),
    );
  }
}

class ShoppingListsLayout extends ConsumerWidget {
  const ShoppingListsLayout(this.lists, {super.key});

  final List<ShoppingList> lists;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
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
              Text('Total items: ${widget.value.items.length}'),
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
            onTap: () => context.go('/shopping/${widget.value.id}'),
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
