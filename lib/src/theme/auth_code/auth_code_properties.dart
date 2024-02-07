import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAuthCodeProperties extends ThemeExtension<MoonAuthCodeProperties> with DiagnosticableTreeMixin {
  /// The border radius of the MoonAuthCode input field.
  final BorderRadiusGeometry borderRadius;

  /// The horizontal gap between the MoonAuthCode input fields.
  final double gap;

  /// The height of the MoonAuthCode input field.
  final double height;

  /// The width of the MoonAuthCode input field.
  final double width;

  /// The duration of the MoonAuthCode input field transition animation.
  final Duration animationDuration;

  /// The duration of the MoonAuthCode error state animation.
  final Duration errorAnimationDuration;

  /// The duration to display the typed character before it is obscured.
  final Duration peekDuration;

  /// The curve of the MoonAuthCode input field transition animation.
  final Curve animationCurve;

  /// The curve of the MoonAuthCode error state animation.
  final Curve errorAnimationCurve;

  /// The text style of the MoonAuthCode.
  final TextStyle textStyle;

  /// The text style of the MoonAuthCode in error state.
  final TextStyle errorTextStyle;

  const MoonAuthCodeProperties({
    required this.borderRadius,
    required this.gap,
    required this.height,
    required this.width,
    required this.animationDuration,
    required this.errorAnimationDuration,
    required this.peekDuration,
    required this.animationCurve,
    required this.errorAnimationCurve,
    required this.textStyle,
    required this.errorTextStyle,
  });

  @override
  MoonAuthCodeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? gap,
    double? height,
    double? width,
    Duration? animationDuration,
    Duration? errorAnimationDuration,
    Duration? peekDuration,
    Curve? animationCurve,
    Curve? errorAnimationCurve,
    TextStyle? textStyle,
    TextStyle? errorTextStyle,
  }) {
    return MoonAuthCodeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      gap: gap ?? this.gap,
      height: height ?? this.height,
      width: width ?? this.width,
      animationDuration: animationDuration ?? this.animationDuration,
      errorAnimationDuration: errorAnimationDuration ?? this.errorAnimationDuration,
      peekDuration: peekDuration ?? this.peekDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      errorAnimationCurve: errorAnimationCurve ?? this.errorAnimationCurve,
      textStyle: textStyle ?? this.textStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
    );
  }

  @override
  MoonAuthCodeProperties lerp(ThemeExtension<MoonAuthCodeProperties>? other, double t) {
    if (other is! MoonAuthCodeProperties) return this;

    return MoonAuthCodeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      height: lerpDouble(height, other.height, t)!,
      width: lerpDouble(width, other.width, t)!,
      animationDuration: lerpDuration(animationDuration, other.animationDuration, t),
      errorAnimationDuration: lerpDuration(errorAnimationDuration, other.errorAnimationDuration, t),
      peekDuration: lerpDuration(peekDuration, other.peekDuration, t),
      animationCurve: other.animationCurve,
      errorAnimationCurve: other.errorAnimationCurve,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAuthCodeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("gap", gap))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("width", width))
      ..add(DiagnosticsProperty<Duration>("animationDuration", animationDuration))
      ..add(DiagnosticsProperty<Duration>("errorAnimationDuration", errorAnimationDuration))
      ..add(DiagnosticsProperty<Duration>("peekDuration", peekDuration))
      ..add(DiagnosticsProperty<Curve>("animationCurve", animationCurve))
      ..add(DiagnosticsProperty<Curve>("errorAnimationCurve", errorAnimationCurve))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("errorTextStyle", errorTextStyle));
  }
}
