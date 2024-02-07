import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress/circular_progress/circular_progress_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonCircularProgressSizes extends ThemeExtension<MoonCircularProgressSizes> with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the (2x) extra small MoonCircularProgress.
  final MoonCircularProgressSizeProperties x2s;

  /// The properties of the extra small MoonCircularProgress.
  final MoonCircularProgressSizeProperties xs;

  /// The properties of the small MoonCircularProgress.
  final MoonCircularProgressSizeProperties sm;

  /// The properties of the medium MoonCircularProgress.
  final MoonCircularProgressSizeProperties md;

  /// The properties of the large MoonCircularProgress.
  final MoonCircularProgressSizeProperties lg;

  MoonCircularProgressSizes({
    required this.tokens,
    MoonCircularProgressSizeProperties? x2s,
    MoonCircularProgressSizeProperties? xs,
    MoonCircularProgressSizeProperties? sm,
    MoonCircularProgressSizeProperties? md,
    MoonCircularProgressSizeProperties? lg,
  })  : x2s = x2s ??
            MoonCircularProgressSizeProperties(
              progressSizeValue: tokens.sizes.x2s,
              progressStrokeWidth: tokens.sizes.x6s,
            ),
        xs = xs ??
            MoonCircularProgressSizeProperties(
              progressSizeValue: tokens.sizes.xs,
              progressStrokeWidth: tokens.sizes.x6s,
            ),
        sm = sm ??
            MoonCircularProgressSizeProperties(
              progressSizeValue: tokens.sizes.sm,
              progressStrokeWidth: tokens.sizes.x6s,
            ),
        md = md ??
            MoonCircularProgressSizeProperties(
              progressSizeValue: tokens.sizes.md,
              progressStrokeWidth: tokens.sizes.x5s,
            ),
        lg = lg ??
            MoonCircularProgressSizeProperties(
              progressSizeValue: tokens.sizes.lg,
              progressStrokeWidth: tokens.sizes.x5s,
            );

  @override
  MoonCircularProgressSizes copyWith({
    MoonTokens? tokens,
    MoonCircularProgressSizeProperties? x2s,
    MoonCircularProgressSizeProperties? xs,
    MoonCircularProgressSizeProperties? sm,
    MoonCircularProgressSizeProperties? md,
    MoonCircularProgressSizeProperties? lg,
  }) {
    return MoonCircularProgressSizes(
      tokens: tokens ?? this.tokens,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  MoonCircularProgressSizes lerp(ThemeExtension<MoonCircularProgressSizes>? other, double t) {
    if (other is! MoonCircularProgressSizes) return this;

    return MoonCircularProgressSizes(
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
      ..add(DiagnosticsProperty("type", "MoonCircularProgressSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonCircularProgressSizeProperties>("lg", lg));
  }
}
