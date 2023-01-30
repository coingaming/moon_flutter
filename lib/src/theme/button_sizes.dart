import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_styles.dart';

@immutable
class MoonButtonSizes extends ThemeExtension<MoonButtonSizes> with DiagnosticableTreeMixin {
  static final xs = MoonButtonSizes(
    height: 24,
    gap: 4,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    textStyle: MoonTextStyles.heading.text12,
  );

  static final sm = MoonButtonSizes(
    height: 32,
    gap: 4,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonButtonSizes(
    height: 40,
    gap: 8,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonButtonSizes(
    height: 48,
    gap: 12,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonButtonSizes(
    height: 56,
    gap: 16,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    textStyle: MoonTextStyles.heading.text16,
  );

  /// Button height.
  final double height;

  /// Space between button children.
  final double gap;

  /// Padding around button children.
  final EdgeInsets padding;

  /// Button border radius.
  final BorderRadiusGeometry borderRadius;

  /// Button text style.
  final TextStyle textStyle;

  const MoonButtonSizes({
    required this.height,
    required this.gap,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonButtonSizes copyWith({
    double? height,
    double? gap,
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonButtonSizes(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonButtonSizes lerp(ThemeExtension<MoonButtonSizes>? other, double t) {
    if (other is! MoonButtonSizes) return this;

    return MoonButtonSizes(
      height: lerpDouble(height, other.height, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonSizes"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
