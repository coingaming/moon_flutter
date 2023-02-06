import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class PulseEffectPainter extends CustomPainter {
  static const double _animationRangeStartValue = 0.286;
  final Color color;
  final Animation<double> animation;
  final double effectExtent;
  final double borderRadiusValue;

  PulseEffectPainter({
    required this.color,
    required this.animation,
    required this.effectExtent,
    required this.borderRadiusValue,
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
      final double endBorderRadius = borderRadiusValue > 0 ? borderRadiusValue + (effectExtent / 2) : 0;
      final double borderValueLerp = lerpDouble(borderRadiusValue, endBorderRadius, rangeValue)!;

      final Paint paint = Paint()
        ..color = transformedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = rangeValue * effectExtent;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          SmoothRadius(cornerRadius: borderValueLerp, cornerSmoothing: 1),
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
