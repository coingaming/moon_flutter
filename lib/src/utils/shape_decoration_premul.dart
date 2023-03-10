import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ShapeDecorationWithPremultipliedAlpha extends Decoration {
  /// The color to fill in the background of the shape.
  ///
  /// The color is under the [image].
  ///
  /// If a [gradient] is specified, [color] must be null.
  final Color? color;

  /// A gradient to use when filling the shape.
  ///
  /// The gradient is under the [image].
  ///
  /// If a [color] is specified, [gradient] must be null.
  final Gradient? gradient;

  /// An image to paint inside the shape (clipped to its outline).
  ///
  /// The image is drawn over the [color] or [gradient].
  final DecorationImage? image;

  /// A list of shadows cast by the [shape].
  ///
  /// See also:
  ///
  ///  * [kElevationToShadow], for some predefined shadows used in Material
  ///    Design.
  ///  * [PhysicalModel], a widget for showing shadows.
  final List<BoxShadow>? shadows;

  /// The shape to fill the [color], [gradient], and [image] into and to cast as
  /// the [shadows].
  ///
  /// Shapes can be stacked (using the `+` operator). The color, gradient, and
  /// image are drawn into the inner-most shape specified.
  ///
  /// The [shape] property specifies the outline (border) of the decoration. The
  /// shape must not be null.
  ///
  /// ## Directionality-dependent shapes
  ///
  /// Some [ShapeBorder] subclasses are sensitive to the [TextDirection]. The
  /// direction that is provided to the border (e.g. for its [ShapeBorder.paint]
  /// method) is the one specified in the [ImageConfiguration]
  /// ([ImageConfiguration.textDirection]) provided to the [BoxPainter] (via its
  /// [BoxPainter.paint method). The [BoxPainter] is obtained when
  /// [createBoxPainter] is called.
  ///
  /// When a [ShapeDecorationWithPremultipliedAlpha] is used with a [Container] widget or a
  /// [DecoratedBox] widget (which is what [Container] uses), the
  /// [TextDirection] specified in the [ImageConfiguration] is obtained from the
  /// ambient [Directionality], using [createLocalImageConfiguration].
  final ShapeBorder shape;

  /// Creates a shape decoration with premultiplied alpha for color lerp. In others respects,
  /// it is identical to [ShapeDecoration].
  ///
  /// * If [color] is null, this decoration does not paint a background color.
  /// * If [gradient] is null, this decoration does not paint gradients.
  /// * If [image] is null, this decoration does not paint a background image.
  /// * If [shadows] is null, this decoration does not paint a shadow.
  ///
  /// The [color] and [gradient] properties are mutually exclusive, one (or
  /// both) of them must be null.
  ///
  /// The [shape] must not be null.
  const ShapeDecorationWithPremultipliedAlpha({
    this.color,
    this.image,
    this.gradient,
    this.shadows,
    required this.shape,
  }) : assert(!(color != null && gradient != null));

  /// Creates a shape decoration configured to match a [BoxDecoration].
  ///
  /// The [BoxDecoration] class is more efficient for shapes that it can
  /// describe than the [ShapeDecorationWithPremultipliedAlpha] class is for those same shapes,
  /// because [ShapeDecorationWithPremultipliedAlpha] has to be more general as it can support any
  /// shape. However, having a [ShapeDecorationWithPremultipliedAlpha] is sometimes necessary, for
  /// example when calling [ShapeDecorationWithPremultipliedAlpha.lerp] to transition between
  /// different shapes (e.g. from a [CircleBorder] to a
  /// [RoundedRectangleBorder]; the [BoxDecoration] class cannot animate the
  /// transition from a [BoxShape.circle] to [BoxShape.rectangle]).
  factory ShapeDecorationWithPremultipliedAlpha.fromBoxDecoration(BoxDecoration source) {
    final ShapeBorder shape;

    switch (source.shape) {
      case BoxShape.circle:
        if (source.border != null) {
          assert(source.border!.isUniform);
          shape = CircleBorder(side: source.border!.top);
        } else {
          shape = const CircleBorder();
        }
        break;
      case BoxShape.rectangle:
        if (source.borderRadius != null) {
          assert(source.border == null || source.border!.isUniform);
          shape = RoundedRectangleBorder(
            side: source.border?.top ?? BorderSide.none,
            borderRadius: source.borderRadius!,
          );
        } else {
          shape = source.border ?? const Border();
        }
        break;
    }

    return ShapeDecorationWithPremultipliedAlpha(
      color: source.color,
      image: source.image,
      gradient: source.gradient,
      shadows: source.boxShadow,
      shape: shape,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return shape.getOuterPath(rect, textDirection: textDirection);
  }

  /// The inset space occupied by the [shape]'s border.
  ///
  /// This value may be misleading. See the discussion at [ShapeBorder.dimensions].
  @override
  EdgeInsetsGeometry get padding => shape.dimensions;

  @override
  bool get isComplex => shadows != null;

  @override
  ShapeDecorationWithPremultipliedAlpha? lerpFrom(Decoration? a, double t) {
    if (a is BoxDecoration) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(
        ShapeDecorationWithPremultipliedAlpha.fromBoxDecoration(a),
        this,
        t,
      );
    } else if (a == null || a is ShapeDecorationWithPremultipliedAlpha) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(a as ShapeDecorationWithPremultipliedAlpha?, this, t);
    }

    return super.lerpFrom(a, t) as ShapeDecorationWithPremultipliedAlpha?;
  }

  @override
  ShapeDecorationWithPremultipliedAlpha? lerpTo(Decoration? b, double t) {
    if (b is BoxDecoration) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(
        this,
        ShapeDecorationWithPremultipliedAlpha.fromBoxDecoration(b),
        t,
      );
    } else if (b == null || b is ShapeDecorationWithPremultipliedAlpha) {
      return ShapeDecorationWithPremultipliedAlpha.lerp(this, b as ShapeDecorationWithPremultipliedAlpha?, t);
    }

    return super.lerpTo(b, t) as ShapeDecorationWithPremultipliedAlpha?;
  }

  static Color _scaleAlpha(Color a, double factor) {
    return a.withAlpha((a.alpha * factor).round().clamp(0, 255));
  }

  /// This is a workaround for visual bug in Flutter caused by the Color.lerp method which is using straight alpha instead
  /// of premultiplied alpha leading to incorrect color lerping. Visually this manifests as a darker colored "hump" in
  /// the middle of the lerp when any of the lerped colors has low enough alpha on a light background. The lower the alpha
  /// value, the more pronounced the effect.
  ///
  /// This is a known issue in Flutter and is being tracked here: https://github.com/flutter/flutter/issues/48534
  static Color? _lerpColorWithPremulAlpha(Color? a, Color? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      } else {
        return _scaleAlpha(a, 1.0 - t);
      }
    } else {
      if (a == null) {
        return _scaleAlpha(b, t);
      } else {
        final weight1 = (1 - t) * a.opacity;
        final weight2 = t * b.opacity;
        final summedWeight = weight1 + weight2;
        final w = summedWeight > 0.000001 ? weight2 / summedWeight : 0.5;

        return Color.fromARGB(
          lerpDouble(a.alpha, b.alpha, t)!.toInt().clamp(0, 255),
          lerpDouble(a.red, b.red, w)!.toInt().clamp(0, 255),
          lerpDouble(a.green, b.green, w)!.toInt().clamp(0, 255),
          lerpDouble(a.blue, b.blue, w)!.toInt().clamp(0, 255),
        );
      }
    }
  }

  static ShapeDecorationWithPremultipliedAlpha? lerp(
    ShapeDecorationWithPremultipliedAlpha? a,
    ShapeDecorationWithPremultipliedAlpha? b,
    double t,
  ) {
    if (a == null && b == null) {
      return null;
    }

    if (a != null && b != null) {
      if (t == 0.0) {
        return a;
      }

      if (t == 1.0) {
        return b;
      }
    }

    return ShapeDecorationWithPremultipliedAlpha(
      //color: Color.lerp(a!.color, b!.color, t),
      color: _lerpColorWithPremulAlpha(a!.color, b!.color, t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t),
      image: t < 0.5 ? a.image : b.image,
      shadows: BoxShadow.lerpList(a.shadows, b.shadows, t),
      shape: ShapeBorder.lerp(a.shape, b.shape, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ShapeDecorationWithPremultipliedAlpha &&
        other.color == color &&
        other.gradient == gradient &&
        other.image == image &&
        listEquals<BoxShadow>(other.shadows, shadows) &&
        other.shape == shape;
  }

  @override
  int get hashCode => Object.hash(
        color,
        gradient,
        image,
        shape,
        shadows == null ? null : Object.hashAll(shadows!),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.whitespace;
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient, defaultValue: null));
    properties.add(DiagnosticsProperty<DecorationImage>('image', image, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape));
    properties.add(
      IterableProperty<BoxShadow>('shadows', shadows, defaultValue: null, style: DiagnosticsTreeStyle.whitespace),
    );
  }

  @override
  bool hitTest(Size size, Offset position, {TextDirection? textDirection}) {
    return shape.getOuterPath(Offset.zero & size, textDirection: textDirection).contains(position);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    assert(onChanged != null || image == null);
    return _ShapeDecorationPainter(this, onChanged!);
  }
}

