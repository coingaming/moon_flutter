import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/button/button_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonButtonSizes extends ThemeExtension<MoonButtonSizes> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the extra small MoonButton.
  final MoonButtonSizeProperties xs;

  /// The properties of the small MoonButton.
  final MoonButtonSizeProperties sm;

  /// The properties of the medium MoonButton.
  final MoonButtonSizeProperties md;

  /// The properties of the large MoonButton.
  final MoonButtonSizeProperties lg;

  /// The properties of the extra large MoonButton.
  final MoonButtonSizeProperties xl;

  MoonButtonSizes({
    required this.tokens,
    MoonButtonSizeProperties? xs,
    MoonButtonSizeProperties? sm,
    MoonButtonSizeProperties? md,
    MoonButtonSizeProperties? lg,
    MoonButtonSizeProperties? xl,
  })  : xs = xs ??
            MoonButtonSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              gap: tokens.sizes.x5s,
              height: tokens.sizes.xs,
              iconSizeValue: tokens.sizes.x2s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              textStyle: tokens.typography.heading.text12,
            ),
        sm = sm ??
            MoonButtonSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              gap: tokens.sizes.x5s,
              height: tokens.sizes.sm,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              textStyle: tokens.typography.heading.textDefault,
            ),
        md = md ??
            MoonButtonSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              gap: tokens.sizes.x4s,
              height: tokens.sizes.md,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x2s),
              textStyle: tokens.typography.heading.textDefault,
            ),
        lg = lg ??
            MoonButtonSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              gap: tokens.sizes.x3s,
              height: tokens.sizes.lg,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x2s),
              textStyle: tokens.typography.heading.text16,
            ),
        xl = xl ??
            MoonButtonSizeProperties(
              borderRadius: tokens.borders.interactiveMd,
              gap: tokens.sizes.x2s,
              height: tokens.sizes.xl,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.xs),
              textStyle: tokens.typography.heading.text16,
            );

  @override
  MoonButtonSizes copyWith({
    MoonTokens? tokens,
    MoonButtonSizeProperties? xs,
    MoonButtonSizeProperties? sm,
    MoonButtonSizeProperties? md,
    MoonButtonSizeProperties? lg,
    MoonButtonSizeProperties? xl,
  }) {
    return MoonButtonSizes(
      tokens: tokens ?? this.tokens,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonButtonSizes lerp(ThemeExtension<MoonButtonSizes>? other, double t) {
    if (other is! MoonButtonSizes) return this;

    return MoonButtonSizes(
      tokens: tokens.lerp(other.tokens, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonButtonSizeProperties>("xl", xl));
  }
}
