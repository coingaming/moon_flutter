import 'package:flutter/material.dart';

class MoonPlaceholderIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color? iconColor;
  final Color? containerBackgroundColor;

  const MoonPlaceholderIcon({
    super.key,
    this.width = 24,
    this.height = 24,
    this.iconColor,
    this.containerBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStrokeColor = iconColor ?? DefaultTextStyle.of(context).style.color ?? Colors.black;
    final effectiveSize = (DefaultTextStyle.of(context).style.fontSize ?? 14) <= 12 ? 20 : 24;

    return CustomPaint(
      size: Size(effectiveSize.toDouble(), effectiveSize.toDouble()),
      painter: _MoonPlaceholderIconPainter(
        strokeColor: effectiveStrokeColor,
      ),
    );
  }
}

class _MoonPlaceholderIconPainter extends CustomPainter {
  final Color? strokeColor;

  const _MoonPlaceholderIconPainter({this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.7283656, size.height * 0.3401438);
    path_0.cubicTo(
      size.width * 0.7662031,
      size.height * 0.3401438,
      size.width * 0.7968750,
      size.height * 0.3094716,
      size.width * 0.7968750,
      size.height * 0.2716347,
    );
    path_0.cubicTo(
      size.width * 0.7968750,
      size.height * 0.2337978,
      size.width * 0.7662031,
      size.height * 0.2031250,
      size.width * 0.7283656,
      size.height * 0.2031250,
    );
    path_0.cubicTo(
      size.width * 0.6905281,
      size.height * 0.2031250,
      size.width * 0.6598563,
      size.height * 0.2337978,
      size.width * 0.6598563,
      size.height * 0.2716347,
    );
    path_0.moveTo(size.width * 0.7283656, size.height * 0.3401438);
    path_0.cubicTo(
      size.width * 0.6905281,
      size.height * 0.3401438,
      size.width * 0.6598563,
      size.height * 0.3094716,
      size.width * 0.6598563,
      size.height * 0.2716347,
    );
    path_0.moveTo(size.width * 0.7283656, size.height * 0.3401438);
    path_0.lineTo(size.width * 0.7283656, size.height * 0.6598563);
    path_0.moveTo(size.width * 0.6598563, size.height * 0.2716347);
    path_0.lineTo(size.width * 0.3401438, size.height * 0.2716347);
    path_0.moveTo(size.width * 0.6598563, size.height * 0.7283656);
    path_0.cubicTo(
      size.width * 0.6598563,
      size.height * 0.7662031,
      size.width * 0.6905281,
      size.height * 0.7968750,
      size.width * 0.7283656,
      size.height * 0.7968750,
    );
    path_0.cubicTo(
      size.width * 0.7662031,
      size.height * 0.7968750,
      size.width * 0.7968750,
      size.height * 0.7662031,
      size.width * 0.7968750,
      size.height * 0.7283656,
    );
    path_0.cubicTo(
      size.width * 0.7968750,
      size.height * 0.6905281,
      size.width * 0.7662031,
      size.height * 0.6598563,
      size.width * 0.7283656,
      size.height * 0.6598563,
    );
    path_0.moveTo(size.width * 0.6598563, size.height * 0.7283656);
    path_0.cubicTo(
      size.width * 0.6598563,
      size.height * 0.6905281,
      size.width * 0.6905281,
      size.height * 0.6598563,
      size.width * 0.7283656,
      size.height * 0.6598563,
    );
    path_0.moveTo(size.width * 0.6598563, size.height * 0.7283656);
    path_0.lineTo(size.width * 0.3401438, size.height * 0.7283656);
    path_0.moveTo(size.width * 0.3401438, size.height * 0.2716347);
    path_0.cubicTo(
      size.width * 0.3401438,
      size.height * 0.3094716,
      size.width * 0.3094716,
      size.height * 0.3401438,
      size.width * 0.2716347,
      size.height * 0.3401438,
    );
    path_0.moveTo(size.width * 0.3401438, size.height * 0.2716347);
    path_0.cubicTo(
      size.width * 0.3401438,
      size.height * 0.2337978,
      size.width * 0.3094716,
      size.height * 0.2031250,
      size.width * 0.2716347,
      size.height * 0.2031250,
    );
    path_0.cubicTo(
      size.width * 0.2337978,
      size.height * 0.2031250,
      size.width * 0.2031250,
      size.height * 0.2337978,
      size.width * 0.2031250,
      size.height * 0.2716347,
    );
    path_0.cubicTo(
      size.width * 0.2031250,
      size.height * 0.3094716,
      size.width * 0.2337978,
      size.height * 0.3401438,
      size.width * 0.2716347,
      size.height * 0.3401438,
    );
    path_0.moveTo(size.width * 0.2716347, size.height * 0.3401438);
    path_0.lineTo(size.width * 0.2716347, size.height * 0.6598563);
    path_0.moveTo(size.width * 0.3401438, size.height * 0.7283656);
    path_0.cubicTo(
      size.width * 0.3401438,
      size.height * 0.7662031,
      size.width * 0.3094716,
      size.height * 0.7968750,
      size.width * 0.2716347,
      size.height * 0.7968750,
    );
    path_0.cubicTo(
      size.width * 0.2337978,
      size.height * 0.7968750,
      size.width * 0.2031250,
      size.height * 0.7662031,
      size.width * 0.2031250,
      size.height * 0.7283656,
    );
    path_0.cubicTo(
      size.width * 0.2031250,
      size.height * 0.6905281,
      size.width * 0.2337978,
      size.height * 0.6598563,
      size.width * 0.2716347,
      size.height * 0.6598563,
    );
    path_0.moveTo(size.width * 0.3401438, size.height * 0.7283656);
    path_0.cubicTo(
      size.width * 0.3401438,
      size.height * 0.6905281,
      size.width * 0.3094716,
      size.height * 0.6598563,
      size.width * 0.2716347,
      size.height * 0.6598563,
    );

    final Paint paint0stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    paint0stroke.color = strokeColor ?? Colors.black;
    paint0stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_0, paint0stroke);

    final Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Colors.transparent;
    canvas.drawPath(path_0, paint0fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
