import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAvatarSizes extends ThemeExtension<MoonAvatarSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Extra small avatar properties.
  final MoonAvatarSizeProperties xs;

  /// Small avatar properties.
  final MoonAvatarSizeProperties sm;

  /// Medium avatar properties.
  final MoonAvatarSizeProperties md;

  /// Large avatar properties.
  final MoonAvatarSizeProperties lg;

  /// Extra large avatar properties.
  final MoonAvatarSizeProperties xl;

  /// (2x) Extra large avatar properties.
  final MoonAvatarSizeProperties x2l;

  MoonAvatarSizes({
    required this.tokens,
    MoonAvatarSizeProperties? xs,
    MoonAvatarSizeProperties? sm,
    MoonAvatarSizeProperties? md,
    MoonAvatarSizeProperties? lg,
    MoonAvatarSizeProperties? xl,
    MoonAvatarSizeProperties? x2l,
  })  : xs = xs ??
            MoonAvatarSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              avatarSizeValue: tokens.sizes.xs,
              badgeMarginValue: tokens.sizes.xs * tokens.sizes.x5s / tokens.sizes.x2l,
              badgeSizeValue: tokens.sizes.xs * tokens.sizes.x3s / tokens.sizes.x2l,
              textStyle: tokens.typography.heading.text10,
            ),
        sm = sm ??
            MoonAvatarSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              avatarSizeValue: tokens.sizes.sm,
              badgeMarginValue: tokens.sizes.sm * tokens.sizes.x5s / tokens.sizes.x2l,
              badgeSizeValue: tokens.sizes.sm * tokens.sizes.x3s / tokens.sizes.x2l,
              textStyle: tokens.typography.heading.text12,
            ),
        md = md ??
            MoonAvatarSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              avatarSizeValue: tokens.sizes.md,
              badgeMarginValue: tokens.sizes.md * tokens.sizes.x5s / tokens.sizes.x2l,
              badgeSizeValue: tokens.sizes.md * tokens.sizes.x3s / tokens.sizes.x2l,
              textStyle: tokens.typography.heading.textDefault,
            ),
        lg = lg ??
            MoonAvatarSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              avatarSizeValue: tokens.sizes.lg,
              badgeMarginValue: tokens.sizes.lg * tokens.sizes.x5s / tokens.sizes.x2l,
              badgeSizeValue: tokens.sizes.lg * tokens.sizes.x3s / tokens.sizes.x2l,
              textStyle: tokens.typography.heading.text16,
            ),
        xl = xl ??
            MoonAvatarSizeProperties(
              borderRadius: tokens.borders.interactiveMd,
              avatarSizeValue: tokens.sizes.xl,
              badgeMarginValue: tokens.sizes.xl * tokens.sizes.x5s / tokens.sizes.x2l,
              badgeSizeValue: tokens.sizes.xl * tokens.sizes.x3s / tokens.sizes.x2l,
              textStyle: tokens.typography.heading.text16,
            ),
        x2l = x2l ??
            MoonAvatarSizeProperties(
              borderRadius: tokens.borders.interactiveMd,
              avatarSizeValue: tokens.sizes.x2l,
              badgeMarginValue: tokens.sizes.x2l * tokens.sizes.x5s / tokens.sizes.x2l,
              badgeSizeValue: tokens.sizes.x2l * tokens.sizes.x3s / tokens.sizes.x2l,
              textStyle: tokens.typography.heading.text20,
            );

  @override
  MoonAvatarSizes copyWith({
    MoonTokens? tokens,
    MoonAvatarSizeProperties? xs,
    MoonAvatarSizeProperties? sm,
    MoonAvatarSizeProperties? md,
    MoonAvatarSizeProperties? lg,
    MoonAvatarSizeProperties? xl,
    MoonAvatarSizeProperties? x2l,
  }) {
    return MoonAvatarSizes(
      tokens: tokens ?? this.tokens,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
    );
  }

  @override
  MoonAvatarSizes lerp(ThemeExtension<MoonAvatarSizes>? other, double t) {
    if (other is! MoonAvatarSizes) return this;

    return MoonAvatarSizes(
      tokens: tokens,
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
      x2l: x2l.lerp(other.x2l, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("xl", xl))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("x2l", x2l));
  }
}
