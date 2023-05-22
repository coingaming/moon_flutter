import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

extension DarkModeX on BuildContext {
  /// Is dark mode currently active.
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension BorderRadiusX on BorderRadiusGeometry {
  /// Returns MoonSquircleBorderRadius.
  MoonSquircleBorderRadius squircleBorderRadius(BuildContext context) {
    // The value of 1 or 1.0 lead to NaN error in mobile web/PWA for some reason. So we use 0.99 instead.
    final borderRadius = resolve(Directionality.of(context));

    return MoonSquircleBorderRadius.only(
      topLeft: MoonSquircleRadius(
        cornerRadius: borderRadius.topLeft.x,
        cornerSmoothing: 0.99,
      ),
      topRight: MoonSquircleRadius(
        cornerRadius: borderRadius.topRight.x,
        cornerSmoothing: 0.99,
      ),
      bottomLeft: MoonSquircleRadius(
        cornerRadius: borderRadius.bottomLeft.x,
        cornerSmoothing: 0.99,
      ),
      bottomRight: MoonSquircleRadius(
        cornerRadius: borderRadius.bottomRight.x,
        cornerSmoothing: 0.99,
      ),
    );
  }
}
