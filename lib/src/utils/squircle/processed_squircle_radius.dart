import 'dart:math' as math;

import 'package:moon_design/src/utils/squircle/squircle_radius.dart';
import 'package:vector_math/vector_math.dart' as vector;

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
    final cornerSmoothing = radius.cornerSmoothing;
    var cornerRadius = radius.cornerRadius;

    final maxRadius = math.min(width, height) / 2;
    cornerRadius = math.min(cornerRadius, maxRadius);

    // 12.2 from the article
    final p = math.min((1 + cornerSmoothing) * cornerRadius, maxRadius);

    final double angleAlpha;
    final double angleBeta;

    if (cornerRadius <= maxRadius / 2) {
      angleBeta = 90 * (1 - cornerSmoothing);
      angleAlpha = 45 * cornerSmoothing;
    } else {
      // When `cornerRadius` is larger and `maxRadius / 2`,
      // these angles also depend on `cornerRadius` and `maxRadius / 2`
      //
      // I did a few tests in Figma and this code generated similar but not identical results
      // `diffRatio` was called `change_percentage` in the orignal code
      final diffRatio = (cornerRadius - maxRadius / 2) / (maxRadius / 2);

      angleBeta = 90 * (1 - cornerSmoothing * (1 - diffRatio));
      angleAlpha = 45 * cornerSmoothing * (1 - diffRatio);
    }

    final angleTheta = (90 - angleBeta) / 2;

    // This was called `h_longest` in the original code
    // In the article this is the distance between 2 control points: P3 and P4
    final p3ToP4Distance = cornerRadius * math.tan(vector.radians(angleTheta / 2));

    // This was called `l` in the original code
    final circularSectionLength = math.sin(vector.radians(angleBeta / 2)) * cornerRadius * math.sqrt(2);

    // a, b, c and d are from 11.1 in the article
    final c = p3ToP4Distance * math.cos(vector.radians(angleAlpha));
    final d = c * math.tan(vector.radians(angleAlpha));
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
