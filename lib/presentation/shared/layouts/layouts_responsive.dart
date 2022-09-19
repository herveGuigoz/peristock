part of 'layouts.dart';

/// Signature for the individual builders (`phone`, `tablet`, etc.).
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

/// Namespace for Default Breakpoints
abstract class Breakpoints {
  /// Max width for a phone layout.
  static const double phone = 768;

  /// Max width for a tablet layout.
  static const double tablet = 1024;

  /// Max width for a laptop layout.
  static const double laptop = 1280;
}

/// A wrapper around [LayoutBuilder] which exposes builders for
/// various responsive breakpoints.
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    super.key,
    required this.phone,
    this.tablet,
    this.laptop,
    this.child,
  });

  /// [ResponsiveLayoutWidgetBuilder] for phone layout.
  final ResponsiveLayoutWidgetBuilder phone;

  /// [ResponsiveLayoutWidgetBuilder] for tablet layout.
  final ResponsiveLayoutWidgetBuilder? tablet;

  /// [ResponsiveLayoutWidgetBuilder] for laptop layout.
  final ResponsiveLayoutWidgetBuilder? laptop;

  /// Optional child widget which will be passed
  /// to the builders as a way to share/optimize shared layout.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth <= Breakpoints.phone) {
          return phone(context, child);
        }

        if (screenWidth <= Breakpoints.tablet) {
          return (tablet ?? phone).call(context, child);
        }

        return (laptop ?? tablet ?? phone).call(context, child);
      },
    );
  }
}
