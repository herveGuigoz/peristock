part of 'widgets.dart';

/// A widget that unfocus everything when tapped.
/// 
/// This implements the "Unfocus when tapping in empty space" behavior for the
/// entire child.
/// 
/// Child will commonly be [Scaffold] widget.
class Unfocus extends StatelessWidget {
  const Unfocus({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
