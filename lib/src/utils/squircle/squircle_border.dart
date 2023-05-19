import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

enum BorderAlign {
  inside,
  center,
  outside,
}

class SquircleBorder extends OutlinedBorder {
  const SquircleBorder({
    super.side = BorderSide.none,
    this.borderRadius = SquircleBorderRadius.zero,
    this.borderAlign = BorderAlign.inside,
  });

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  final SquircleBorderRadius borderRadius;
  final BorderAlign borderAlign;

  @override
  EdgeInsetsGeometry get dimensions {
    switch (borderAlign) {
      case BorderAlign.inside:
        return EdgeInsets.all(side.width);
      case BorderAlign.center:
        return EdgeInsets.all(side.width / 2);
      case BorderAlign.outside:
        return EdgeInsets.zero;
    }
  }

  @override
  ShapeBorder scale(double t) {
    return SquircleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SquircleBorder) {
      return SquircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: SquircleBorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SquircleBorder) {
      return SquircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: SquircleBorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final innerRect = () {
      switch (borderAlign) {
        case BorderAlign.inside:
          return rect.deflate(side.width);
        case BorderAlign.center:
          return rect.deflate(side.width / 2);
        case BorderAlign.outside:
          return rect;
      }
    }();
    final radius = () {
      switch (borderAlign) {
        case BorderAlign.inside:
          return borderRadius -
              SquircleBorderRadius.all(
                SquircleRadius(
                  cornerRadius: side.width,
                  cornerSmoothing: 1.0,
                ),
              );
        case BorderAlign.center:
          return borderRadius -
              SquircleBorderRadius.all(
                SquircleRadius(
                  cornerRadius: side.width / 2,
                  cornerSmoothing: 1.0,
                ),
              );
        case BorderAlign.outside:
          return borderRadius;
      }
    }();

    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(innerRect));
    }

    return radius.toPath(innerRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, borderRadius, textDirection: textDirection);
  }

  Path _getPath(
    Rect rect,
    SquircleBorderRadius radius, {
    TextDirection? textDirection,
  }) {
    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(rect));
    }

    return radius.toPath(rect);
  }

  @override
  SquircleBorder copyWith({
    BorderSide? side,
    SquircleBorderRadius? borderRadius,
    BorderAlign? borderAlign,
  }) {
    return SquircleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      borderAlign: borderAlign ?? this.borderAlign,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        // Since the stroke is painted at the center, we need to adjust the rect
        // according to the [borderAlign].
        final adjustedRect = () {
          switch (borderAlign) {
            case BorderAlign.inside:
              return rect.deflate(side.width / 2);
            case BorderAlign.center:
              return rect;
            case BorderAlign.outside:
              return rect.inflate(side.width / 2);
          }
        }();
        final adjustedBorderRadius = () {
          switch (borderAlign) {
            case BorderAlign.inside:
              return borderRadius -
                  SquircleBorderRadius.all(
                    SquircleRadius(
                      cornerRadius: side.width / 2,
                      cornerSmoothing: 1.0,
                    ),
                  );
            case BorderAlign.center:
              return borderRadius;
            case BorderAlign.outside:
              return borderRadius +
                  SquircleBorderRadius.all(
                    SquircleRadius(
                      cornerRadius: side.width / 2,
                      cornerSmoothing: 1.0,
                    ),
                  );
          }
        }();

        final outerPath = _getPath(
          adjustedRect,
          adjustedBorderRadius,
          textDirection: textDirection,
        );

        canvas.drawPath(
          outerPath,
          side.toPaint(),
        );

        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is SquircleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.borderAlign == borderAlign;
  }

  @override
  int get hashCode => Object.hash(side, borderRadius, borderAlign);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'SquircleBorder')}($side, $borderRadius, $borderAlign)';
  }
}
