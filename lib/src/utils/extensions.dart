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
  /// Returns SquircleBorderRadius.
  SquircleBorderRadius squircleBorderRadius(BuildContext context) {
    // FIXME: CornerSmoothing of 1 creates null pointer dereference error with SquircleBorder on mobile web/PWA
    // for some reason. So we use 0.94 instead.
    final borderRadius = resolve(Directionality.of(context));

    return SquircleBorderRadius.only(
      topLeft: SquircleRadius(
        cornerRadius: borderRadius.topLeft.x,
        cornerSmoothing: 0.94,
      ),
      topRight: SquircleRadius(
        cornerRadius: borderRadius.topRight.x,
        cornerSmoothing: 0.94,
      ),
      bottomLeft: SquircleRadius(
        cornerRadius: borderRadius.bottomLeft.x,
        cornerSmoothing: 0.94,
      ),
      bottomRight: SquircleRadius(
        cornerRadius: borderRadius.bottomRight.x,
        cornerSmoothing: 0.94,
      ),
    );
  }
}
