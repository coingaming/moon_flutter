import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';
import 'package:moon_design/src/utils/squircle/squircle_radius.dart';

enum BorderAlign {
  inside,
  center,
  outside,
}

class MoonSquircleBorder extends OutlinedBorder {
  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  final MoonSquircleBorderRadius borderRadius;
  final BorderAlign borderAlign;

  const MoonSquircleBorder({
    super.side = MoonSquicleBorderSide.none,
    this.borderRadius = MoonSquircleBorderRadius.zero,
    this.borderAlign = BorderAlign.inside,
  });

  @override
  EdgeInsetsGeometry get dimensions {
    switch (borderAlign) {
      // Ensure that the border behaves like in Figma, i.e., without adding any
      // padding.
      case BorderAlign.inside:
        return EdgeInsets.zero;
      case BorderAlign.center:
        return EdgeInsets.zero;
      case BorderAlign.outside:
        return EdgeInsets.zero;
    }
  }

  @override
  ShapeBorder scale(double t) {
    return MoonSquircleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is MoonSquircleBorder) {
      return MoonSquircleBorder(
        side: MoonSquicleBorderSide.lerp(a.side, side, t),
        borderRadius: MoonSquircleBorderRadius.lerp(
          a.borderRadius,
          borderRadius,
          t,
        )!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is MoonSquircleBorder) {
      return MoonSquircleBorder(
        side: MoonSquicleBorderSide.lerp(side, b.side, t),
        borderRadius:
            MoonSquircleBorderRadius.lerp(borderRadius, b.borderRadius, t)!,
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
              MoonSquircleBorderRadius.all(
                MoonSquircleRadius(
                  cornerRadius: side.width,
                ),
              );
        case BorderAlign.center:
          return borderRadius -
              MoonSquircleBorderRadius.all(
                MoonSquircleRadius(
                  cornerRadius: side.width / 2,
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
    MoonSquircleBorderRadius radius, {
    TextDirection? textDirection,
  }) {
    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(rect));
    }

    return radius.toPath(rect);
  }

  @override
  MoonSquircleBorder copyWith({
    BorderSide? side,
    MoonSquircleBorderRadius? borderRadius,
    BorderAlign? borderAlign,
  }) {
    return MoonSquircleBorder(
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
        // Since the stroke is painted at the center of the border, we adjust
        // the rectangle based on the [borderAlign] to ensure the stroke is
        // properly positioned.
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
                  MoonSquircleBorderRadius.all(
                    MoonSquircleRadius(
                      cornerRadius: side.width / 2,
                    ),
                  );
            case BorderAlign.center:
              return borderRadius;
            case BorderAlign.outside:
              return borderRadius +
                  MoonSquircleBorderRadius.all(
                    MoonSquircleRadius(
                      cornerRadius: side.width / 2,
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
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is MoonSquircleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.borderAlign == borderAlign;
  }

  @override
  int get hashCode => Object.hash(side, borderRadius, borderAlign);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'MoonSquircleBorder')}($side, $borderRadius, $borderAlign)';
  }
}

class MoonSquicleBorderSide with Diagnosticable {
  /// This constant represents the border being drawn fully inside the border
  /// path.
  ///
  /// This is used as the default value for the [strokeAlign] property.
  static const double strokeAlignInside = -1.0;

  /// This constant represents the border being drawn along the center of the
  /// border path, with half of the [BorderSide.width] inside the path and the
  /// other half outside.
  ///
  /// This is used as a value for the [strokeAlign] property.
  static const double strokeAlignCenter = 0.0;

  /// This constant represents the border being drawn outside the border path.
  ///
  /// This is used as a value for the [strokeAlign] property.
  static const double strokeAlignOutside = 1.0;

  /// Creates a [BorderSide] representing the addition of the two provided
  /// [BorderSide]'s.
  ///
  /// This method should only be called if [canMerge] returns true for the two
  /// sides.
  ///
  /// If one side is zero-width with [BorderStyle.none], the other side is
  /// returned as is. If both sides are zero-width with [BorderStyle.none],
  /// [BorderSide.none] is returned.
  ///
  /// The arguments must not be null.
  static BorderSide merge(BorderSide a, BorderSide b) {
    assert(canMerge(a, b));
    final bool aIsNone = a.style == BorderStyle.none && a.width == 0.0;
    final bool bIsNone = b.style == BorderStyle.none && b.width == 0.0;
    if (aIsNone && bIsNone) {
      return BorderSide.none;
    }
    if (aIsNone) {
      return b;
    }
    if (bIsNone) {
      return a;
    }
    assert(a.color == b.color);
    assert(a.style == b.style);
    return BorderSide(
      color: a.color, // == b.color.
      width: a.width + b.width,
      strokeAlign: max(a.strokeAlign, b.strokeAlign),
      style: a.style, // == b.style.
    );
  }

  /// The color of this side of the border.
  final Color color;

  /// The width of this side of the border, in logical pixels.
  ///
  /// Setting width to 0.0 will result in a hairline border.
  /// This means that the border will have the width of one physical pixel.
  /// Hairline rendering takes shortcuts when the path overlaps a pixel more
  /// than once. This means that it will render faster than otherwise, but it
  /// might double-hit pixels, giving it a slightly darker/lighter result.
  ///
  /// To omit the border entirely, set the [style] to [BorderStyle.none].
  final double width;

  /// The style of this side of the border.
  ///
  /// To omit a side, set [style] to [BorderStyle.none].
  /// This skips painting the border, but the border still has a [width].
  final BorderStyle style;

  /// A hairline black border that is not rendered.
  static const BorderSide none = BorderSide.none;

  /// The relative position of the stroke on a [BorderSide] in an
  /// [OutlinedBorder] or [Border].
  ///
  /// Values typically range from -1.0 ([strokeAlignInside], inside border,
  /// default) to 1.0 ([strokeAlignOutside], outside border), without any
  /// bound constraints (e.g., a value of -2.0 is not typical, but allowed).
  /// A value of 0 ([strokeAlignCenter]) will center the border on the edge
  /// of the widget.
  ///
  /// When set to [strokeAlignInside], the stroke is drawn completely inside
  /// the widget. For [strokeAlignCenter] and [strokeAlignOutside], a property
  /// such as [Container.clipBehavior] can be used in an outside widget to clip
  /// it. If [Container.decoration] has a border, the container may incorporate
  /// [width] as additional padding:
  /// - [strokeAlignInside] provides padding with full [width].
  /// - [strokeAlignCenter] provides padding with half [width].
  /// - [strokeAlignOutside] provides zero padding, as stroke is drawn entirely
  /// outside.
  ///
  /// This property is not honored by [toPaint] (because the [Paint] object
  /// cannot represent it); it is intended that classes that use [BorderSide]
  /// objects implement this property when painting borders by suitably
  /// inflating or deflating their regions.
  ///
  /// {@tool dartpad}
  /// This example shows an animation of how [strokeAlign] affects the drawing
  /// when applied to borders of various shapes.
  ///
  /// ** See code in examples/api/lib/painting/borders/border_side.stroke_align.0.dart **
  /// {@end-tool}
  final double strokeAlign;

  /// Creates the side of a border with premultiplied alpha color.
  ///
  /// By default, the border is 1.0 logical pixels wide and solid black.
  const MoonSquicleBorderSide({
    this.color = const Color(0xFF000000),
    this.width = 1.0,
    this.style = BorderStyle.solid,
    this.strokeAlign = strokeAlignInside,
  }) : assert(width >= 0.0);

  /// Creates a copy of this border but with the given fields replaced with the
  /// new values.
  BorderSide copyWith({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return BorderSide(
      color: color ?? this.color,
      width: width ?? this.width,
      style: style ?? this.style,
      strokeAlign: strokeAlign ?? this.strokeAlign,
    );
  }

  /// Creates a copy of this border side description but with the width scaled
  /// by the factor 't'.
  ///
  /// The 't' argument represents the multiplicand, or the position on the
  /// timeline for an interpolation from nothing to 'this', with 0.0 meaning
  /// that the object returned should be the nil variant of this object, 1.0
  /// meaning that no change should be applied, returning 'this' (or something
  /// equivalent to 'this'), and other values meaning that the object should be
  /// multiplied by 't'. Negative values are treated like zero.
  ///
  /// Since a zero width is normally painted as a hairline width rather than no
  /// border at all, the zero factor is special-cased to instead change the
  /// style to [BorderStyle.none].
  ///
  /// Values for 't' are usually obtained from an [Animation<double>], such as
  /// an [AnimationController].
  BorderSide scale(double t) {
    return BorderSide(
      color: color,
      width: max(0.0, width * t),
      style: t <= 0.0 ? BorderStyle.none : style,
    );
  }

  /// Create a [Paint] object that, if used to stroke a line, will draw the line
  /// in this border's style.
  ///
  /// The [strokeAlign] property is not reflected in the [Paint]; consumers must
  /// implement that directly by inflating or deflating their region
  /// appropriately.
  ///
  /// Not all borders use this method to paint their border sides. For example,
  /// non-uniform rectangular [Border]s have beveled edges and so paint their
  /// border sides as filled shapes rather than using a stroke.
  Paint toPaint() {
    switch (style) {
      case BorderStyle.solid:
        return Paint()
          ..color = color
          ..strokeWidth = width
          ..style = PaintingStyle.stroke;
      case BorderStyle.none:
        return Paint()
          ..color = const Color(0x00000000)
          ..strokeWidth = 0.0
          ..style = PaintingStyle.stroke;
    }
  }

  /// Whether the two given [BorderSide]s can be merged using [BorderSide.merge].
  ///
  /// Two sides can be merged if one or both are zero-width with
  /// [BorderStyle.none], or if they both have the same color and style.
  ///
  /// The arguments must not be null.
  static bool canMerge(BorderSide a, BorderSide b) {
    if ((a.style == BorderStyle.none && a.width == 0.0) ||
        (b.style == BorderStyle.none && b.width == 0.0)) {
      return true;
    }
    return a.style == b.style && a.color == b.color;
  }

  /// Linearly interpolate between two border sides.
  ///
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static BorderSide lerp(BorderSide a, BorderSide b, double t) {
    if (identical(a, b)) {
      return a;
    }
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }
    final double width = lerpDouble(a.width, b.width, t)!;
    if (width < 0.0) {
      return BorderSide.none;
    }
    if (a.style == b.style && a.strokeAlign == b.strokeAlign) {
      return BorderSide(
        color: colorPremulLerp(a.color, b.color, t)!,
        width: width,
        style: a.style, // == b.style.
        strokeAlign: a.strokeAlign, // == b.strokeAlign.
      );
    }
    final Color colorA;
    final Color colorB;
    switch (a.style) {
      case BorderStyle.solid:
        colorA = a.color;
      case BorderStyle.none:
        colorA = a.color.withAlpha(0x00);
    }
    switch (b.style) {
      case BorderStyle.solid:
        colorB = b.color;
      case BorderStyle.none:
        colorB = b.color.withAlpha(0x00);
    }
    if (a.strokeAlign != b.strokeAlign) {
      return BorderSide(
        color: colorPremulLerp(colorA, colorB, t)!,
        width: width,
        strokeAlign: lerpDouble(a.strokeAlign, b.strokeAlign, t)!,
      );
    }
    return BorderSide(
      color: colorPremulLerp(colorA, colorB, t)!,
      width: width,
      strokeAlign: a.strokeAlign, // == b.strokeAlign
    );
  }

  /// Get the amount of the stroke width that lies inside of the [BorderSide].
  ///
  /// For example, this will return the [width] for a [strokeAlign] of -1, half
  /// the [width] for a [strokeAlign] of 0, and 0 for a [strokeAlign] of 1.
  double get strokeInset => width * (1 - (1 + strokeAlign) / 2);

  /// Get the amount of the stroke width that lies outside of the [BorderSide].
  ///
  /// For example, this will return 0 for a [strokeAlign] of -1, half the
  /// [width] for a [strokeAlign] of 0, and the [width] for a [strokeAlign]
  /// of 1.
  double get strokeOutset => width * (1 + strokeAlign) / 2;

  /// The offset of the stroke, taking into account the stroke alignment.
  ///
  /// For example, this will return the negative [width] of the stroke
  /// for a [strokeAlign] of -1, 0 for a [strokeAlign] of 0, and the
  /// [width] for a [strokeAlign] of -1.
  double get strokeOffset => width * strokeAlign;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is BorderSide &&
        other.color == color &&
        other.width == width &&
        other.style == style &&
        other.strokeAlign == strokeAlign;
  }

  @override
  int get hashCode => Object.hash(color, width, style, strokeAlign);

  @override
  String toStringShort() => 'BorderSide';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<Color>(
        'color',
        color,
        defaultValue: const Color(0xFF000000),
      ),
    );
    properties.add(
      DoubleProperty(
        'width',
        width,
        defaultValue: 1.0,
      ),
    );
    properties.add(
      DoubleProperty(
        'strokeAlign',
        strokeAlign,
        defaultValue: strokeAlignInside,
      ),
    );
    properties.add(
      EnumProperty<BorderStyle>(
        'style',
        style,
        defaultValue: BorderStyle.solid,
      ),
    );
  }
}
