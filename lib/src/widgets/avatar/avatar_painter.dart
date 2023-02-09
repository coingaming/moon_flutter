import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class AvatarPainter extends CustomPainter {
  AvatarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blue;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRRect(RRect.fromLTRBR(0, 0, 64, 64, Radius.circular(32))),
        Path()..addOval(Rect.fromCircle(center: Offset(58, 58), radius: 6 + 4)),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(AvatarPainter oldDelegate) {
    return false;
  }
}
