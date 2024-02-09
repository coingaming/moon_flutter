import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/circular_loader/circular_loader_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonCircularLoaderSizes extends ThemeExtension<MoonCircularLoaderSizes> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the (2x) extra small MoonCircularLoader.
  final MoonCircularLoaderSizeProperties x2s;

  /// The properties of the extra small MoonCircularLoader.
  final MoonCircularLoaderSizeProperties xs;

  /// The properties of the small MoonCircularLoader.
  final MoonCircularLoaderSizeProperties sm;

  /// The properties of the medium MoonCircularLoader.
  final MoonCircularLoaderSizeProperties md;

  /// The properties of the large MoonCircularLoader.
  final MoonCircularLoaderSizeProperties lg;

  MoonCircularLoaderSizes({
    required this.tokens,
    MoonCircularLoaderSizeProperties? x2s,
    MoonCircularLoaderSizeProperties? xs,
    MoonCircularLoaderSizeProperties? sm,
    MoonCircularLoaderSizeProperties? md,
    MoonCircularLoaderSizeProperties? lg,
  })  : x2s = x2s ??
            MoonCircularLoaderSizeProperties(
              loaderSizeValue: tokens.sizes.x2s,
              loaderStrokeWidth: tokens.sizes.x6s,
            ),
        xs = xs ??
            MoonCircularLoaderSizeProperties(
              loaderSizeValue: tokens.sizes.xs,
              loaderStrokeWidth: tokens.sizes.x6s,
            ),
        sm = sm ??
            MoonCircularLoaderSizeProperties(
              loaderSizeValue: tokens.sizes.sm,
              loaderStrokeWidth: tokens.sizes.x6s,
            ),
        md = md ??
            MoonCircularLoaderSizeProperties(
              loaderSizeValue: tokens.sizes.md,
              loaderStrokeWidth: tokens.sizes.x5s,
            ),
        lg = lg ??
            MoonCircularLoaderSizeProperties(
              loaderSizeValue: tokens.sizes.lg,
              loaderStrokeWidth: tokens.sizes.x5s,
            );

  @override
  MoonCircularLoaderSizes copyWith({
    MoonTokens? tokens,
    MoonCircularLoaderSizeProperties? x2s,
    MoonCircularLoaderSizeProperties? xs,
    MoonCircularLoaderSizeProperties? sm,
    MoonCircularLoaderSizeProperties? md,
    MoonCircularLoaderSizeProperties? lg,
  }) {
    return MoonCircularLoaderSizes(
      tokens: tokens ?? this.tokens,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonCircularLoaderSizes lerp(ThemeExtension<MoonCircularLoaderSizes>? other, double t) {
    if (other is! MoonCircularLoaderSizes) return this;

    return MoonCircularLoaderSizes(
      tokens: tokens.lerp(other.tokens, t),
      x2s: x2s.lerp(other.x2s, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonCircularLoaderSizeProperties>("lg", lg));
  }
}
