import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAvatarSizeProperties extends ThemeExtension<MoonAvatarSizeProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonAvatar.
  final BorderRadiusGeometry borderRadius;

  /// The size value of the MoonAvatar.
  final double avatarSizeValue;

  /// The margin value of the MoonAvatar badge.
  final double badgeMarginValue;

  /// The size value of the MoonAvatar badge.
  final double badgeSizeValue;

  /// The text style of the MoonAvatar.
  final TextStyle textStyle;

  const MoonAvatarSizeProperties({
    required this.avatarSizeValue,
    required this.badgeSizeValue,
    required this.badgeMarginValue,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonAvatarSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? avatarSizeValue,
    double? badgeMarginValue,
    double? badgeSizeValue,
    TextStyle? textStyle,
  }) {
    return MoonAvatarSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      avatarSizeValue: avatarSizeValue ?? this.avatarSizeValue,
      badgeMarginValue: badgeMarginValue ?? this.badgeMarginValue,
      badgeSizeValue: badgeSizeValue ?? this.badgeSizeValue,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonAvatarSizeProperties lerp(
    ThemeExtension<MoonAvatarSizeProperties>? other,
    double t,
  ) {
    if (other is! MoonAvatarSizeProperties) return this;

    return MoonAvatarSizeProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      avatarSizeValue: lerpDouble(avatarSizeValue, other.avatarSizeValue, t)!,
      badgeMarginValue:
          lerpDouble(badgeMarginValue, other.badgeMarginValue, t)!,
      badgeSizeValue: lerpDouble(badgeSizeValue, other.badgeSizeValue, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonAvatarSizeProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(DoubleProperty("avatarSizeValue", avatarSizeValue))
      ..add(DoubleProperty("badgeMarginValue", badgeMarginValue))
      ..add(DoubleProperty("badgeSizeValue", badgeSizeValue))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
