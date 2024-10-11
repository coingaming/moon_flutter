import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonModalProperties extends ThemeExtension<MoonModalProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonModal.
  final BorderRadiusGeometry borderRadius;

  /// The duration of the MoonModal transition animation (fade in or out).
  final Duration transitionDuration;

  /// The curve of the MoonModal transition animation (fade in or out).
  final Curve transitionCurve;

  /// The text style of the MoonModal.
  final TextStyle textStyle;

  const MoonModalProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.textStyle,
  });

  @override
  MoonModalProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? textStyle,
  }) {
    return MoonModalProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonModalProperties lerp(
    ThemeExtension<MoonModalProperties>? other,
    double t,
  ) {
    if (other is! MoonModalProperties) return this;

    return MoonModalProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration:
          lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonModalProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(
        DiagnosticsProperty<Duration>("transitionDuration", transitionDuration),
      )
      ..add(
        DiagnosticsProperty<Curve>("transitionCurve", transitionCurve),
      )
      ..add(
        DiagnosticsProperty<TextStyle>("textStyle", textStyle),
      );
  }
}
