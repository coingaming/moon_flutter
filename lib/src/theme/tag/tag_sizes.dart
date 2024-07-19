import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tag/tag_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTagSizes extends ThemeExtension<MoonTagSizes>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the (2x) extra small MoonTag.
  final MoonTagSizeProperties x2s;

  /// The properties of the extra small MoonTag.
  final MoonTagSizeProperties xs;

  /// The properties of the small MoonTag.
  final MoonTagSizeProperties sm;

  MoonTagSizes({
    required this.tokens,
    MoonTagSizeProperties? x2s,
    MoonTagSizeProperties? xs,
    MoonTagSizeProperties? sm,
  })  : x2s = x2s ??
            MoonTagSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              gap: tokens.sizes.x6s,
              height: tokens.sizes.x2s,
              iconSizeValue: tokens.sizes.x3s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              textStyle: tokens.typography.body.text9,
            ),
        xs = xs ??
            MoonTagSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              gap: tokens.sizes.x6s,
              height: tokens.sizes.xs,
              iconSizeValue: tokens.sizes.x2s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              textStyle: tokens.typography.body.text12,
            ),
        sm = sm ??
            MoonTagSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              gap: tokens.sizes.x4s,
              height: tokens.sizes.sm,
              iconSizeValue: tokens.sizes.x2s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x2s),
              textStyle: tokens.typography.body.text12,
            );

  @override
  MoonTagSizes copyWith({
    MoonTokens? tokens,
    MoonTagSizeProperties? x2s,
    MoonTagSizeProperties? xs,
    MoonTagSizeProperties? sm,
  }) {
    return MoonTagSizes(
      tokens: tokens ?? this.tokens,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
    );
  }

  @override
  MoonTagSizes lerp(ThemeExtension<MoonTagSizes>? other, double t) {
    if (other is! MoonTagSizes) return this;

    return MoonTagSizes(
      tokens: tokens.lerp(other.tokens, t),
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("sm", sm));
  }
}
