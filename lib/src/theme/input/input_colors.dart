import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonInputColors extends ThemeExtension<MoonInputColors> with DiagnosticableTreeMixin {
  static final light = MoonInputColors(
    backgroundColor: MoonColors.light.gohan,
    activeBorderColor: MoonColors.light.piccolo,
    inactiveBorderColor: MoonColors.light.beerus,
    errorBorderColor: MoonColors.light.chiChi100,
    labelTextColor: MoonColors.light.trunks,
    supportingTextColor: MoonColors.light.trunks,
  );

  static final dark = MoonInputColors(
    backgroundColor: MoonColors.dark.gohan,
    activeBorderColor: MoonColors.dark.piccolo,
    inactiveBorderColor: MoonColors.dark.beerus,
    errorBorderColor: MoonColors.dark.chiChi100,
    labelTextColor: MoonColors.dark.trunks,
    supportingTextColor: MoonColors.dark.trunks,
  );

  /// Input background color.
  final Color backgroundColor;

  /// Input active border color.
  final Color activeBorderColor;

  /// Input inactive border color.
  final Color inactiveBorderColor;

  /// Input error border color.
  final Color errorBorderColor;

  /// Input hint text color.
  final Color labelTextColor;

  /// Input hint text color.
  final Color supportingTextColor;

  const MoonInputColors({
    required this.backgroundColor,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.errorBorderColor,
    required this.labelTextColor,
    required this.supportingTextColor,
  });

  @override
  MoonInputColors copyWith({
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorBorderColor,
    Color? hoverBorderColor,
    Color? labelTextColor,
    Color? supportingTextColor,
  }) {
    return MoonInputColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      labelTextColor: labelTextColor ?? this.labelTextColor,
      supportingTextColor: supportingTextColor ?? this.supportingTextColor,
    );
  }

  @override
  MoonInputColors lerp(ThemeExtension<MoonInputColors>? other, double t) {
    if (other is! MoonInputColors) return this;

    return MoonInputColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeBorderColor: Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      inactiveBorderColor: Color.lerp(inactiveBorderColor, other.inactiveBorderColor, t)!,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      labelTextColor: Color.lerp(labelTextColor, other.labelTextColor, t)!,
      supportingTextColor: Color.lerp(supportingTextColor, other.supportingTextColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonInputColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("activeBorderColor", activeBorderColor))
      ..add(ColorProperty("inactiveBorderColor", inactiveBorderColor))
      ..add(ColorProperty("errorBorderColor", errorBorderColor))
      ..add(ColorProperty("labelTextColor", labelTextColor))
      ..add(ColorProperty("supportingTextColor", supportingTextColor));
  }
}
