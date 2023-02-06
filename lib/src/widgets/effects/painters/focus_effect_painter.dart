import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class FocusEffectPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;
  final double effectExtent;
  final double borderRadiusValue;

  FocusEffectPainter({
    required this.color,
    required this.animation,
    required this.effectExtent,
    required this.borderRadiusValue,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if (!animation.isDismissed) {
      final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
      final Color transformedColor = Color.lerp(null, color, animation.value)!;
      final double newWidth = rect.width + effectExtent;
      final double newHeight = rect.height + effectExtent;
      final double widthIncrease = newWidth / rect.width;
      final double heightIncrease = newHeight / rect.height;
      final double widthOffset = (widthIncrease - 1) / 2;
      final double heightOffset = (heightIncrease - 1) / 2;
      final double endBorderRadius = borderRadiusValue > 0 ? borderRadiusValue + (effectExtent / 2) : 0;

      final Paint paint = Paint()
        ..color = transformedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = effectExtent;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            -rect.width * widthOffset,
            -rect.height * heightOffset,
            rect.width * widthIncrease,
            rect.height * heightIncrease,
          ),
          SmoothRadius(cornerRadius: endBorderRadius, cornerSmoothing: 1),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FocusEffectPainter oldDelegate) {
    return false;
  }
}
