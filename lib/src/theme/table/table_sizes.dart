import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/table/table_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTableSizes extends ThemeExtension<MoonTableSizes>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The properties of the extra small MoonTable.
  final MoonTableSizeProperties xs;

  /// The properties of the small MoonTable.
  final MoonTableSizeProperties sm;

  /// The properties of the medium MoonTable.
  final MoonTableSizeProperties md;

  /// The properties of the large MoonTable.
  final MoonTableSizeProperties lg;

  /// The properties of the extra large MoonTable.
  final MoonTableSizeProperties xl;

  /// The properties of the (2x) extra large MoonTable.
  final MoonTableSizeProperties x2l;

  MoonTableSizes({
    required this.tokens,
    MoonTableSizeProperties? xs,
    MoonTableSizeProperties? sm,
    MoonTableSizeProperties? md,
    MoonTableSizeProperties? lg,
    MoonTableSizeProperties? xl,
    MoonTableSizeProperties? x2l,
  })  : xs = xs ??
            MoonTableSizeProperties(
              rowBorderRadius: tokens.borders.interactiveXs,
              rowGap: tokens.sizes.x5s,
              rowHeight: tokens.sizes.xs,
              sortIconSizeValue: tokens.sizes.x2s,
              sortIconGap: tokens.sizes.x5s,
              cellPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              rowLabelPadding:
                  EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              columnTextStyle: tokens.typography.heading.text12,
              rowTextStyle: tokens.typography.body.text12,
              rowLabelTextStyle: tokens.typography.body.text12,
              rowPinnedAnimatedLabelTextStyle: tokens.typography.body.text12,
            ),
        sm = sm ??
            MoonTableSizeProperties(
              rowBorderRadius: tokens.borders.interactiveXs,
              rowGap: tokens.sizes.x5s,
              rowHeight: tokens.sizes.sm,
              sortIconSizeValue: tokens.sizes.x2s,
              sortIconGap: tokens.sizes.x5s,
              cellPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              rowLabelPadding:
                  EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              columnTextStyle: tokens.typography.heading.textDefault,
              rowTextStyle: tokens.typography.body.textDefault,
              rowLabelTextStyle: tokens.typography.body.textDefault,
              rowPinnedAnimatedLabelTextStyle:
                  tokens.typography.body.textDefault,
            ),
        md = md ??
            MoonTableSizeProperties(
              rowBorderRadius: tokens.borders.interactiveSm,
              rowGap: tokens.sizes.x5s,
              rowHeight: tokens.sizes.md,
              sortIconSizeValue: tokens.sizes.x2s,
              sortIconGap: tokens.sizes.x5s,
              cellPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              rowLabelPadding:
                  EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              columnTextStyle: tokens.typography.heading.textDefault,
              rowTextStyle: tokens.typography.body.textDefault,
              rowLabelTextStyle: tokens.typography.body.textDefault,
              rowPinnedAnimatedLabelTextStyle:
                  tokens.typography.body.textDefault,
            ),
        lg = lg ??
            MoonTableSizeProperties(
              rowBorderRadius: tokens.borders.interactiveSm,
              rowGap: tokens.sizes.x5s,
              rowHeight: tokens.sizes.lg,
              sortIconSizeValue: tokens.sizes.x2s,
              sortIconGap: tokens.sizes.x5s,
              cellPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              rowLabelPadding:
                  EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              columnTextStyle: tokens.typography.heading.textDefault,
              rowTextStyle: tokens.typography.body.textDefault,
              rowLabelTextStyle: tokens.typography.body.textDefault,
              rowPinnedAnimatedLabelTextStyle:
                  tokens.typography.body.textDefault,
            ),
        xl = xl ??
            MoonTableSizeProperties(
              rowBorderRadius: tokens.borders.interactiveMd,
              rowGap: tokens.sizes.x5s,
              rowHeight: tokens.sizes.xl,
              sortIconSizeValue: tokens.sizes.x2s,
              sortIconGap: tokens.sizes.x5s,
              cellPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              rowLabelPadding:
                  EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              columnTextStyle: tokens.typography.heading.textDefault,
              rowTextStyle: tokens.typography.body.textDefault,
              rowLabelTextStyle: tokens.typography.body.textDefault,
              rowPinnedAnimatedLabelTextStyle:
                  tokens.typography.body.textDefault,
            ),
        x2l = x2l ??
            MoonTableSizeProperties(
              rowBorderRadius: tokens.borders.interactiveMd,
              rowGap: tokens.sizes.x5s,
              rowHeight: tokens.sizes.x2l,
              sortIconSizeValue: tokens.sizes.x2s,
              sortIconGap: tokens.sizes.x5s,
              cellPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              rowLabelPadding:
                  EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              columnTextStyle: tokens.typography.heading.textDefault,
              rowTextStyle: tokens.typography.body.textDefault,
              rowLabelTextStyle: tokens.typography.body.textDefault,
              rowPinnedAnimatedLabelTextStyle:
                  tokens.typography.body.textDefault,
            );

  @override
  MoonTableSizes copyWith({
    MoonTokens? tokens,
    MoonTableSizeProperties? xs,
    MoonTableSizeProperties? sm,
    MoonTableSizeProperties? md,
    MoonTableSizeProperties? lg,
    MoonTableSizeProperties? xl,
    MoonTableSizeProperties? x2l,
  }) {
    return MoonTableSizes(
      tokens: tokens ?? this.tokens,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
    );
  }

  @override
  MoonTableSizes lerp(ThemeExtension<MoonTableSizes>? other, double t) {
    if (other is! MoonTableSizes) return this;

    return MoonTableSizes(
      tokens: tokens.lerp(other.tokens, t),
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
      x2l: x2l.lerp(other.x2l, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTableSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTableSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonTableSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonTableSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonTableSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonTableSizeProperties>("xl", xl))
      ..add(DiagnosticsProperty<MoonTableSizeProperties>("x2l", x2l));
  }
}
