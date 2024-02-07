import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextAreaProperties extends ThemeExtension<MoonTextAreaProperties> with DiagnosticableTreeMixin {
  /// The border radius of the MoonTextArea.
  final BorderRadiusGeometry borderRadius;

  /// The duration of the MoonTextArea transition animation (enable and disable).
  final Duration transitionDuration;

  /// The curve of the MoonTextArea transition animation (enable and disable).
  final Curve transitionCurve;

  /// The padding of the MoonTextArea helper and errorBuilder widgets.
  final EdgeInsetsGeometry helperPadding;

  /// The padding of the MoonTextArea text.
  final EdgeInsetsGeometry textPadding;

  /// The text style of the MoonTextArea.
  final TextStyle textStyle;

  /// The text style of the MoonTextArea helper and errorBuilder widgets.
  final TextStyle helperTextStyle;

  const MoonTextAreaProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.helperPadding,
    required this.textPadding,
    required this.textStyle,
    required this.helperTextStyle,
  });

  @override
  MoonTextAreaProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? helperPadding,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? helperTextStyle,
  }) {
    return MoonTextAreaProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      helperPadding: helperPadding ?? this.helperPadding,
      textPadding: textPadding ?? this.textPadding,
      textStyle: textStyle ?? this.textStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
    );
  }

  @override
  MoonTextAreaProperties lerp(ThemeExtension<MoonTextAreaProperties>? other, double t) {
    if (other is! MoonTextAreaProperties) return this;

    return MoonTextAreaProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      helperPadding: EdgeInsetsGeometry.lerp(helperPadding, other.helperPadding, t)!,
      textPadding: EdgeInsetsGeometry.lerp(textPadding, other.textPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextAreaProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("helperPadding", helperPadding))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("textPadding", textPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle));
  }
}
