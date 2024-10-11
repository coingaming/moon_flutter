import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextInputGroupProperties
    extends ThemeExtension<MoonTextInputGroupProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonTextInputGroup.
  final BorderRadiusGeometry borderRadius;

  /// The duration of the MoonTextInputGroup transition animation
  /// (enable and disable).
  final Duration transitionDuration;

  /// The curve of the MoonTextInputGroup transition animation
  /// (enable and disable).
  final Curve transitionCurve;

  /// The padding of the MoonTextInputGroup helper and errorBuilder widgets.
  final EdgeInsetsGeometry helperPadding;

  /// The padding of the MoonTextInputGroup text.
  final EdgeInsetsGeometry textPadding;

  /// The text style of the MoonTextInputGroup.
  final TextStyle textStyle;

  /// The text style of the MoonTextInputGroup helper and errorBuilder widgets.
  final TextStyle helperTextStyle;

  const MoonTextInputGroupProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.helperPadding,
    required this.textPadding,
    required this.textStyle,
    required this.helperTextStyle,
  });

  @override
  MoonTextInputGroupProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? helperPadding,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? helperTextStyle,
  }) {
    return MoonTextInputGroupProperties(
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
  MoonTextInputGroupProperties lerp(
    ThemeExtension<MoonTextInputGroupProperties>? other,
    double t,
  ) {
    if (other is! MoonTextInputGroupProperties) return this;

    return MoonTextInputGroupProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration:
          lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      helperPadding:
          EdgeInsetsGeometry.lerp(helperPadding, other.helperPadding, t)!,
      textPadding: EdgeInsetsGeometry.lerp(textPadding, other.textPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      helperTextStyle:
          TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty(
          "type",
          "MoonTextInputGroupProperties",
        ),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>(
          "borderRadius",
          borderRadius,
        ),
      )
      ..add(
        DiagnosticsProperty<Duration>(
          "transitionDuration",
          transitionDuration,
        ),
      )
      ..add(
        DiagnosticsProperty<Curve>(
          "transitionCurve",
          transitionCurve,
        ),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>(
          "helperPadding",
          helperPadding,
        ),
      )
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("textPadding", textPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle));
  }
}
