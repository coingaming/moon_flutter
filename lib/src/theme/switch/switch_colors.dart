import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonSwitchColors extends ThemeExtension<MoonSwitchColors> with DiagnosticableTreeMixin {
  static final light = MoonSwitchColors(
    activeColor: MoonColors.light.piccolo,
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonSwitchColors(
    activeColor: MoonColors.dark.piccolo,
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Chip active color.
  final Color activeColor;

  /// Chip background color.
  final Color backgroundColor;

  const MoonSwitchColors({
    required this.activeColor,
    required this.backgroundColor,
  });

  @override
  MoonSwitchColors copyWith({
    Color? activeColor,
    Color? backgroundColor,
  }) {
    return MoonSwitchColors(
      activeColor: activeColor ?? this.activeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonSwitchColors lerp(ThemeExtension<MoonSwitchColors>? other, double t) {
    if (other is! MoonSwitchColors) return this;

    return MoonSwitchColors(
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
