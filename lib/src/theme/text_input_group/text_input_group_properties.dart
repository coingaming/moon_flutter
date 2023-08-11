import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextInputGroupProperties extends ThemeExtension<MoonTextInputGroupProperties> with DiagnosticableTreeMixin {
  /// TextInputGroup border radius.
  final BorderRadiusGeometry borderRadius;

  /// TextInputGroup transition duration.
  final Duration transitionDuration;

  /// TextInputGroup transition curve.
  final Curve transitionCurve;

  /// The padding around TextInputGroup helper widget or error builder.
  final EdgeInsetsGeometry supportingPadding;

  /// TextInputGroup text padding.
  final EdgeInsetsGeometry textPadding;

  /// TextInputGroup text style.
  final TextStyle textStyle;

  /// TextInputGroup helper or error text style.
  final TextStyle helperTextStyle;

  const MoonTextInputGroupProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.supportingPadding,
    required this.textPadding,
    required this.textStyle,
    required this.helperTextStyle,
  });

  @override
  MoonTextInputGroupProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? supportingPadding,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? helperTextStyle,
  }) {
    return MoonTextInputGroupProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      supportingPadding: supportingPadding ?? this.supportingPadding,
      textPadding: textPadding ?? this.textPadding,
      textStyle: textStyle ?? this.textStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
    );
  }

  @override
  MoonTextInputGroupProperties lerp(ThemeExtension<MoonTextInputGroupProperties>? other, double t) {
    if (other is! MoonTextInputGroupProperties) return this;

    return MoonTextInputGroupProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      supportingPadding: EdgeInsetsGeometry.lerp(supportingPadding, other.supportingPadding, t)!,
      textPadding: EdgeInsetsGeometry.lerp(textPadding, other.textPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputGroupProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("supportingPadding", supportingPadding))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("textPadding", textPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle));
  }
}
