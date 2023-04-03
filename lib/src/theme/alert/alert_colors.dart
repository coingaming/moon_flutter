import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonAlertColors extends ThemeExtension<MoonAlertColors> with DiagnosticableTreeMixin {
  static final light = MoonAlertColors(
    backgroundColor: MoonColors.light.gohan,
    borderColor: MoonColors.light.bulma,
    leadingColor: MoonColors.light.bulma,
    textColor: MoonColors.light.bulma,
    trailingColor: MoonColors.light.bulma,
  );

  static final dark = MoonAlertColors(
    backgroundColor: MoonColors.dark.gohan,
    borderColor: MoonColors.dark.trunks,
    leadingColor: MoonColors.dark.bulma,
    textColor: MoonColors.dark.bulma,
    trailingColor: MoonColors.dark.bulma,
  );

  /// Alert background color.
  final Color backgroundColor;

  /// Alert border color.
  final Color borderColor;

  /// Alert leading color.
  final Color leadingColor;

  /// Alert text color.
  final Color textColor;

  /// Alert trailing color.
  final Color trailingColor;

  const MoonAlertColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.leadingColor,
    required this.textColor,
    required this.trailingColor,
  });

  @override
  MoonAlertColors copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? leadingColor,
    Color? textColor,
    Color? trailingColor,
  }) {
    return MoonAlertColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      leadingColor: leadingColor ?? this.leadingColor,
      textColor: textColor ?? this.textColor,
      trailingColor: trailingColor ?? this.trailingColor,
    );
  }

  @override
  MoonAlertColors lerp(ThemeExtension<MoonAlertColors>? other, double t) {
    if (other is! MoonAlertColors) return this;

    return MoonAlertColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      leadingColor: Color.lerp(leadingColor, other.leadingColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      trailingColor: Color.lerp(trailingColor, other.trailingColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("leadingColor", leadingColor))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("trailingColor", trailingColor));
  }
}
