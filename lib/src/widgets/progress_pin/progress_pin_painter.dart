import 'package:flutter/material.dart';

class ProgressPinPainter extends CustomPainter {
  final bool showShadow;
  final Color pinColor;
  final Color thumbColor;
  final Color shadowColor;
  final Color pinBorderColor;
  final double pinBorderWidth;
  final double pinDistance;
  final double pinWidth;
  final double? thumbWidth;
  final double thumbWidthMultiplier;
  final double progressValue;
  final double shadowElevation;
  final String labelText;
  final TextStyle textStyle;
  final TextDirection textDirection;

  const ProgressPinPainter({
    required this.showShadow,
    required this.pinColor,
    required this.thumbColor,
    required this.shadowColor,
    required this.pinBorderColor,
    required this.pinBorderWidth,
    required this.pinDistance,
    required this.pinWidth,
    this.thumbWidth,
    required this.thumbWidthMultiplier,
    required this.progressValue,
    required this.shadowElevation,
    required this.labelText,
    required this.textStyle,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = pinWidth / 2;
    final double arrowHeight = radius / 3;
    final double arrowWidth = radius / 2;
    final double offsetY = -(radius + arrowHeight + pinDistance);
    final double thumbSizeWidth = thumbWidth ?? size.height / thumbWidthMultiplier;

    // Offset based on directionality
    double offsetX = progressValue * size.width;

    switch (textDirection) {
      case TextDirection.rtl:
        offsetX = size.width - progressValue * size.width;
      case TextDirection.ltr:
        offsetX = progressValue * size.width;
    }

    // Assign colors
    final Paint outerCirclePaint = Paint()..color = pinBorderColor;
    final Paint innerCirclePaint = Paint()..color = pinColor;
    final Paint thumbCirclePaint = Paint()..color = thumbColor;

    // Create outer circle with triangle path
    final Path path = Path()
      ..addOval(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius))
      ..addOval(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius))
      ..moveTo(offsetX - arrowWidth / 2, offsetY + (radius * 0.9))
      ..lineTo(offsetX, offsetY + radius + arrowHeight)
      ..lineTo(offsetX + arrowWidth / 2, offsetY + (radius * 0.9))
      ..close();

    // Draw shadow around outer path
    if (showShadow) canvas.drawShadow(path, shadowColor, shadowElevation, false);

    // Draw outer path
    canvas.drawPath(path, outerCirclePaint);

    // Draw inner circle
    canvas.drawCircle(Offset(offsetX, offsetY), radius - pinBorderWidth, innerCirclePaint);

    // Draw thumb
    canvas.drawCircle(Offset(offsetX, size.height / 2), thumbSizeWidth, thumbCirclePaint);

    // Draw text
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: labelText, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(offsetX - textPainter.width / 2, offsetY - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(ProgressPinPainter oldPainter) {
    return oldPainter.progressValue != progressValue ||
        oldPainter.pinWidth != pinWidth ||
        oldPainter.pinBorderWidth != pinBorderWidth ||
        oldPainter.pinColor != pinColor ||
        oldPainter.pinBorderColor != pinBorderColor ||
        oldPainter.pinDistance != pinDistance ||
        oldPainter.thumbColor != thumbColor ||
        oldPainter.thumbWidth != thumbWidth ||
        oldPainter.showShadow != showShadow ||
        oldPainter.shadowColor != shadowColor ||
        oldPainter.shadowElevation != shadowElevation ||
        oldPainter.textDirection != textDirection;
  }
}
