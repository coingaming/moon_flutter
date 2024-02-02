import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/linear_progress/linear_progress_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonLinearProgressSizes extends ThemeExtension<MoonLinearProgressSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// (6x) Extra small linear progress properties.
  final MoonLinearProgressSizeProperties x6s;

  /// (5x) Extra small linear progress properties.
  final MoonLinearProgressSizeProperties x5s;

  /// (4x) Extra small linear progress properties.
  final MoonLinearProgressSizeProperties x4s;

  /// (3x) Extra small linear progress properties.
  final MoonLinearProgressSizeProperties x3s;

  /// (2x) Extra small linear progress properties.
  final MoonLinearProgressSizeProperties x2s;

  MoonLinearProgressSizes({
    required this.tokens,
    MoonLinearProgressSizeProperties? x6s,
    MoonLinearProgressSizeProperties? x5s,
    MoonLinearProgressSizeProperties? x4s,
    MoonLinearProgressSizeProperties? x3s,
    MoonLinearProgressSizeProperties? x2s,
  })  : x6s = x6s ??
            MoonLinearProgressSizeProperties(
              borderRadius: tokens.borders.surfaceXs,
              progressHeight: tokens.sizes.x6s,
              thumbSizeValue: tokens.sizes.x3s,
            ),
        x5s = x5s ??
            MoonLinearProgressSizeProperties(
              borderRadius: tokens.borders.surfaceXs,
              progressHeight: tokens.sizes.x5s,
              thumbSizeValue: tokens.sizes.x3s,
            ),
        x4s = x4s ??
            MoonLinearProgressSizeProperties(
              borderRadius: tokens.borders.surfaceSm,
              progressHeight: tokens.sizes.x4s,
              thumbSizeValue: tokens.sizes.x3s,
            ),
        x3s = x3s ??
            MoonLinearProgressSizeProperties(
              borderRadius: tokens.borders.surfaceMd,
              progressHeight: tokens.sizes.x3s,
              thumbSizeValue: tokens.sizes.x2s,
            ),
        x2s = x2s ??
            MoonLinearProgressSizeProperties(
              borderRadius: tokens.borders.surfaceLg,
              progressHeight: tokens.sizes.x2s,
              thumbSizeValue: tokens.sizes.x2s,
            );

  @override
  MoonLinearProgressSizes copyWith({
    MoonTokens? tokens,
    MoonLinearProgressSizeProperties? x6s,
    MoonLinearProgressSizeProperties? x5s,
    MoonLinearProgressSizeProperties? x4s,
    MoonLinearProgressSizeProperties? x3s,
    MoonLinearProgressSizeProperties? x2s,
  }) {
    return MoonLinearProgressSizes(
      tokens: tokens ?? this.tokens,
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
    );
  }

  @override
  MoonLinearProgressSizes lerp(ThemeExtension<MoonLinearProgressSizes>? other, double t) {
    if (other is! MoonLinearProgressSizes) return this;

    return MoonLinearProgressSizes(
      tokens: tokens.lerp(other.tokens, t),
      x6s: x6s.lerp(other.x6s, t),
      x5s: x5s.lerp(other.x5s, t),
      x4s: x4s.lerp(other.x4s, t),
      x3s: x3s.lerp(other.x3s, t),
      x2s: x2s.lerp(other.x2s, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearProgressSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonLinearProgressSizeProperties>("x6s", x6s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizeProperties>("x5s", x5s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizeProperties>("x4s", x4s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizeProperties>("x3s", x3s))
      ..add(DiagnosticsProperty<MoonLinearProgressSizeProperties>("x2s", x2s));
  }
}
