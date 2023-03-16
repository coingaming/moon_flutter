import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_size_properties.dart';

@immutable
class MoonAccordionSizes extends ThemeExtension<MoonAccordionSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonAccordionSizes(
    sm: MoonAccordionSizeProperties.sm,
    md: MoonAccordionSizeProperties.md,
    lg: MoonAccordionSizeProperties.lg,
    xl: MoonAccordionSizeProperties.xl,
  );

  /// Small accordion properties.
  final MoonAccordionSizeProperties sm;

  /// Medium accordion properties.
  final MoonAccordionSizeProperties md;

  /// Large accordion properties.
  final MoonAccordionSizeProperties lg;

  /// Extra large accordion properties.
  final MoonAccordionSizeProperties xl;

  const MoonAccordionSizes({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  MoonAccordionSizes copyWith({
    MoonAccordionSizeProperties? sm,
    MoonAccordionSizeProperties? md,
    MoonAccordionSizeProperties? lg,
    MoonAccordionSizeProperties? xl,
  }) {
    return MoonAccordionSizes(
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
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonAccordionSizeProperties>("xl", xl));
  }
}
