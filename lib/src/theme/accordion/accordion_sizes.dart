import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonAccordionSizes extends ThemeExtension<MoonAccordionSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Small accordion properties.
  final MoonAccordionSizeProperties sm;

  /// Medium accordion properties.
  final MoonAccordionSizeProperties md;

  /// Large accordion properties.
  final MoonAccordionSizeProperties lg;

  /// Extra large accordion properties.
  final MoonAccordionSizeProperties xl;

  MoonAccordionSizes({
    required this.tokens,
    MoonAccordionSizeProperties? sm,
    MoonAccordionSizeProperties? md,
    MoonAccordionSizeProperties? lg,
    MoonAccordionSizeProperties? xl,
  })  : sm = sm ??
            MoonAccordionSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              headerHeight: tokens.sizes.sm,
              iconSizeValue: tokens.sizes.x2s,
              headerPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              headerTextStyle: tokens.typography.heading.text12,
              contentTextStyle: tokens.typography.body.text12,
            ),
        md = md ??
            MoonAccordionSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              headerHeight: tokens.sizes.md,
              iconSizeValue: tokens.sizes.xs,
              headerPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x4s),
              headerTextStyle: tokens.typography.heading.textDefault,
              contentTextStyle: tokens.typography.body.textDefault,
            ),
        lg = lg ??
            MoonAccordionSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              headerHeight: tokens.sizes.lg,
              iconSizeValue: tokens.sizes.xs,
              headerPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              headerTextStyle: tokens.typography.heading.textDefault,
              contentTextStyle: tokens.typography.body.textDefault,
            ),
        xl = xl ??
            MoonAccordionSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              headerHeight: tokens.sizes.xl,
              iconSizeValue: tokens.sizes.xs,
              headerPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x2s),
              headerTextStyle: tokens.typography.heading.text16,
              contentTextStyle: tokens.typography.body.textDefault,
            );

  @override
  MoonAccordionSizes copyWith({
    MoonTokens? tokens,
    MoonAccordionSizeProperties? sm,
    MoonAccordionSizeProperties? md,
    MoonAccordionSizeProperties? lg,
    MoonAccordionSizeProperties? xl,
  }) {
    return MoonAccordionSizes(
      tokens: tokens ?? this.tokens,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonAccordionSizes lerp(ThemeExtension<MoonAccordionSizes>? other, double t) {
    if (other is! MoonAccordionSizes) return this;

    return MoonAccordionSizes(
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
      ..add(DiagnosticsProperty("type", "MoonAccordionSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("xl", xl));
  }
}
