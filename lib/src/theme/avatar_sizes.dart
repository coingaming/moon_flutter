import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/text_styles.dart';

@immutable
class MoonAvatarSizes extends ThemeExtension<MoonAvatarSizes> with DiagnosticableTreeMixin {
  static final _badgeToAvatarRatio = MoonSizes.sizes.x3s / MoonSizes.sizes.x2l;
  static final _badgeMarginValueToAvatarRatio = MoonSizes.sizes.x5s / MoonSizes.sizes.x2l;

  static final xs = MoonAvatarSizes(
    avatarSizeValue: MoonSizes.sizes.xs,
    badgeSizeValue: MoonSizes.sizes.xs * _badgeToAvatarRatio,
    badgeMarginValue: MoonSizes.sizes.xs * _badgeMarginValueToAvatarRatio,
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.heading.text10,
  );

  static final sm = MoonAvatarSizes(
    avatarSizeValue: MoonSizes.sizes.sm,
    badgeSizeValue: MoonSizes.sizes.sm * _badgeToAvatarRatio,
    badgeMarginValue: MoonSizes.sizes.sm * _badgeMarginValueToAvatarRatio,
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text12,
  );

  static final md = MoonAvatarSizes(
    avatarSizeValue: MoonSizes.sizes.md,
    badgeSizeValue: MoonSizes.sizes.md * _badgeToAvatarRatio,
    badgeMarginValue: MoonSizes.sizes.md * _badgeMarginValueToAvatarRatio,
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text14,
  );

  static final lg = MoonAvatarSizes(
    avatarSizeValue: MoonSizes.sizes.lg,
    badgeSizeValue: MoonSizes.sizes.lg * _badgeToAvatarRatio,
    badgeMarginValue: MoonSizes.sizes.lg * _badgeMarginValueToAvatarRatio,
    borderRadius: MoonBorders.borders.interactiveSm,
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonAvatarSizes(
    avatarSizeValue: MoonSizes.sizes.xl,
    badgeSizeValue: MoonSizes.sizes.xl * _badgeToAvatarRatio,
    badgeMarginValue: MoonSizes.sizes.xl * _badgeMarginValueToAvatarRatio,
    borderRadius: MoonBorders.borders.interactiveMd,
    textStyle: MoonTextStyles.heading.text16,
  );

  static final x2l = MoonAvatarSizes(
    avatarSizeValue: MoonSizes.sizes.x2l,
    badgeSizeValue: MoonSizes.sizes.x2l * _badgeToAvatarRatio,
    badgeMarginValue: MoonSizes.sizes.x2l * _badgeMarginValueToAvatarRatio,
    borderRadius: MoonBorders.borders.interactiveMd,
    textStyle: MoonTextStyles.heading.text20,
  );

  /// Avatar size value.
  final double avatarSizeValue;

  /// Avatar size value.
  final double badgeSizeValue;

  /// Avatar size value.
  final double badgeMarginValue;

  /// Avatar border radius.
  final BorderRadius borderRadius;

  /// Avatar text style.
  final TextStyle textStyle;

  const MoonAvatarSizes({
    required this.avatarSizeValue,
    required this.badgeSizeValue,
    required this.badgeMarginValue,
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonAvatarSizes copyWith({
    double? avatarSizeValue,
    double? badgeSizeValue,
    double? badgeMarginValue,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonAvatarSizes(
      avatarSizeValue: avatarSizeValue ?? this.avatarSizeValue,
      badgeSizeValue: badgeSizeValue ?? this.badgeSizeValue,
      badgeMarginValue: badgeMarginValue ?? this.badgeMarginValue,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonAvatarSizes lerp(ThemeExtension<MoonAvatarSizes>? other, double t) {
    if (other is! MoonAvatarSizes) return this;

    return MoonAvatarSizes(
      avatarSizeValue: lerpDouble(avatarSizeValue, other.avatarSizeValue, t)!,
      badgeSizeValue: lerpDouble(badgeSizeValue, other.badgeSizeValue, t)!,
      badgeMarginValue: lerpDouble(badgeMarginValue, other.badgeMarginValue, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarSizes"))
      ..add(DoubleProperty("avatarSizeValue", avatarSizeValue))
      ..add(DoubleProperty("badgeSizeValue", badgeSizeValue))
      ..add(DoubleProperty("badgeMarginValue", badgeMarginValue))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