/// An object that paints a [ShapeDecorationWithPremultipliedAlpha] into a canvas.
class _ShapeDecorationPainter extends BoxPainter {
  _ShapeDecorationPainter(this._decoration, VoidCallback onChanged) : super(onChanged);

  final ShapeDecorationWithPremultipliedAlpha _decoration;

  Rect? _lastRect;
  TextDirection? _lastTextDirection;
  late Path _outerPath;
  Path? _innerPath;
  Paint? _interiorPaint;
  int? _shadowCount;
  late List<Rect> _shadowBounds;
  late List<Path> _shadowPaths;
  late List<Paint> _shadowPaints;

  @override
  VoidCallback get onChanged => super.onChanged!;

  void _precache(Rect rect, TextDirection? textDirection) {
    if (rect == _lastRect && textDirection == _lastTextDirection) return;

    // We reach here in two cases:
    //  - the very first time we paint, in which case everything except _decoration is null
    //  - subsequent times, if the rect has changed, in which case we only need to update
    //    the features that depend on the actual rect.
    if (_interiorPaint == null && (_decoration.color != null || _decoration.gradient != null)) {
      _interiorPaint = Paint();
      if (_decoration.color != null) {
        _interiorPaint!.color = _decoration.color!;
      }
    }

    if (_decoration.gradient != null) {
      _interiorPaint!.shader = _decoration.gradient!.createShader(rect, textDirection: textDirection);
    }

    if (_decoration.shadows != null) {
      if (_shadowCount == null) {
        _shadowCount = _decoration.shadows!.length;
        _shadowPaints = <Paint>[
          ..._decoration.shadows!.map((BoxShadow shadow) => shadow.toPaint()),
        ];
      }

      if (_decoration.shape.preferPaintInterior) {
        _shadowBounds = <Rect>[
          ..._decoration.shadows!.map((BoxShadow shadow) {
            return rect.shift(shadow.offset).inflate(shadow.spreadRadius);
          }),
        ];
      } else {
        _shadowPaths = <Path>[
          ..._decoration.shadows!.map((BoxShadow shadow) {
            return _decoration.shape
                .getOuterPath(rect.shift(shadow.offset).inflate(shadow.spreadRadius), textDirection: textDirection);
          }),
        ];
      }
    }

    if (!_decoration.shape.preferPaintInterior && (_interiorPaint != null || _shadowCount != null)) {
      _outerPath = _decoration.shape.getOuterPath(rect, textDirection: textDirection);
    }

    if (_decoration.image != null) {
      _innerPath = _decoration.shape.getInnerPath(rect, textDirection: textDirection);
    }

    _lastRect = rect;
    _lastTextDirection = textDirection;
  }

