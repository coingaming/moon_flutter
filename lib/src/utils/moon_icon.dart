import 'package:flutter/material.dart';

class MoonBrandIcon extends StatelessWidget {
  final double width;
  final double height;

  const MoonBrandIcon({
    super.key,
    this.width = 24,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _MoonBrandIconPainter(),
    );
  }
}

class _MoonBrandIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.3778988, size.height * 0.6000000);
    path_0.cubicTo(
      size.width * 0.4251542,
      size.height * 0.6000000,
      size.width * 0.4634583,
      size.height * 0.5608250,
      size.width * 0.4634583,
      size.height * 0.5125000,
    );
    path_0.cubicTo(
      size.width * 0.4634583,
      size.height * 0.4641750,
      size.width * 0.4251542,
      size.height * 0.4250000,
      size.width * 0.3778988,
      size.height * 0.4250000,
    );
    path_0.cubicTo(
      size.width * 0.3306446,
      size.height * 0.4250000,
      size.width * 0.2923379,
      size.height * 0.4641750,
      size.width * 0.2923379,
      size.height * 0.5125000,
    );
    path_0.cubicTo(
      size.width * 0.2923379,
      size.height * 0.5608250,
      size.width * 0.3306446,
      size.height * 0.6000000,
      size.width * 0.3778988,
      size.height * 0.6000000,
    );
    path_0.close();
    path_0.moveTo(size.width * 0.3778988, size.height * 0.7750000);
    path_0.cubicTo(
      size.width * 0.5196625,
      size.height * 0.7750000,
      size.width * 0.6345833,
      size.height * 0.6574750,
      size.width * 0.6345833,
      size.height * 0.5125000,
    );
    path_0.cubicTo(
      size.width * 0.6345833,
      size.height * 0.3675254,
      size.width * 0.5196625,
      size.height * 0.2500000,
      size.width * 0.3778988,
      size.height * 0.2500000,
    );
    path_0.cubicTo(
      size.width * 0.2361367,
      size.height * 0.2500000,
      size.width * 0.1212158,
      size.height * 0.3675254,
      size.width * 0.1212158,
      size.height * 0.5125000,
    );
    path_0.cubicTo(
      size.width * 0.1212158,
      size.height * 0.6574750,
      size.width * 0.2361367,
      size.height * 0.7750000,
      size.width * 0.3778988,
      size.height * 0.7750000,
    );
    path_0.close();

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    final Path path_1 = Path();
    path_1.moveTo(size.width * 0.8484917, size.height * 0.3375000);
    path_1.cubicTo(
      size.width * 0.8484917,
      size.height * 0.3858250,
      size.width * 0.8101833,
      size.height * 0.4250000,
      size.width * 0.7629292,
      size.height * 0.4250000,
    );
    path_1.cubicTo(
      size.width * 0.7156750,
      size.height * 0.4250000,
      size.width * 0.6773667,
      size.height * 0.3858250,
      size.width * 0.6773667,
      size.height * 0.3375000,
    );
    path_1.cubicTo(
      size.width * 0.6773667,
      size.height * 0.2891750,
      size.width * 0.7156750,
      size.height * 0.2500000,
      size.width * 0.7629292,
      size.height * 0.2500000,
    );
    path_1.cubicTo(
      size.width * 0.8101833,
      size.height * 0.2500000,
      size.width * 0.8484917,
      size.height * 0.2891750,
      size.width * 0.8484917,
      size.height * 0.3375000,
    );
    path_1.close();

    final Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
