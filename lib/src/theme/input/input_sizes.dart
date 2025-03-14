import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/input/input_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonInputSizes extends ThemeExtension<MoonInputSizes>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the small MoonInput.
  final MoonInputSizeProperties sm;

  /// The properties of the medium MoonInput.
  final MoonInputSizeProperties md;

  /// The properties of the large MoonInput.
  final MoonInputSizeProperties lg;

  /// The properties of the extra large MoonInput.
  final MoonInputSizeProperties xl;

  MoonInputSizes({
    required this.tokens,
    MoonInputSizeProperties? sm,
    MoonInputSizeProperties? md,
    MoonInputSizeProperties? lg,
    MoonInputSizeProperties? xl,
  })  : sm = sm ??
            MoonInputSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              height: tokens.sizes.sm,
              gap: tokens.sizes.x4s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x4s,
                vertical: tokens.sizes.x6s,
              ),
              textStyle: tokens.typography.body.textDefault,
            ),
        md = md ??
            MoonInputSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              height: tokens.sizes.md,
              gap: tokens.sizes.x4s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x3s,
                vertical: tokens.sizes.x5s,
              ),
              textStyle: tokens.typography.body.textDefault,
            ),
        lg = lg ??
            MoonInputSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              height: tokens.sizes.lg,
              gap: tokens.sizes.x4s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x3s,
                vertical: 6,
              ),
              textStyle: tokens.typography.body.text16,
            ),
        xl = xl ??
            MoonInputSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              height: tokens.sizes.xl,
              gap: tokens.sizes.x2s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x2s,
                vertical: 9,
              ),
              textStyle: tokens.typography.body.text16,
            );

  @override
  MoonInputSizes copyWith({
    MoonTokens? tokens,
    MoonInputSizeProperties? sm,
    MoonInputSizeProperties? md,
    MoonInputSizeProperties? lg,
    MoonInputSizeProperties? xl,
  }) {
    return MoonInputSizes(
      tokens: tokens ?? this.tokens,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonInputSizes lerp(ThemeExtension<MoonInputSizes>? other, double t) {
    if (other is! MoonInputSizes) return this;

    return MoonInputSizes(
      tokens: tokens.lerp(other.tokens, t),
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
      ..add(DiagnosticsProperty("type", "MoonInputSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonInputSizeProperties>("xl", xl));
  }
}
