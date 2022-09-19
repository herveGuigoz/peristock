part of 'layouts.dart';

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
