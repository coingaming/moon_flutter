import 'dart:ui';

Color _scaleAlpha(Color a, double factor) {
  return a.withAlpha((a.alpha * factor).round().clamp(0, 255));
}

/// Workaround for Flutter's use of straight alpha instead of premultiplied
/// alpha for color lerping.
Color? colorPremulLerp(Color? a, Color? b, double t) {
  if (b == null) {
    if (a == null) {
      return null;
    } else {
      return _scaleAlpha(a, 1.0 - t);
    }
  } else {
    if (a == null) {
      return _scaleAlpha(b, t);
    } else {
      final weight1 = (1 - t) * a.opacity;
      final weight2 = t * b.opacity;
      final summedWeight = weight1 + weight2;
      final w = summedWeight > 0.000001 ? weight2 / summedWeight : 0.5;

      return Color.fromARGB(
        lerpDouble(a.alpha, b.alpha, t)!.toInt().clamp(0, 255),
        lerpDouble(a.red, b.red, w)!.toInt().clamp(0, 255),
        lerpDouble(a.green, b.green, w)!.toInt().clamp(0, 255),
        lerpDouble(a.blue, b.blue, w)!.toInt().clamp(0, 255),
      );
    }
  }
}
