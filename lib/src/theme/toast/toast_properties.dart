import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonToastProperties extends ThemeExtension<MoonToastProperties> with DiagnosticableTreeMixin {
  /// Toast border radius.
  final BorderRadiusGeometry borderRadius;

  /// The horizontal space between toast leading, trailing and label.
  final double horizontalGap;

  /// The vertical space between toast header and body.
  final double verticalGap;

  /// Toast display duration.
  final Duration displayDuration;

  /// Toast transition duration.
  final Duration transitionDuration;

  /// Toast transition curve.
  final Curve transitionCurve;

  /// Padding around toast content.
  final EdgeInsetsGeometry contentPadding;

  /// Toast text style.
  final TextStyle textStyle;

  const MoonToastProperties({
    required this.borderRadius,
    required this.horizontalGap,
    required this.verticalGap,
    required this.displayDuration,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.contentPadding,
    required this.textStyle,
  });

  @override
  MoonToastProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? horizontalGap,
    double? verticalGap,
    Duration? displayDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
  }) {
    return MoonToastProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      horizontalGap: horizontalGap ?? this.horizontalGap,
      verticalGap: verticalGap ?? this.verticalGap,
      displayDuration: displayDuration ?? this.displayDuration,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      contentPadding: contentPadding ?? this.contentPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonToastProperties lerp(ThemeExtension<MoonToastProperties>? other, double t) {
    if (other is! MoonToastProperties) return this;

    return MoonToastProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      displayDuration: lerpDuration(displayDuration, other.displayDuration, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonToastProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("horizontalGap", horizontalGap))
      ..add(DiagnosticsProperty<Duration>("displayDuration", displayDuration))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
