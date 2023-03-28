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
    return SmoothBorderRadius.only(
      topLeft: SmoothRadius(
        cornerRadius: topLeft.x,
        cornerSmoothing: 1,
      ),
      topRight: SmoothRadius(
        cornerRadius: topRight.x,
        cornerSmoothing: 1,
      ),
      bottomLeft: SmoothRadius(
        cornerRadius: bottomLeft.x,
        cornerSmoothing: 1,
      ),
      bottomRight: SmoothRadius(
        cornerRadius: bottomRight.x,
        cornerSmoothing: 1,
      ),
    );
  }
}
