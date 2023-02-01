import 'dart:ui';

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
      final rangeValue = animationRange(begin: _animationRangeStartValue, end: 1.0, animationValue: animation.value);
      final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
      final opacity = (rangeValue == 0.0 ? 0.0 : 1.0 - rangeValue).clamp(0.0, 1.0);
      final transformedColor = color.withOpacity(opacity);
      final newWidth = rect.width + rangeValue * effectExtent;
      final newHeight = rect.height + rangeValue * effectExtent;
      final widthIncrease = newWidth / rect.width;
      final heightIncrease = newHeight / rect.height;
      final widthOffset = (widthIncrease - 1) / 2;
      final heightOffset = (heightIncrease - 1) / 2;
      final endBorderRadius = borderRadiusValue + (effectExtent / 2);
      final borderValueLerp = lerpDouble(borderRadiusValue, endBorderRadius, rangeValue);

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
          Radius.circular(borderValueLerp!),
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
