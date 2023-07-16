import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tab_bar/tab_bar_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTabBarSizes extends ThemeExtension<MoonTabBarSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Small TabBar item properties.
  final MoonTabBarSizeProperties sm;

  /// Medium TabBar item properties.
  final MoonTabBarSizeProperties md;

  MoonTabBarSizes({
    required this.tokens,
    MoonTabBarSizeProperties? sm,
    MoonTabBarSizeProperties? md,
  })  : sm = sm ??
            MoonTabBarSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              tabGap: tokens.sizes.x5s,
              height: tokens.sizes.sm,
              iconSizeValue: tokens.sizes.xs,
              indicatorHeight: tokens.sizes.x6s,
              tabPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              textStyle: tokens.typography.heading.textDefault,
            ),
        md = md ??
            MoonTabBarSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              tabGap: tokens.sizes.x4s,
              height: tokens.sizes.md,
              iconSizeValue: tokens.sizes.xs,
              indicatorHeight: tokens.sizes.x6s,
              tabPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x2s),
              textStyle: tokens.typography.heading.textDefault,
            );

  @override
  MoonTabBarSizes copyWith({
    MoonTokens? tokens,
    MoonTabBarSizeProperties? sm,
    MoonTabBarSizeProperties? md,
  }) {
    return MoonTabBarSizes(
      tokens: tokens ?? this.tokens,
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonTabBarSizes lerp(ThemeExtension<MoonTabBarSizes>? other, double t) {
    if (other is! MoonTabBarSizes) return this;

    return MoonTabBarSizes(
      tokens: tokens.lerp(other.tokens, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTabBarSizes"))
      ..add(DiagnosticsProperty<MoonTabBarSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonTabBarSizeProperties>("md", md));
  }
}
