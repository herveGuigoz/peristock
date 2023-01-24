import 'package:flutter/widgets.dart';
import 'package:peristock/bootstrap.dart';
import 'package:peristock/presentation/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
