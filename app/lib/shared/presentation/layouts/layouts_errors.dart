// ignore_for_file: use_key_in_widget_constructors

part of 'layouts.dart';

class ErrorLayout extends StatelessWidget {
  const ErrorLayout(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text('$error'),
      ),
    );
  }
}
