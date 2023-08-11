import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

class MoonRadioPainter extends ToggleablePainter {
  static const double _kOuterRadius = 8.0;
  static const double _kInnerRadius = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = (Offset.zero & size).center;

    // Outer circle
    final Paint paint = Paint()
      ..color = colorPremulLerp(inactiveColor, activeColor, position.value)!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, _kOuterRadius, paint);

    // Inner circle
    if (!position.isDismissed) {
      paint.style = PaintingStyle.fill;

      canvas.drawCircle(center, _kInnerRadius * position.value, paint);
    }
  }
}
