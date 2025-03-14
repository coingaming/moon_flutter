import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonInputProperties extends ThemeExtension<MoonInputProperties>
    with DiagnosticableTreeMixin {
  /// The duration of the MoonInput transition animation (enable and disable).
  final Duration transitionDuration;

  /// The curve of the MoonInput transition animation (enable and disable).
  final Curve transitionCurve;

  /// The padding of the MoonInput helper and errorBuilder widgets.
  final EdgeInsetsGeometry helperPadding;

  /// The text style of the MoonInput helper and errorBuilder widgets.
  final TextStyle helperTextStyle;

  const MoonInputProperties({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.helperPadding,
    required this.helperTextStyle,
  });

  @override
  MoonInputProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? helperPadding,
    TextStyle? helperTextStyle,
  }) {
    return MoonInputProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      helperPadding: helperPadding ?? this.helperPadding,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
    );
  }

  @override
  MoonInputProperties lerp(
    ThemeExtension<MoonInputProperties>? other,
    double t,
  ) {
    if (other is! MoonInputProperties) return this;

    return MoonInputProperties(
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
        DiagnosticsProperty("type", "MoonInputProperties"),
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
