import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonChipColors extends ThemeExtension<MoonChipColors> with DiagnosticableTreeMixin {
  static final light = MoonChipColors(
    activeColor: MoonColors.light.piccolo,
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonChipColors(
    activeColor: MoonColors.dark.piccolo,
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Chip active color.
  final Color activeColor;

  /// Chip background color.
  final Color backgroundColor;

  const MoonChipColors({
    required this.activeColor,
    required this.backgroundColor,
  });

  @override
  MoonChipColors copyWith({
    Color? activeColor,
    Color? backgroundColor,
  }) {
    return MoonChipColors(
      activeColor: activeColor ?? this.activeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonChipColors lerp(ThemeExtension<MoonChipColors>? other, double t) {
    if (other is! MoonChipColors) return this;

    return MoonChipColors(
      activeColor: colorPremulLerp(activeColor, other.activeColor, t)!,
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipColors"))
      ..add(ColorProperty("activeColor", activeColor))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
