import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tag/tag_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTagSizes extends ThemeExtension<MoonTagSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// (2x) Extra small tag properties.
  final MoonTagSizeProperties x2s;

  /// Extra small tag properties.
  final MoonTagSizeProperties xs;

  MoonTagSizes({
    required this.tokens,
    MoonTagSizeProperties? x2s,
    MoonTagSizeProperties? xs,
  })  : x2s = x2s ??
            MoonTagSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              gap: tokens.sizes.x5s,
              height: tokens.sizes.x2s,
              iconSizeValue: tokens.sizes.x3s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              textStyle: tokens.typography.body.text10,
              upperCaseTextStyle: tokens.typography.caption.text9,
            ),
        xs = xs ??
            MoonTagSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              gap: tokens.sizes.x5s,
              height: tokens.sizes.xs,
              iconSizeValue: tokens.sizes.x2s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              textStyle: tokens.typography.body.text12,
              upperCaseTextStyle: tokens.typography.caption.text10,
            );

  @override
  MoonTagSizes copyWith({
    MoonTokens? tokens,
    MoonTagSizeProperties? x2s,
    MoonTagSizeProperties? xs,
  }) {
    return MoonTagSizes(
      tokens: tokens ?? this.tokens,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
    );
  }

  @override
  MoonTagSizes lerp(ThemeExtension<MoonTagSizes>? other, double t) {
    if (other is! MoonTagSizes) return this;

    return MoonTagSizes(
      tokens: tokens.lerp(other.tokens, t),
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonTagSizeProperties>("xs", xs));
  }
}
