// ignore_for_file: overridden_fields, unused_element

import 'package:flutter/rendering.dart';

import 'package:moon_design/src/utils/squircle/path_squircle_corners.dart';
import 'package:moon_design/src/utils/squircle/processed_squircle_radius.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

class MoonSquircleBorderRadius extends BorderRadius {
  /// A border radius with all zero radii.
  static const MoonSquircleBorderRadius zero = MoonSquircleBorderRadius.all(MoonSquircleRadius.zero);

  /// The top-left [MoonSquircleRadius].
  @override
  final MoonSquircleRadius topLeft;

  /// The top-right [MoonSquircleRadius].
  @override
  final MoonSquircleRadius topRight;

  /// The bottom-left [MoonSquircleRadius].
  @override
  final MoonSquircleRadius bottomLeft;

  /// The bottom-right [MoonSquircleRadius].
  @override
  final MoonSquircleRadius bottomRight;

  MoonSquircleBorderRadius({
    required double cornerRadius,
    // The value of 1 or 1.0 lead to NaN error in mobile web/PWA for some reason. So we use 0.99 instead.
    double cornerSmoothing = 0.99,
  }) : this.only(
          topLeft: MoonSquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          topRight: MoonSquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomLeft: MoonSquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomRight: MoonSquircleRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
        );

