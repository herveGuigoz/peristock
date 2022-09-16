import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

TextEditingController useTextController({
  String? Function()? create,
  required void Function(String input)? onChange,
}) {
  final controller = useTextEditingController(text: create?.call());
  void _listener() => onChange?.call(controller.text);
  useEffect(() {
    controller.addListener(_listener);
    return () => controller.removeListener(_listener);
  });

  return controller;
}
