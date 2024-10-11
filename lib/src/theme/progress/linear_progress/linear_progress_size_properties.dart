import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonLinearProgressSizeProperties
    extends ThemeExtension<MoonLinearProgressSizeProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonLinearProgress.
  final BorderRadiusGeometry borderRadius;

  /// The height of the MoonLinearProgress.
  final double progressHeight;

  /// The size value of the MoonLinearProgress thumb.
  final double thumbSizeValue;

  /// The vertical gap between the MoonLinearProgress and the minLabel and
  /// maxLabel widgets.
  final double verticalGap;

  /// The text style of the MoonLinearProgress minLabel and maxLabel widgets.
  final TextStyle textStyle;

  const MoonLinearProgressSizeProperties({
    required this.borderRadius,
    required this.progressHeight,
    required this.thumbSizeValue,
    required this.verticalGap,
    required this.textStyle,
  });

  @override
  MoonLinearProgressSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? progressHeight,
    double? thumbSizeValue,
    double? verticalGap,
    TextStyle? textStyle,
  }) {
    return MoonLinearProgressSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      progressHeight: progressHeight ?? this.progressHeight,
      thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
      verticalGap: verticalGap ?? this.verticalGap,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonLinearProgressSizeProperties lerp(
    ThemeExtension<MoonLinearProgressSizeProperties>? other,
    double t,
  ) {
    if (other is! MoonLinearProgressSizeProperties) return this;

    return MoonLinearProgressSizeProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      progressHeight: lerpDouble(progressHeight, other.progressHeight, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonLinearProgressSizeProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(
        DoubleProperty("progressHeight", progressHeight),
      )
      ..add(
        DoubleProperty("thumbSizeValue", thumbSizeValue),
      )
      ..add(
        DoubleProperty("verticalGap", verticalGap),
      )
      ..add(
        DiagnosticsProperty<TextStyle>("textStyle", textStyle),
      );
  }
}
