import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/widgets.dart';

extension DarkModeX on BuildContext {
  /// Is dark mode currently active.
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension BorderRadiusX on BorderRadiusGeometry {
  /// Returns SmoothBorderRadius.
  SmoothBorderRadius smoothBorderRadius(BuildContext context) {
    // FIXME: CornerSmoothing of 1 creates null pointer dereference error with SmoothRectangleBorder on mobile web/PWA
    // for some reason. So we use 0.94 instead.
    final borderRadius = resolve(Directionality.of(context));

    return SmoothBorderRadius.only(
      topLeft: SmoothRadius(
        cornerRadius: borderRadius.topLeft.x,
        cornerSmoothing: 0.94,
      ),
      topRight: SmoothRadius(
        cornerRadius: borderRadius.topRight.x,
        cornerSmoothing: 0.94,
      ),
      bottomLeft: SmoothRadius(
        cornerRadius: borderRadius.bottomLeft.x,
        cornerSmoothing: 0.94,
      ),
      bottomRight: SmoothRadius(
        cornerRadius: borderRadius.bottomRight.x,
        cornerSmoothing: 0.94,
      ),
    );
  }
}
