import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonDropdownColors extends ThemeExtension<MoonDropdownColors> with DiagnosticableTreeMixin {
  /// Dropdown text color.
  final Color textColor;

  /// Dropdown icon color.
  final Color iconColor;

  /// Dropdown background color.
  final Color backgroundColor;

  const MoonDropdownColors({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  MoonDropdownColors copyWith({
    Color? textColor,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return MoonDropdownColors(
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonDropdownColors lerp(ThemeExtension<MoonDropdownColors>? other, double t) {
    if (other is! MoonDropdownColors) return this;

    return MoonDropdownColors(
      textColor: colorPremulLerp(textColor, other.textColor, t)!,
      iconColor: colorPremulLerp(iconColor, other.iconColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDropdownColors"))
      ..add(ColorProperty("textColor", textColor))
      ..add(ColorProperty("iconColor", iconColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
