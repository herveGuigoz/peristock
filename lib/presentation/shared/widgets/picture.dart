part of 'widgets.dart';

class Picture extends StatelessWidget {
  const Picture({
    super.key,
    this.image,
    this.size = const Size.square(100),
    this.decoration,
    BoxFit? fit,
    this.onTap,
  }) : fit = fit ?? BoxFit.scaleDown;

  final String? image;

  final Size size;

  final Decoration? decoration;

  final BoxFit fit;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderRadius = BorderRadius.all(theme.radius.regular);
    final color = theme.dividerColor;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: decoration,
        constraints: BoxConstraints.tight(size),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: image == null
              ? Icon(Icons.camera_alt, color: color)
              : Image(image: AdaptiveImageProvider(image!), fit: fit),
        ),
      ),
    );
  }
}
