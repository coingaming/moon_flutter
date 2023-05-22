import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

class FocusEffectPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;
  final double effectExtent;
  final BorderRadius borderRadius;

  FocusEffectPainter({
    required this.color,
    required this.animation,
    required this.effectExtent,
    required this.borderRadius,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (!animation.isDismissed) {
      final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
      final Color transformedColor = colorPremulLerp(null, color, animation.value)!;
      final double newWidth = rect.width + effectExtent;
      final double newHeight = rect.height + effectExtent;
      final double widthIncrease = newWidth / rect.width;
      final double heightIncrease = newHeight / rect.height;
      final double widthOffset = (widthIncrease - 1) / 2;
      final double heightOffset = (heightIncrease - 1) / 2;
      final double resolvedExtent = borderRadius != BorderRadius.zero ? (effectExtent / 2) : 0;

      final Paint paint = Paint()
        ..color = transformedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = effectExtent + 1; // +1 for squircle hairline border correction

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          topLeft: MoonSquircleRadius(cornerRadius: borderRadius.topLeft.x + resolvedExtent, cornerSmoothing: 0.99),
          topRight: MoonSquircleRadius(cornerRadius: borderRadius.topRight.x + resolvedExtent, cornerSmoothing: 0.99),
          bottomLeft:
              MoonSquircleRadius(cornerRadius: borderRadius.bottomLeft.x + resolvedExtent, cornerSmoothing: 0.99),
          bottomRight:
              MoonSquircleRadius(cornerRadius: borderRadius.bottomRight.x + resolvedExtent, cornerSmoothing: 0.99),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FocusEffectPainter oldDelegate) {
    return animation != oldDelegate.animation || color != oldDelegate.color;
  }
}
