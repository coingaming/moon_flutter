// ignore_for_file: overridden_fields, unused_element

import 'package:flutter/rendering.dart';

import 'package:moon_design/src/utils/squircle/path_squircle_corners.dart';
import 'package:moon_design/src/utils/squircle/processed_squircle_radius.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

class SquircleBorderRadius extends BorderRadius {
  SquircleBorderRadius({
    required double cornerRadius,
    double cornerSmoothing = 0,
  }) : this.only(
          topLeft: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          topRight: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomLeft: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomRight: SquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
        );

  /// Creates a border radius where all radii are [radius].

  const SquircleBorderRadius.all(SquircleRadius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  /// Creates a vertically symmetric border radius where the top and bottom
  /// sides of the rectangle have the same radii.
  const SquircleBorderRadius.vertical({
    SquircleRadius top = SquircleRadius.zero,
    SquircleRadius bottom = SquircleRadius.zero,
  }) : this.only(
          topLeft: top,
          topRight: top,
          bottomLeft: bottom,
          bottomRight: bottom,
        );

  /// Creates a horizontally symmetrical border radius where the left and right
  /// sides of the rectangle have the same radii.
  const SquircleBorderRadius.horizontal({
    SquircleRadius left = SquircleRadius.zero,
    SquircleRadius right = SquircleRadius.zero,
  }) : this.only(
          topLeft: left,
          topRight: right,
          bottomLeft: left,
          bottomRight: right,
        );

  /// Creates a border radius with only the given non-zero values. The other
  /// corners will be right angles.
  const SquircleBorderRadius.only({
    this.topLeft = SquircleRadius.zero,
    this.topRight = SquircleRadius.zero,
    this.bottomLeft = SquircleRadius.zero,
    this.bottomRight = SquircleRadius.zero,
  }) : super.only(
          topLeft: topLeft,
          bottomRight: topRight,
          topRight: topRight,
          bottomLeft: bottomLeft,
        );

  /// Returns a copy of this BorderRadius with the given fields replaced with
  /// the new values.
  @override
  SquircleBorderRadius copyWith({
    Radius? topLeft,
    Radius? topRight,
    Radius? bottomLeft,
    Radius? bottomRight,
  }) {
    return SquircleBorderRadius.only(
      topLeft: topLeft is SquircleRadius ? topLeft : this.topLeft,
      topRight: topRight is SquircleRadius ? topRight : this.topRight,
      bottomLeft: bottomLeft is SquircleRadius ? bottomLeft : this.bottomLeft,
      bottomRight: bottomRight is SquircleRadius ? bottomRight : this.bottomRight,
    );
  }

  /// A border radius with all zero radii.
  static const SquircleBorderRadius zero = SquircleBorderRadius.all(SquircleRadius.zero);

  /// The top-left [SquircleRadius].
  @override
  final SquircleRadius topLeft;

  /// The top-right [SquircleRadius].
  @override
  final SquircleRadius topRight;

  /// The bottom-left [SquircleRadius].
  @override
  final SquircleRadius bottomLeft;

  /// The bottom-right [SquircleRadius].
  @override
  final SquircleRadius bottomRight;

  /// Needed by internals of Flutter framework.
  Radius get _topLeft => topLeft;
  Radius get _topRight => topRight;
  Radius get _bottomLeft => bottomLeft;
  Radius get _bottomRight => bottomRight;
  Radius get _topStart => Radius.zero;
  Radius get _topEnd => Radius.zero;
  Radius get _bottomStart => Radius.zero;
  Radius get _bottomEnd => Radius.zero;

  /// Creates a [Path] inside the given [Rect].
  Path toPath(Rect rect) {
    final width = rect.width;
    final height = rect.height;

    final result = Path();

    /// Calculating only if values are different
    final processedTopLeft = ProcessedSquircleRadius(
      topLeft,
      width: width,
      height: height,
    );

    final processedBottomLeft = topLeft == bottomLeft
        ? processedTopLeft
        : ProcessedSquircleRadius(
            bottomLeft,
            width: width,
            height: height,
          );

    final processedBottomRight = bottomLeft == bottomRight
        ? processedBottomLeft
        : ProcessedSquircleRadius(
            bottomRight,
            width: width,
            height: height,
          );

    final processedTopRight = topRight == bottomRight
        ? processedBottomRight
        : ProcessedSquircleRadius(
            topRight,
            width: width,
            height: height,
          );

    result
      ..addSmoothTopRight(processedTopRight, rect)
      ..addSmoothBottomRight(processedBottomRight, rect)
      ..addSmoothBottomLeft(processedBottomLeft, rect)
      ..addSmoothTopLeft(processedTopLeft, rect);

    return result.transform(
      Matrix4.translationValues(rect.left, rect.top, 0).storage,
    );
  }

  @override
  BorderRadiusGeometry subtract(BorderRadiusGeometry other) {
    if (other is SquircleBorderRadius) return this - other;
    return super.subtract(other);
  }

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) {
    if (other is SquircleBorderRadius) return this + other;
    return super.add(other);
  }

