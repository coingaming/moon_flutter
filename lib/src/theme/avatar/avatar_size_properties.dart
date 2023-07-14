import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonAvatarSizeProperties extends ThemeExtension<MoonAvatarSizeProperties> with DiagnosticableTreeMixin {
  static final _badgeToAvatarRatio = MoonSizes.sizes.x3s / MoonSizes.sizes.x2l;
  static final _badgeMarginValueToAvatarRatio = MoonSizes.sizes.x5s / MoonSizes.sizes.x2l;

  static final xs = MoonAvatarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    avatarSizeValue: MoonSizes.sizes.xs,
    badgeMarginValue: MoonSizes.sizes.xs * _badgeMarginValueToAvatarRatio,
    badgeSizeValue: MoonSizes.sizes.xs * _badgeToAvatarRatio,
    textStyle: MoonTextStyles.heading.text10,
  );

  static final sm = MoonAvatarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    avatarSizeValue: MoonSizes.sizes.sm,
    badgeMarginValue: MoonSizes.sizes.sm * _badgeMarginValueToAvatarRatio,
    badgeSizeValue: MoonSizes.sizes.sm * _badgeToAvatarRatio,
    textStyle: MoonTextStyles.heading.text12,
  );

  static final md = MoonAvatarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    avatarSizeValue: MoonSizes.sizes.md,
    badgeMarginValue: MoonSizes.sizes.md * _badgeMarginValueToAvatarRatio,
    badgeSizeValue: MoonSizes.sizes.md * _badgeToAvatarRatio,
    textStyle: MoonTextStyles.heading.textDefault,
  );

  static final lg = MoonAvatarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    avatarSizeValue: MoonSizes.sizes.lg,
    badgeMarginValue: MoonSizes.sizes.lg * _badgeMarginValueToAvatarRatio,
    badgeSizeValue: MoonSizes.sizes.lg * _badgeToAvatarRatio,
    textStyle: MoonTextStyles.heading.text16,
  );

  static final xl = MoonAvatarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveMd,
    avatarSizeValue: MoonSizes.sizes.xl,
    badgeMarginValue: MoonSizes.sizes.xl * _badgeMarginValueToAvatarRatio,
    badgeSizeValue: MoonSizes.sizes.xl * _badgeToAvatarRatio,
    textStyle: MoonTextStyles.heading.text16,
  );

  static final x2l = MoonAvatarSizeProperties(
    borderRadius: MoonBorders.borders.interactiveMd,
    avatarSizeValue: MoonSizes.sizes.x2l,
    badgeMarginValue: MoonSizes.sizes.x2l * _badgeMarginValueToAvatarRatio,
    badgeSizeValue: MoonSizes.sizes.x2l * _badgeToAvatarRatio,
    textStyle: MoonTextStyles.heading.text20,
  );

  /// Avatar border radius.
  final BorderRadiusGeometry borderRadius;

  /// Avatar size value.
  final double avatarSizeValue;

  /// Avatar badge margin value.
  final double badgeMarginValue;

  /// Avatar badge size value.
  final double badgeSizeValue;

  /// Avatar text style.
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
  MoonAvatarSizeProperties lerp(ThemeExtension<MoonAvatarSizeProperties>? other, double t) {
    if (other is! MoonAvatarSizeProperties) return this;

    return MoonAvatarSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      avatarSizeValue: lerpDouble(avatarSizeValue, other.avatarSizeValue, t)!,
      badgeMarginValue: lerpDouble(badgeMarginValue, other.badgeMarginValue, t)!,
      badgeSizeValue: lerpDouble(badgeSizeValue, other.badgeSizeValue, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("avatarSizeValue", avatarSizeValue))
      ..add(DoubleProperty("badgeMarginValue", badgeMarginValue))
      ..add(DoubleProperty("badgeSizeValue", badgeSizeValue))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
