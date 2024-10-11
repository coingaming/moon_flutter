import 'package:flutter/material.dart';

class ProgressPinPainter extends CustomPainter {
  final bool showShadow;
  final Color pinColor;
  final Color thumbColor;
  final Color shadowColor;
  final Color pinBorderColor;
  final double arrowHeight;
  final double arrowWidth;
  final double pinBorderWidth;
  final double pinDistance;
  final double pinWidth;
  final double? thumbSizeValue;
  final double progressValue;
  final double shadowElevation;
  final String pinText;
  final TextStyle textStyle;
  final TextDirection textDirection;

  const ProgressPinPainter({
    required this.showShadow,
    required this.pinColor,
    required this.thumbColor,
    required this.shadowColor,
    required this.pinBorderColor,
    required this.pinBorderWidth,
    required this.arrowHeight,
    required this.arrowWidth,
    required this.pinDistance,
    required this.pinWidth,
    this.thumbSizeValue,
    required this.progressValue,
    required this.shadowElevation,
    required this.pinText,
    required this.textStyle,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = pinWidth / 2;
    final double thumbRadius = switch (thumbSizeValue) {
      _ when thumbSizeValue != null => thumbSizeValue! / 2,
      _ => size.height / 2,
    };
    final double offsetY =
        -(radius + arrowHeight + pinDistance) + (size.height / 2 - thumbRadius);

    // Offset based on directionality.
    double offsetX = progressValue * size.width;

    switch (textDirection) {
      case TextDirection.rtl:
        offsetX = size.width - progressValue * size.width;
      case TextDirection.ltr:
        offsetX = progressValue * size.width;
    }

    // Assign colors.
    final Paint outerCirclePaint = Paint()..color = pinBorderColor;
    final Paint innerCirclePaint = Paint()..color = pinColor;
    final Paint thumbCirclePaint = Paint()..color = thumbColor;

    // Create outer circle with triangle path.
    final Path path = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius),
      )
      ..addOval(
        Rect.fromCircle(center: Offset(offsetX, offsetY), radius: radius),
      )
      ..moveTo(
        offsetX - arrowWidth / 2,
        offsetY + radius - 0.5,
      ) // shift the origin "up" by 0.5 to avoid aliasing
      ..lineTo(offsetX, offsetY + radius + arrowHeight)
      ..lineTo(
        offsetX + arrowWidth / 2,
        offsetY + radius - 0.5,
      ) // shift the destination "up" by 0.5 to avoid aliasing
      ..close();

    // Draw shadow around outer path.
    if (showShadow) {
      canvas.drawShadow(path, shadowColor, shadowElevation, false);
    }

    // Draw outer path.
    canvas.drawPath(path, outerCirclePaint);

    // Draw inner circle.
    canvas.drawCircle(
      Offset(offsetX, offsetY),
      radius - pinBorderWidth,
      innerCirclePaint,
    );

    // Draw thumb.
    canvas.drawCircle(
      Offset(offsetX, size.height / 2),
      thumbRadius,
      thumbCirclePaint,
    );

    // Draw pin text.
    final TextPainter pinTextPainter = TextPainter(
      text: TextSpan(text: pinText, style: textStyle),
      textDirection: textDirection,
    );

    pinTextPainter.layout();
    pinTextPainter.paint(
      canvas,
      Offset(
        offsetX - pinTextPainter.width / 2,
        offsetY - pinTextPainter.height / 2,
      ),
    );
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
        oldPainter.thumbSizeValue != thumbSizeValue ||
        oldPainter.showShadow != showShadow ||
        oldPainter.shadowColor != shadowColor ||
        oldPainter.shadowElevation != shadowElevation ||
        oldPainter.textDirection != textDirection;
  }
}