  /// Returns the difference between two [BorderRadius] objects.
  @override
  SquircleBorderRadius operator -(BorderRadius other) {
    if (other is SquircleBorderRadius) {
      return SquircleBorderRadius.only(
        topLeft: (topLeft - other.topLeft) as SquircleRadius,
        topRight: (topRight - other.topRight) as SquircleRadius,
        bottomLeft: (bottomLeft - other.bottomLeft) as SquircleRadius,
        bottomRight: (bottomRight - other.bottomRight) as SquircleRadius,
      );
    }

    return this;
  }

  /// Returns the sum of two [BorderRadius] objects.
  @override
  SquircleBorderRadius operator +(BorderRadius other) {
    if (other is SquircleBorderRadius) {
      return SquircleBorderRadius.only(
        topLeft: (topLeft + other.topLeft) as SquircleRadius,
        topRight: (topRight + other.topRight) as SquircleRadius,
        bottomLeft: (bottomLeft + other.bottomLeft) as SquircleRadius,
        bottomRight: (bottomRight + other.bottomRight) as SquircleRadius,
      );
    }

    return this;
  }

  /// Returns the [BorderRadius] object with each corner negated.
  ///
  /// This is the same as multiplying the object by -1.0.
  @override
  SquircleBorderRadius operator -() {
    return SquircleBorderRadius.only(
      topLeft: (-topLeft) as SquircleRadius,
      topRight: (-topRight) as SquircleRadius,
      bottomLeft: (-bottomLeft) as SquircleRadius,
      bottomRight: (-bottomRight) as SquircleRadius,
    );
  }

  /// Scales each corner of the [BorderRadius] by the given factor.
  @override
  SquircleBorderRadius operator *(double other) {
    return SquircleBorderRadius.only(
      topLeft: topLeft * other,
      topRight: topRight * other,
      bottomLeft: bottomLeft * other,
      bottomRight: bottomRight * other,
    );
  }

  /// Divides each corner of the [BorderRadius] by the given factor.
  @override
  SquircleBorderRadius operator /(double other) {
    return SquircleBorderRadius.only(
      topLeft: topLeft / other,
      topRight: topRight / other,
      bottomLeft: bottomLeft / other,
      bottomRight: bottomRight / other,
    );
  }

  /// Integer divides each corner of the [BorderRadius] by the given factor.
  @override
  SquircleBorderRadius operator ~/(double other) {
    return SquircleBorderRadius.only(
      topLeft: topLeft ~/ other,
      topRight: topRight ~/ other,
      bottomLeft: bottomLeft ~/ other,
      bottomRight: bottomRight ~/ other,
    );
  }

  /// Computes the remainder of each corner by the given factor.
  @override
  SquircleBorderRadius operator %(double other) {
    return SquircleBorderRadius.only(
      topLeft: topLeft % other,
      topRight: topRight % other,
      bottomLeft: bottomLeft % other,
      bottomRight: bottomRight % other,
    );
  }

  /// Linearly interpolate between two [BorderRadius] objects.
  ///
  /// If either is null, this function interpolates from [BorderRadius.zero].
  ///
  /// {@macro dart.ui.shadow.lerp}
  static SquircleBorderRadius? lerp(SquircleBorderRadius? a, SquircleBorderRadius? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return SquircleBorderRadius.only(
      topLeft: SquircleRadius.lerp(a.topLeft, b.topLeft, t)!,
      topRight: SquircleRadius.lerp(a.topRight, b.topRight, t)!,
      bottomLeft: SquircleRadius.lerp(a.bottomLeft, b.bottomLeft, t)!,
      bottomRight: SquircleRadius.lerp(a.bottomRight, b.bottomRight, t)!,
    );
  }

  @override
  BorderRadius resolve(TextDirection? direction) => BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      );

  @override
  String toString() {
    if (topLeft == topRight && topLeft == bottomRight && topLeft == bottomLeft) {
      final radius = topLeft.toString();
      return 'SquircleBorderRadius${radius.substring(12)}';
    }

    return 'SquircleBorderRadius('
        'topLeft: $topLeft, '
        'topRight: $topRight, '
        'bottomLeft: $bottomLeft, '
        'bottomRight: $bottomRight, '
        ')';
  }
}
