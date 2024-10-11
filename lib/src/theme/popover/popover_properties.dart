import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonPopoverProperties extends ThemeExtension<MoonPopoverProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonPopover.
  final BorderRadiusGeometry borderRadius;

  /// The distance between the MoonPopover and the target child widget.
  final double distanceToTarget;

  /// The duration of the MoonPopover transition animation (fade in or out).
  final Duration transitionDuration;

  /// The curve of the MoonPopover transition animation (fade in or out).
  final Curve transitionCurve;

  /// The padding of the MoonPopover content.
  final EdgeInsetsGeometry contentPadding;

  /// The text style of the MoonPopover.
  final TextStyle textStyle;

  const MoonPopoverProperties({
    required this.borderRadius,
    required this.distanceToTarget,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.contentPadding,
    required this.textStyle,
  });

  @override
  MoonPopoverProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? distanceToTarget,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
  }) {
    return MoonPopoverProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      distanceToTarget: distanceToTarget ?? this.distanceToTarget,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      contentPadding: contentPadding ?? this.contentPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonPopoverProperties lerp(
    ThemeExtension<MoonPopoverProperties>? other,
    double t,
  ) {
    if (other is! MoonPopoverProperties) return this;

    return MoonPopoverProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      distanceToTarget:
          lerpDouble(distanceToTarget, other.distanceToTarget, t)!,
      transitionDuration:
          lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonPopoverProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(
        DoubleProperty("distanceToTarget", distanceToTarget),
      )
      ..add(
        DiagnosticsProperty<Duration>("transitionDuration", transitionDuration),
      )
      ..add(
        DiagnosticsProperty<Curve>("transitionCurve", transitionCurve),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>(
          "contentPadding",
          contentPadding,
        ),
      )
      ..add(
        DiagnosticsProperty<TextStyle>(
          "textStyle",
          textStyle,
        ),
      );
  }
}
