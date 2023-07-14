import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonDrawerProperties extends ThemeExtension<MoonDrawerProperties> with DiagnosticableTreeMixin {
  static final properties = MoonDrawerProperties(
    borderRadius: BorderRadius.zero,
    width: 448,
    textStyle: MoonTextStyles.body.textDefault,
  );

  /// Drawer border radius.
  final BorderRadiusGeometry borderRadius;

  /// Drawer width.
  final double width;

  /// Drawer text style.
  final TextStyle textStyle;

  const MoonDrawerProperties({
    required this.borderRadius,
    required this.width,
    required this.textStyle,
  });

  @override
  MoonDrawerProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? width,
    TextStyle? textStyle,
  }) {
    return MoonDrawerProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonDrawerProperties lerp(ThemeExtension<MoonDrawerProperties>? other, double t) {
    if (other is! MoonDrawerProperties) return this;

    return MoonDrawerProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      width: lerpDouble(width, other.width, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDrawerProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("width", width))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