  void _paintShadows(Canvas canvas, Rect rect, TextDirection? textDirection) {
    if (_shadowCount != null) {
      if (_decoration.shape.preferPaintInterior) {
        for (int index = 0; index < _shadowCount!; index += 1) {
          _decoration.shape
              .paintInterior(canvas, _shadowBounds[index], _shadowPaints[index], textDirection: textDirection);
        }
      } else {
        for (int index = 0; index < _shadowCount!; index += 1) {
          canvas.drawPath(_shadowPaths[index], _shadowPaints[index]);
        }
      }
    }
  }

  void _paintInterior(Canvas canvas, Rect rect, TextDirection? textDirection) {
    if (_interiorPaint != null) {
      if (_decoration.shape.preferPaintInterior) {
        _decoration.shape.paintInterior(canvas, rect, _interiorPaint!, textDirection: textDirection);
      } else {
        canvas.drawPath(_outerPath, _interiorPaint!);
      }
    }
  }

  DecorationImagePainter? _imagePainter;
  void _paintImage(Canvas canvas, ImageConfiguration configuration) {
    if (_decoration.image == null) return;

    _imagePainter ??= _decoration.image!.createPainter(onChanged);
    _imagePainter!.paint(canvas, _lastRect!, _innerPath, configuration);
  }

  @override
  void dispose() {
    _imagePainter?.dispose();
    super.dispose();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection? textDirection = configuration.textDirection;
    _precache(rect, textDirection);
    _paintShadows(canvas, rect, textDirection);
    _paintInterior(canvas, rect, textDirection);
    _paintImage(canvas, configuration);
    _decoration.shape.paint(canvas, rect, textDirection: textDirection);
  }
}
