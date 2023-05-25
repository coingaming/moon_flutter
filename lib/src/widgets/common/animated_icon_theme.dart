import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_tween_premul.dart';

class AnimatedIconTheme extends ImplicitlyAnimatedWidget {
  /// The target color for icon.
  ///
  /// The color must not be null.
  ///
  /// When this property is changed, the icon color will be animated over [duration] time.
  final Color? color;

  /// The target size for icon.
  ///
  /// The size must not be null.
  ///
  /// When this property is changed, the icon size will be animated over [duration] time.
  final double? size;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Creates a widget that animates the icon properties implicitly.
  ///
  /// The [child] and [duration] arguments must not be null.
  const AnimatedIconTheme({
    super.key,
    super.onEnd,
    super.curve,
    required super.duration,
    this.color,
    this.size,
    required this.child,
  });

  @override
  AnimatedWidgetBaseState<AnimatedIconTheme> createState() => _AnimatedIconThemeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('iconColor', color, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('iconSize', size, defaultValue: null));
  }
}

class _AnimatedIconThemeState extends AnimatedWidgetBaseState<AnimatedIconTheme> {
  ColorTweenWithPremultipliedAlpha? _color;
  SizeTween? _size;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (widget.color != null) {
      _color = visitor(_color, widget.color, (dynamic value) => ColorTweenWithPremultipliedAlpha(begin: value as Color))
          as ColorTweenWithPremultipliedAlpha?;
    }

    if (widget.size != null) {
      _size = visitor(_size, Size(widget.size!, widget.size!), (dynamic value) => SizeTween(begin: value as Size))
          as SizeTween?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: _color != null ? _color!.evaluate(animation) : null,
        size: _size != null ? _size!.evaluate(animation)!.height : null,
      ),
      child: widget.child,
    );
  }
}
