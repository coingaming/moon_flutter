import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextInputProperties extends ThemeExtension<MoonTextInputProperties>
    with DiagnosticableTreeMixin {
  /// The duration of the MoonTextInput transition animation
  /// (enable and disable).
  final Duration transitionDuration;

  /// The curve of the MoonTextInput transition animation (enable and disable).
  final Curve transitionCurve;

  /// The padding of the MoonTextInput helper and errorBuilder widgets.
  final EdgeInsetsGeometry helperPadding;

  /// The text style of the MoonTextInput helper and errorBuilder widgets.
  final TextStyle helperTextStyle;

  const MoonTextInputProperties({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.helperPadding,
    required this.helperTextStyle,
  });

  @override
  MoonTextInputProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? helperPadding,
    TextStyle? helperTextStyle,
  }) {
    return MoonTextInputProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      helperPadding: helperPadding ?? this.helperPadding,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
    );
  }

  @override
  MoonTextInputProperties lerp(
    ThemeExtension<MoonTextInputProperties>? other,
    double t,
  ) {
    if (other is! MoonTextInputProperties) return this;

    return MoonTextInputProperties(
      transitionDuration:
          lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      helperPadding:
          EdgeInsetsGeometry.lerp(helperPadding, other.helperPadding, t)!,
      helperTextStyle:
          TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonTextInputProperties"),
      )
      ..add(
        DiagnosticsProperty<Duration>("transitionDuration", transitionDuration),
      )
      ..add(
        DiagnosticsProperty<Curve>("transitionCurve", transitionCurve),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>("helperPadding", helperPadding),
      )
      ..add(
        DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle),
      );
  }
}
