import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonAuthCodeProperties extends ThemeExtension<MoonAuthCodeProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAuthCodeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    gap: MoonSizes.sizes.x4s,
    height: MoonSizes.sizes.xl,
    width: MoonSizes.sizes.lg,
    animationDuration: const Duration(milliseconds: 200),
    errorAnimationDuration: const Duration(milliseconds: 200),
    peekDuration: const Duration(milliseconds: 200),
    animationCurve: Curves.easeInOutCubic,
    errorAnimationCurve: Curves.easeInOutCubic,
    textStyle: MoonTextStyles.body.text24,
    errorTextStyle: MoonTextStyles.body.text12,
  );

  /// Border radius of the auth input field.
  final BorderRadiusGeometry borderRadius;

  /// Horizontal space between auth input fields.
  final double gap;

  /// Height of the auth input field.
  final double height;

  /// Width of the auth input field.
  final double width;

  /// AuthCode input field animation duration.
  final Duration animationDuration;

  /// AuthCode error animation duration.
  final Duration errorAnimationDuration;

  /// Peek duration before obscuring.
  final Duration peekDuration;

  /// AuthCode input field animation curve.
  final Curve animationCurve;

  /// AuthCode error animation curve.
  final Curve errorAnimationCurve;

  /// AuthCode text style.
  final TextStyle textStyle;

  /// AuthCode error text style.
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