  /// Creates a border radius where all radii are [radius].
  const MoonSquircleBorderRadius.all(MoonSquircleRadius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  /// Creates a vertically symmetric border radius where the top and bottom
  /// sides of the rectangle have the same radii.
  const MoonSquircleBorderRadius.vertical({
    MoonSquircleRadius top = MoonSquircleRadius.zero,
    MoonSquircleRadius bottom = MoonSquircleRadius.zero,
  }) : this.only(
          topLeft: top,
          topRight: top,
          bottomLeft: bottom,
          bottomRight: bottom,
        );

  /// Creates a horizontally symmetrical border radius where the left and right
  /// sides of the rectangle have the same radii.
  const MoonSquircleBorderRadius.horizontal({
    MoonSquircleRadius left = MoonSquircleRadius.zero,
    MoonSquircleRadius right = MoonSquircleRadius.zero,
  }) : this.only(
          topLeft: left,
          topRight: right,
          bottomLeft: left,
          bottomRight: right,
        );

  /// Creates a border radius with only the given non-zero values. The other
  /// corners will be right angles.
  const MoonSquircleBorderRadius.only({
    this.topLeft = MoonSquircleRadius.zero,
    this.topRight = MoonSquircleRadius.zero,
    this.bottomLeft = MoonSquircleRadius.zero,
    this.bottomRight = MoonSquircleRadius.zero,
  }) : super.only(
          topLeft: topLeft,
          bottomRight: topRight,
          topRight: topRight,
          bottomLeft: bottomLeft,
        );

  /// Needed by internals of Flutter framework.
  Radius get _topLeft => topLeft;
  Radius get _topRight => topRight;
  Radius get _bottomLeft => bottomLeft;
  Radius get _bottomRight => bottomRight;
  Radius get _topStart => Radius.zero;
  Radius get _topEnd => Radius.zero;
  Radius get _bottomStart => Radius.zero;
  Radius get _bottomEnd => Radius.zero;

  /// Returns a copy of this BorderRadius with the given fields replaced with
  /// the new values.
  @override
  MoonSquircleBorderRadius copyWith({
    Radius? topLeft,
    Radius? topRight,
    Radius? bottomLeft,
    Radius? bottomRight,
  }) {
    return MoonSquircleBorderRadius.only(
      topLeft: topLeft is MoonSquircleRadius ? topLeft : this.topLeft,
      topRight: topRight is MoonSquircleRadius ? topRight : this.topRight,
      bottomLeft: bottomLeft is MoonSquircleRadius ? bottomLeft : this.bottomLeft,
      bottomRight: bottomRight is MoonSquircleRadius ? bottomRight : this.bottomRight,
    );
  }

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
    if (other is MoonSquircleBorderRadius) return this - other;
    return super.subtract(other);
  }

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) {
    if (other is MoonSquircleBorderRadius) return this + other;
    return super.add(other);
  }

  /// Returns the difference between two [BorderRadius] objects.
  @override
  MoonSquircleBorderRadius operator -(BorderRadius other) {
    if (other is MoonSquircleBorderRadius) {
      return MoonSquircleBorderRadius.only(
        topLeft: (topLeft - other.topLeft) as MoonSquircleRadius,
        topRight: (topRight - other.topRight) as MoonSquircleRadius,
        bottomLeft: (bottomLeft - other.bottomLeft) as MoonSquircleRadius,
        bottomRight: (bottomRight - other.bottomRight) as MoonSquircleRadius,
      );
    }

    return this;
  }

  /// Returns the sum of two [BorderRadius] objects.
  @override
  MoonSquircleBorderRadius operator +(BorderRadius other) {
    if (other is MoonSquircleBorderRadius) {
      return MoonSquircleBorderRadius.only(
        topLeft: (topLeft + other.topLeft) as MoonSquircleRadius,
        topRight: (topRight + other.topRight) as MoonSquircleRadius,
        bottomLeft: (bottomLeft + other.bottomLeft) as MoonSquircleRadius,
        bottomRight: (bottomRight + other.bottomRight) as MoonSquircleRadius,
      );
    }

    return this;
  }

  /// Returns the [BorderRadius] object with each corner negated.
  ///
  /// This is the same as multiplying the object by -1.0.
  @override
  MoonSquircleBorderRadius operator -() {
    return MoonSquircleBorderRadius.only(
      topLeft: (-topLeft) as MoonSquircleRadius,
      topRight: (-topRight) as MoonSquircleRadius,
      bottomLeft: (-bottomLeft) as MoonSquircleRadius,
      bottomRight: (-bottomRight) as MoonSquircleRadius,
    );
  }

  /// Scales each corner of the [BorderRadius] by the given factor.
  @override
  MoonSquircleBorderRadius operator *(double other) {
    return MoonSquircleBorderRadius.only(
      topLeft: topLeft * other,
      topRight: topRight * other,
      bottomLeft: bottomLeft * other,
      bottomRight: bottomRight * other,
    );
  }

  /// Divides each corner of the [BorderRadius] by the given factor.
  @override
  MoonSquircleBorderRadius operator /(double other) {
    return MoonSquircleBorderRadius.only(
      topLeft: topLeft / other,
      topRight: topRight / other,
      bottomLeft: bottomLeft / other,
      bottomRight: bottomRight / other,
    );
  }

  /// Integer divides each corner of the [BorderRadius] by the given factor.
  @override
  MoonSquircleBorderRadius operator ~/(double other) {
    return MoonSquircleBorderRadius.only(
      topLeft: topLeft ~/ other,
      topRight: topRight ~/ other,
      bottomLeft: bottomLeft ~/ other,
      bottomRight: bottomRight ~/ other,
    );
  }

  /// Computes the remainder of each corner by the given factor.
  @override
  MoonSquircleBorderRadius operator %(double other) {
    return MoonSquircleBorderRadius.only(
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
  static MoonSquircleBorderRadius? lerp(MoonSquircleBorderRadius? a, MoonSquircleBorderRadius? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return MoonSquircleBorderRadius.only(
      topLeft: MoonSquircleRadius.lerp(a.topLeft, b.topLeft, t)!,
      topRight: MoonSquircleRadius.lerp(a.topRight, b.topRight, t)!,
      bottomLeft: MoonSquircleRadius.lerp(a.bottomLeft, b.bottomLeft, t)!,
      bottomRight: MoonSquircleRadius.lerp(a.bottomRight, b.bottomRight, t)!,
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
      return 'MoonSquircleBorderRadius${radius.substring(12)}';
    }

    return 'MoonSquircleBorderRadius('
        'topLeft: $topLeft, '
        'topRight: $topRight, '
        'bottomLeft: $bottomLeft, '
        'bottomRight: $bottomRight, '
        ')';
  }
}
