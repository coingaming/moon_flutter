import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

class FocusEffectPainter extends CustomPainter {
  final Animation<double> animation;
  final bool isFilled;
  final BorderRadius borderRadius;
  final Color color;
  final double effectExtent;

  FocusEffectPainter({
    required this.animation,
    required this.borderRadius,
    this.isFilled = false,
    required this.color,
    required this.effectExtent,
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

      final Paint paint = isFilled
          ? (Paint()
            ..color = transformedColor
            ..style = PaintingStyle.fill)
          : (Paint()
            ..color = transformedColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = effectExtent + 1); // +1 for squircle hairline border correction

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          topLeft: MoonSquircleRadius(cornerRadius: borderRadius.topLeft.x + resolvedExtent),
          topRight: MoonSquircleRadius(cornerRadius: borderRadius.topRight.x + resolvedExtent),
          bottomLeft: MoonSquircleRadius(cornerRadius: borderRadius.bottomLeft.x + resolvedExtent),
          bottomRight: MoonSquircleRadius(cornerRadius: borderRadius.bottomRight.x + resolvedExtent),
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
