import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonSwitchColors extends ThemeExtension<MoonSwitchColors> with DiagnosticableTreeMixin {
  /// The background color of the active (on) MoonSwitch track.
  final Color activeTrackColor;

  /// The background color of the inactive (off) MoonSwitch track.
  final Color inactiveTrackColor;

  /// The text color of the active (on) MoonSwitch.
  final Color activeTextColor;

  /// The text color of the inactive (off) MoonSwitch.
  final Color inactiveTextColor;

  /// The icon color of the active (on) MoonSwitch.
  final Color activeIconColor;

  /// The icon color of the inactive (off) MoonSwitch.
  final Color inactiveIconColor;

  /// The icon color of the MoonSwitch thumb.
  final Color thumbIconColor;

  /// The color of the MoonSwitch thumb.
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
