import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/switch/switch_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonSwitchSizes extends ThemeExtension<MoonSwitchSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// (2x) Extra small switch properties.
  final MoonSwitchSizeProperties x2s;

  /// Extra small switch properties.
  final MoonSwitchSizeProperties xs;

  /// Small switch properties.
  final MoonSwitchSizeProperties sm;

  MoonSwitchSizes({
    required this.tokens,
    MoonSwitchSizeProperties? x2s,
    MoonSwitchSizeProperties? xs,
    MoonSwitchSizeProperties? sm,
  })  : x2s = x2s ??
            MoonSwitchSizeProperties(
              height: tokens.sizes.x2s,
              width: 2 * tokens.sizes.x3s + 2 * tokens.sizes.x5s,
              thumbSizeValue: tokens.sizes.x3s,
              iconSizeValue: tokens.sizes.x3s,
              padding: EdgeInsets.all(tokens.sizes.x6s),
              textStyle: tokens.typography.caption.text6.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
            ),
        xs = xs ??
            MoonSwitchSizeProperties(
              height: tokens.sizes.xs,
              width: 2 * tokens.sizes.x2s + 3 * tokens.sizes.x5s,
              thumbSizeValue: tokens.sizes.x2s,
              iconSizeValue: tokens.sizes.x2s,
              padding: EdgeInsets.all(tokens.sizes.x5s),
              textStyle: tokens.typography.caption.text8.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
            ),
        sm = sm ??
            MoonSwitchSizeProperties(
              height: tokens.sizes.sm,
              width: 2 * tokens.sizes.xs + 3 * tokens.sizes.x5s,
              thumbSizeValue: tokens.sizes.xs,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.all(tokens.sizes.x5s),
              textStyle: tokens.typography.caption.text10.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
            );

  @override
  MoonSwitchSizes copyWith({
    MoonTokens? tokens,
    MoonSwitchSizeProperties? x2s,
    MoonSwitchSizeProperties? xs,
    MoonSwitchSizeProperties? sm,
  }) {
    return MoonSwitchSizes(
      tokens: tokens ?? this.tokens,
      x2s: x2s ?? this.x2s,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
    );
  }

  @override
  MoonSwitchSizes lerp(ThemeExtension<MoonSwitchSizes>? other, double t) {
    if (other is! MoonSwitchSizes) return this;

    return MoonSwitchSizes(
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
      ..add(DiagnosticsProperty("type", "MoonSwitchSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonSwitchSizeProperties>("x2s", x2s))
      ..add(DiagnosticsProperty<MoonSwitchSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonSwitchSizeProperties>("sm", sm));
  }
}
