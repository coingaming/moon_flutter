import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_item_size_properties.dart';

@immutable
class MoonAccordionItemSizes extends ThemeExtension<MoonAccordionItemSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonAccordionItemSizes(
    sm: MoonAccordionItemSizeProperties.sm,
    md: MoonAccordionItemSizeProperties.md,
    lg: MoonAccordionItemSizeProperties.lg,
    xl: MoonAccordionItemSizeProperties.xl,
  );

  /// Small accordion item properties.
  final MoonAccordionItemSizeProperties sm;

  /// Medium accordion item properties.
  final MoonAccordionItemSizeProperties md;

  /// Large accordion item properties.
  final MoonAccordionItemSizeProperties lg;

  /// Extra large accordion item properties.
  final MoonAccordionItemSizeProperties xl;

  const MoonAccordionItemSizes({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  MoonAccordionItemSizes copyWith({
    MoonAccordionItemSizeProperties? sm,
    MoonAccordionItemSizeProperties? md,
    MoonAccordionItemSizeProperties? lg,
    MoonAccordionItemSizeProperties? xl,
  }) {
    return MoonAccordionItemSizes(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonAccordionItemSizes lerp(ThemeExtension<MoonAccordionItemSizes>? other, double t) {
    if (other is! MoonAccordionItemSizes) return this;

    return MoonAccordionItemSizes(
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
      ..add(DiagnosticsProperty("type", "MoonAccordionItemSizes"))
      ..add(DiagnosticsProperty<MoonAccordionItemSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonAccordionItemSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonAccordionItemSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonAccordionItemSizeProperties>("xl", xl));
  }
}
