import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBottomSheetProperties
    extends ThemeExtension<MoonBottomSheetProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonBottomSheet.
  final BorderRadiusGeometry borderRadius;

  /// The duration of the MoonBottomSheet transition animation (slide in or out).
  final Duration transitionDuration;

  /// The curve of the MoonBottomSheet transition animation (slide in or out).
  final Curve transitionCurve;

  /// The text style of the MoonBottomSheet.
  final TextStyle textStyle;

  const MoonBottomSheetProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.textStyle,
  });

  @override
  MoonBottomSheetProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? textStyle,
  }) {
    return MoonBottomSheetProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonBottomSheetProperties lerp(
    ThemeExtension<MoonBottomSheetProperties>? other,
    double t,
  ) {
    if (other is! MoonBottomSheetProperties) return this;

    return MoonBottomSheetProperties(
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
        DiagnosticsProperty("type", "MoonBottomSheetProperties"),
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
