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

extension BorderRadiusX on BorderRadius {
  /// Returns SmoothBorderRadius.
  SmoothBorderRadius get smoothBorderRadius {
    // FIXME: CornerSmoothing of 1 creates null pointer dereference error for some reason with SmoothRectangleBorder
    // for some reason. So we use 0.999 instead.
    return SmoothBorderRadius.only(
      topLeft: SmoothRadius(
        cornerRadius: topLeft.x,
        cornerSmoothing: 0.999,
      ),
      topRight: SmoothRadius(
        cornerRadius: topRight.x,
        cornerSmoothing: 0.999,
      ),
      bottomLeft: SmoothRadius(
        cornerRadius: bottomLeft.x,
        cornerSmoothing: 0.999,
      ),
      bottomRight: SmoothRadius(
        cornerRadius: bottomRight.x,
        cornerSmoothing: 0.999,
      ),
    );
  }
}
