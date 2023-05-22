import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

class PulseEffectPainter extends CustomPainter {
  static const double _animationRangeStartValue = 0.286;
  final Color color;
  final Animation<double> animation;
  final double effectExtent;
  final BorderRadius borderRadius;

  PulseEffectPainter({
    required this.color,
    required this.animation,
    required this.effectExtent,
    required this.borderRadius,
  }) : super(repaint: animation);

  double animationRange({
    required double begin,
    required double end,
    required double animationValue,
  }) {
    return clampDouble((animationValue - begin) / (end - begin), 0.0, 1.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!animation.isDismissed) {
      final double rangeValue =
          animationRange(begin: _animationRangeStartValue, end: 1.0, animationValue: animation.value);
      final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
      final double opacity = (rangeValue == 0.0 ? 0.0 : 1.0 - rangeValue).clamp(0.0, 1.0);
      final Color transformedColor = color.withOpacity(opacity);
      final double newWidth = rect.width + rangeValue * effectExtent;
      final double newHeight = rect.height + rangeValue * effectExtent;
      final double widthIncrease = newWidth / rect.width;
      final double heightIncrease = newHeight / rect.height;
      final double widthOffset = (widthIncrease - 1) / 2;
      final double heightOffset = (heightIncrease - 1) / 2;
      final double resolvedExtent = borderRadius != BorderRadius.zero ? (effectExtent / 2) : 0;
      final double topLeftLerp =
          lerpDouble(borderRadius.topLeft.x, borderRadius.topLeft.x + resolvedExtent, rangeValue)!;
      final double topRightLerp =
          lerpDouble(borderRadius.topRight.x, borderRadius.topRight.x + resolvedExtent, rangeValue)!;
      final double bottomLeftLerp =
          lerpDouble(borderRadius.bottomLeft.x, borderRadius.bottomLeft.x + resolvedExtent, rangeValue)!;
      final double bottomRightLerp =
          lerpDouble(borderRadius.bottomRight.x, borderRadius.bottomRight.x + resolvedExtent, rangeValue)!;

      final Paint paint = Paint()
        ..color = transformedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = rangeValue * effectExtent + 1; // +1 for squircle hairline border correction

      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          topLeft: MoonSquircleRadius(cornerRadius: topLeftLerp),
          topRight: MoonSquircleRadius(cornerRadius: topRightLerp),
          bottomLeft: MoonSquircleRadius(cornerRadius: bottomLeftLerp),
          bottomRight: MoonSquircleRadius(cornerRadius: bottomRightLerp),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(PulseEffectPainter oldDelegate) {
    return false;
  }
}
