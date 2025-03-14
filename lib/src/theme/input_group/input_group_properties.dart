import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonInputGroupProperties extends ThemeExtension<MoonInputGroupProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonInputGroup.
  final BorderRadiusGeometry borderRadius;

  /// The duration of the MoonInputGroup transition animation (enable and disable).
  final Duration transitionDuration;

  /// The curve of the MoonInputGroup transition animation (enable and disable).
  final Curve transitionCurve;

  /// The padding of the MoonInputGroup helper and errorBuilder widgets.
  final EdgeInsetsGeometry helperPadding;

  /// The padding of the MoonInputGroup text.
  final EdgeInsetsGeometry textPadding;

  /// The text style of the MoonInputGroup.
  final TextStyle textStyle;

  /// The text style of the MoonInputGroup helper and errorBuilder widgets.
  final TextStyle helperTextStyle;

  const MoonInputGroupProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.helperPadding,
    required this.textPadding,
    required this.textStyle,
    required this.helperTextStyle,
  });

  @override
  MoonInputGroupProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? helperPadding,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? helperTextStyle,
  }) {
    return MoonInputGroupProperties(
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
  MoonInputGroupProperties lerp(
    ThemeExtension<MoonInputGroupProperties>? other,
    double t,
  ) {
    if (other is! MoonInputGroupProperties) return this;

    return MoonInputGroupProperties(
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
      ..add(DiagnosticsProperty("type", "MoonInputGroupProperties"))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("textPadding", textPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle))
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(
        DiagnosticsProperty<Duration>("transitionDuration", transitionDuration),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>("helperPadding", helperPadding),
      );
  }
}
