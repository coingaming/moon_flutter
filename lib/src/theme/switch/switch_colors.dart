import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/iconography/iconography.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonSwitchColors extends ThemeExtension<MoonSwitchColors> with DiagnosticableTreeMixin {
  static final light = MoonSwitchColors(
    activeTrackColor: MoonColors.light.piccolo,
    inactiveTrackColor: MoonColors.light.beerus,
    activeTextColor: MoonTypography.dark.colors.bodyPrimary,
    inactiveTextColor: MoonTypography.light.colors.bodyPrimary,
    activeIconColor: MoonIconography.dark.colors.primaryColor,
    inactiveIconColor: MoonIconography.light.colors.primaryColor,
    thumbIconColor: MoonIconography.light.colors.primaryColor,
    thumbColor: MoonColors.light.goten,
  );

  static final dark = MoonSwitchColors(
    activeTrackColor: MoonColors.dark.piccolo,
    inactiveTrackColor: MoonColors.dark.beerus,
    activeTextColor: MoonTypography.dark.colors.bodyPrimary,
    inactiveTextColor: MoonTypography.dark.colors.bodyPrimary,
    activeIconColor: MoonIconography.dark.colors.primaryColor,
    inactiveIconColor: MoonIconography.dark.colors.primaryColor,
    thumbIconColor: MoonIconography.light.colors.primaryColor,
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

  /// Switch active track icon color.
  final Color activeIconColor;

  /// Switch inactive track icon color.
  final Color inactiveIconColor;

  /// Switch icon Color.
  final Color thumbIconColor;

  /// Switch thumb color.
  final Color thumbColor;

  const MoonSwitchColors({
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.thumbIconColor,
    required this.thumbColor,
  });

  @override
  MoonSwitchColors copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? activeIconColor,
    Color? inactiveIconColor,
    Color? thumbIconColor,
    Color? thumbColor,
  }) {
    return MoonSwitchColors(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
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
      activeIconColor: colorPremulLerp(activeIconColor, other.activeIconColor, t)!,
      inactiveIconColor: colorPremulLerp(inactiveIconColor, other.inactiveIconColor, t)!,
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
      ..add(ColorProperty("activeIconColor", activeIconColor))
      ..add(ColorProperty("inactiveIconColor", inactiveIconColor))
      ..add(ColorProperty("thumbIconColor", thumbIconColor))
      ..add(ColorProperty("thumbColor", thumbColor));
  }
}
