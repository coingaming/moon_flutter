import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonLinearLoaderSizes extends ThemeExtension<MoonLinearLoaderSizes> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the (6x) extra small MoonLinearLoader.
  final MoonLinearLoaderSizeProperties x6s;

  /// The properties of the (5x) extra small MoonLinearLoader.
  final MoonLinearLoaderSizeProperties x5s;

  /// The properties of the (4x) extra small MoonLinearLoader.
  final MoonLinearLoaderSizeProperties x4s;

  /// The properties of the (3x) extra small MoonLinearLoader.
  final MoonLinearLoaderSizeProperties x3s;

  /// The properties of the (2x) extra small MoonLinearLoader.
  final MoonLinearLoaderSizeProperties x2s;

  MoonLinearLoaderSizes({
    required this.tokens,
    MoonLinearLoaderSizeProperties? x6s,
    MoonLinearLoaderSizeProperties? x5s,
    MoonLinearLoaderSizeProperties? x4s,
    MoonLinearLoaderSizeProperties? x3s,
    MoonLinearLoaderSizeProperties? x2s,
  })  : x6s = x6s ??
            MoonLinearLoaderSizeProperties(
              borderRadius: tokens.borders.surfaceXs,
              loaderHeight: tokens.sizes.x6s,
            ),
        x5s = x5s ??
            MoonLinearLoaderSizeProperties(
              borderRadius: tokens.borders.surfaceXs,
              loaderHeight: tokens.sizes.x5s,
            ),
        x4s = x4s ??
            MoonLinearLoaderSizeProperties(
              borderRadius: tokens.borders.surfaceSm,
              loaderHeight: tokens.sizes.x4s,
            ),
        x3s = x3s ??
            MoonLinearLoaderSizeProperties(
              borderRadius: tokens.borders.surfaceMd,
              loaderHeight: tokens.sizes.x3s,
            ),
        x2s = x2s ??
            MoonLinearLoaderSizeProperties(
              borderRadius: tokens.borders.surfaceLg,
              loaderHeight: tokens.sizes.x2s,
            );

  @override
  MoonLinearLoaderSizes copyWith({
    MoonTokens? tokens,
    MoonLinearLoaderSizeProperties? x6s,
    MoonLinearLoaderSizeProperties? x5s,
    MoonLinearLoaderSizeProperties? x4s,
    MoonLinearLoaderSizeProperties? x3s,
    MoonLinearLoaderSizeProperties? x2s,
  }) {
    return MoonLinearLoaderSizes(
      tokens: tokens ?? this.tokens,
      x6s: x6s ?? this.x6s,
      x5s: x5s ?? this.x5s,
      x4s: x4s ?? this.x4s,
      x3s: x3s ?? this.x3s,
      x2s: x2s ?? this.x2s,
    );
  }

  @override
  MoonLinearLoaderSizes lerp(ThemeExtension<MoonLinearLoaderSizes>? other, double t) {
    if (other is! MoonLinearLoaderSizes) return this;

    return MoonLinearLoaderSizes(
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
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x6s", x6s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x5s", x5s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x4s", x4s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x3s", x3s))
      ..add(DiagnosticsProperty<MoonLinearLoaderSizeProperties>("x2s", x2s));
  }
}
