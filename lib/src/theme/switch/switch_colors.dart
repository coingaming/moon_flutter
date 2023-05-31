import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonSwitchColors extends ThemeExtension<MoonSwitchColors> with DiagnosticableTreeMixin {
  static final light = MoonSwitchColors(
    activeTrackColor: MoonColors.light.piccolo,
    inactiveTrackColor: MoonColors.light.beerus,
    activeTextColor: MoonTypography.dark.colors.bodyPrimary,
    inactiveTextColor: MoonTypography.light.colors.bodyPrimary,
    thumbIconColor: MoonTypography.light.colors.bodyPrimary,
    thumbColor: MoonColors.light.goten,
  );

  static final dark = MoonSwitchColors(
    activeTrackColor: MoonColors.dark.piccolo,
    inactiveTrackColor: MoonColors.dark.beerus,
    activeTextColor: MoonTypography.dark.colors.bodyPrimary,
    inactiveTextColor: MoonTypography.dark.colors.bodyPrimary,
    thumbIconColor: MoonTypography.light.colors.bodyPrimary,
    thumbColor: MoonColors.dark.goten,
  );

  /// Switch active track color.
  final Color activeTrackColor;

  /// Switch inactive track color.
  final Color inactiveTrackColor;

  /// Switch active track text color.
  final Color activeTextColor;

  /// Switch inactive track text color.
  final Color inactiveTextColor;

  /// Switch icon Color.
  final Color thumbIconColor;

  /// Switch thumb color.
  final Color thumbColor;

  const MoonSwitchColors({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.thumbIconColor,
    required this.thumbColor,
  });

  @override
  MoonSwitchColors copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? thumbIconColor,
    Color? thumbColor,
  }) {
    return MoonSwitchColors(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
      thumbIconColor: thumbIconColor ?? this.thumbIconColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }

  @override
  MoonSwitchColors lerp(ThemeExtension<MoonSwitchColors>? other, double t) {
    if (other is! MoonSwitchColors) return this;

    return MoonSwitchColors(
      activeTrackColor: colorPremulLerp(activeTrackColor, other.activeTrackColor, t)!,
      inactiveTrackColor: colorPremulLerp(inactiveTrackColor, other.inactiveTrackColor, t)!,
      activeTextColor: colorPremulLerp(activeTextColor, other.activeTextColor, t)!,
      inactiveTextColor: colorPremulLerp(inactiveTextColor, other.inactiveTextColor, t)!,
      thumbIconColor: colorPremulLerp(thumbIconColor, other.thumbIconColor, t)!,
      thumbColor: colorPremulLerp(thumbColor, other.thumbColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchColors"))
      ..add(ColorProperty("activeTrackColor", activeTrackColor))
      ..add(ColorProperty("inactiveTrackColor", inactiveTrackColor))
      ..add(ColorProperty("activeTextColor", activeTextColor))
      ..add(ColorProperty("inactiveTextColor", inactiveTextColor))
      ..add(ColorProperty("thumbIconColor", thumbIconColor))
      ..add(ColorProperty("thumbColor", thumbColor));
  }
}
