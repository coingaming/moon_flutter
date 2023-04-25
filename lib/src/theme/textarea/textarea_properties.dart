import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTextAreaProperties extends ThemeExtension<MoonTextAreaProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTextAreaProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    textPadding: const EdgeInsets.all(16),
    textStyle: MoonTextStyles.body.text16,
    errorTextStyle: MoonTextStyles.body.text12,
  );

  /// TextArea border radius.
  final BorderRadius borderRadius;

  /// TextArea transition duration.
  final Duration transitionDuration;

  /// TextArea transition curve.
  final Curve transitionCurve;

  /// TextArea text padding.
  final EdgeInsetsGeometry textPadding;

  /// TextArea text style.
  final TextStyle textStyle;

  /// TextArea error text style.
  final TextStyle errorTextStyle;

  const MoonTextAreaProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.textPadding,
    required this.textStyle,
    required this.errorTextStyle,
  });

  @override
  MoonTextAreaProperties copyWith({
    BorderRadius? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? errorTextStyle,
  }) {
    return MoonTextAreaProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      textPadding: textPadding ?? this.textPadding,
      textStyle: textStyle ?? this.textStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
    );
  }

  @override
  MoonTextAreaProperties lerp(ThemeExtension<MoonTextAreaProperties>? other, double t) {
    if (other is! MoonTextAreaProperties) return this;

    return MoonTextAreaProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      textPadding: EdgeInsetsGeometry.lerp(textPadding, other.textPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextAreaProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("textPadding", textPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("errorTextStyle", errorTextStyle));
  }
}
