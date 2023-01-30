import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_styles.dart';

@immutable
class MoonButtonSize extends ThemeExtension<MoonButtonSize> with DiagnosticableTreeMixin {
  static final xs = MoonButtonSize(
    height: 24,
    gap: 4,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    textStyle: MoonTextStyles.heading.text12,
  );

  static final sm = MoonButtonSize(
    height: 32,
    gap: 4,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final md = MoonButtonSize(
    height: 40,
    gap: 8,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonButtonSize(
    height: 48,
    gap: 12,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonButtonSize(
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

  const MoonButtonSize({
    required this.height,
    required this.gap,
    required this.padding,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonButtonSize copyWith({
    double? height,
    double? gap,
    EdgeInsets? padding,
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonButtonSize(
      height: height ?? this.height,
      gap: gap ?? this.gap,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonButtonSize lerp(ThemeExtension<MoonButtonSize>? other, double t) {
    if (other is! MoonButtonSize) return this;

    return MoonButtonSize(
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
      ..add(DiagnosticsProperty("type", "MoonButtonSize"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}

extension MoonButtonSizeX on BuildContext {
  MoonButtonSize? get moonButtonSize => Theme.of(this).extension<MoonButtonSize>();
}
