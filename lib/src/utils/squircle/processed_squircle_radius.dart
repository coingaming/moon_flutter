import 'dart:math' as math;

import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

// The article from figma's blog
// https://www.figma.com/blog/desperately-seeking-squircles/
//
// The original code
// https://github.com/MartinRGB/Figma_Squircles_Approximation/blob/bf29714aab58c54329f3ca130ffa16d39a2ff08c/js/rounded-corners.js#L64
class ProcessedSquircleRadius {
  final MoonSquircleRadius radius;
  final double a;
  final double b;
  final double c;
  final double d;
  final double p;
  final double circularSectionLength;
  final double width;
  final double height;

  factory ProcessedSquircleRadius(
    MoonSquircleRadius radius, {
    required double width,
    required double height,
  }) {
    /// Constant factor to convert an angle from degrees to radians.
    const double degrees2Radians = math.pi / 180.0;

    /// Convert degrees to radians.
    double radians(double degrees) => degrees * degrees2Radians;

    final cornerSmoothing = radius.cornerSmoothing;
    var cornerRadius = radius.cornerRadius;

    final maxRadius = math.min(width, height) / 2;
    cornerRadius = math.min(cornerRadius, maxRadius);

    // 12.2 from the article.
    final p = math.min((1 + cornerSmoothing) * cornerRadius, maxRadius);

    final double angleAlpha;
    final double angleBeta;

    if (cornerRadius <= maxRadius / 2) {
      angleBeta = 90 * (1 - cornerSmoothing);
      angleAlpha = 45 * cornerSmoothing;
    } else {
      // When 'cornerRadius' exceeds 'maxRadius / 2', these angles also depend on 'cornerRadius' and 'maxRadius / 2'.
      //
      // After conducting several tests in Figma, this code produced similar, albeit not identical, results.
      // The 'diffRatio' was referred to as 'change_percentage' in the original code.
      final diffRatio = (cornerRadius - maxRadius / 2) / (maxRadius / 2);

      angleBeta = 90 * (1 - cornerSmoothing * (1 - diffRatio));
      angleAlpha = 45 * cornerSmoothing * (1 - diffRatio);
    }

    final angleTheta = (90 - angleBeta) / 2;

    // In the original code, this was referred to as 'h_longest'.
    // In the article, this represents the distance between two control points: P3 and P4.
    final p3ToP4Distance = cornerRadius * math.tan(radians(angleTheta / 2));

    // In the original code, this was referred to as 'l'.
    final circularSectionLength = math.sin(radians(angleBeta / 2)) * cornerRadius * math.sqrt(2);

    // The variables a, b, c, and d correspond to the values mentioned in section 11.1 of the article.
    final c = p3ToP4Distance * math.cos(radians(angleAlpha));
    final d = c * math.tan(radians(angleAlpha));
    final b = (p - circularSectionLength - c - d) / 3;
    final a = 2 * b;

    return ProcessedSquircleRadius._(
      a: a,
      b: b,
      c: c,
      d: d,
      p: p,
      width: width,
      height: height,
      radius: MoonSquircleRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: radius.cornerSmoothing,
      ),
      circularSectionLength: circularSectionLength,
    );
  }

  const ProcessedSquircleRadius._({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.p,
    required this.width,
    required this.height,
    required this.radius,
    required this.circularSectionLength,
  });

  double get cornerRadius => radius.cornerRadius;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is MoonSquircleRadius) {
      return other == radius;
    }
    if (other is ProcessedSquircleRadius) {
      return other.radius == radius;
    }

    return false;
  }

  @override
  int get hashCode => radius.hashCode;

  @override
  String toString() {
    return 'ProcessedSquircleRadius('
        'radius: $radius, '
        'a: ${a.toStringAsFixed(2)}, '
        'b: ${b.toStringAsFixed(2)}, '
        'c: ${c.toStringAsFixed(2)}, '
        'd: ${d.toStringAsFixed(2)}, '
        'p: ${p.toStringAsFixed(2)}, '
        'width: ${width.toStringAsFixed(2)}, '
        'height: ${height.toStringAsFixed(2)}, '
        ')';
  }
}
