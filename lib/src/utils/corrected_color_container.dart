import 'dart:ui';

import 'package:flutter/widgets.dart';

/// This is a workaround for visual bug in Flutter caused by the Color.lerp method which is using straight alpha instead
/// of premultiplied alpha leading to incorrect color lerping. Visually this manifests as a darker colored "hump" in
/// the middle of the lerp when any of the lerped colors has low enough alpha on a light background. The lower the alpha
/// value, the more pronounced the effect.
///
/// This is a known issue in Flutter and is being tracked here: https://github.com/flutter/flutter/issues/48534
class ColorWithPremulAlphaTween extends Tween<Color> {
  ColorWithPremulAlphaTween({required Color begin, required Color end}) : super(begin: begin, end: end);

  Color lerpWithPremul(Color a, Color b, double t) {
    final w1 = (1 - t) * a.opacity;
    final w2 = t * b.opacity;
    final n = w1 + w2;
    final w = n > 0.000001 ? w2 / n : 0.5;

    return Color.fromARGB(
      lerpDouble(a.alpha, b.alpha, t)!.toInt().clamp(0, 255),
      lerpDouble(a.red, b.red, w)!.toInt().clamp(0, 255),
      lerpDouble(a.green, b.green, w)!.toInt().clamp(0, 255),
      lerpDouble(a.blue, b.blue, w)!.toInt().clamp(0, 255),
    );
  }

  @override
  Color lerp(double t) => lerpWithPremul(begin!, end!, t);
}

class CorrectedColorContainer extends StatelessWidget {
  final Color color;
  final EdgeInsetsDirectional? padding;
  final Widget child;

  /// This is a temporary fix widget to ensure colors with alpha get lerped correctly (Skia seems to be using buggy
  /// straight alpha implementation but Impeller the correct premultiplied alpha implementation).
  const CorrectedColorContainer({
    required this.color,
    required this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOutCubic,
      tween: ColorWithPremulAlphaTween(begin: color, end: color),
      builder: (context, color, child) {
        return Container(
          color: color,
          padding: padding,
          child: child,
        );
      },
      child: child,
    );
  }
}
