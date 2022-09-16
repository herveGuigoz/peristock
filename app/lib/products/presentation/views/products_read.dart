part of 'products_views.dart';

class ReadProductView extends ConsumerWidget {
  const ReadProductView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(searchProductById(id));

    return Material(
      child: product.when(
        error: ErrorLayout.new,
        loading: LoadingLayout.new,
        data: ReadProductLayout.new,
      ),
    );
  }
}

class ReadProductLayout extends ConsumerWidget {
  const ReadProductLayout(this.value, {super.key});

  final Product value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(value.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(theme.spacing.regular),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: NetworkImage(value.image!),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const FavoriteButton(),
                Gap(theme.spacing.small),
                const Expanded(
                  child: AddToShoppingListButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tight(
        const Size.square(48),
      ),
      child: Material(
        color: Palette.indigo100,
        borderRadius: BorderRadius.all(theme.radius.regular),
        type: MaterialType.button,
        child: InkWell(
          onTap: onPressed,
          child: const Icon(
            CupertinoIcons.heart,
            color: Palette.gray500,
          ),
        ),
      ),
    );
  }
}

class AddToShoppingListButton extends StatelessWidget {
  const AddToShoppingListButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: Palette.indigo400,
      ),
      onPressed: onPressed,
      child: const Text('Add to shopping list'),
    );
  }
}
