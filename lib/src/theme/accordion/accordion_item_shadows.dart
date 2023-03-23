import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonAccordionItemShadows extends ThemeExtension<MoonAccordionItemShadows> with DiagnosticableTreeMixin {
  static final light = MoonAccordionItemShadows(
    shadows: MoonShadows.light.sm,
  );

  static final dark = MoonAccordionItemShadows(
    shadows: MoonShadows.dark.sm,
  );

  /// Accordion item shadows.
  final List<BoxShadow> shadows;

  const MoonAccordionItemShadows({
    required this.shadows,
  });

  @override
  MoonAccordionItemShadows copyWith({List<BoxShadow>? shadows}) {
    return MoonAccordionItemShadows(
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonAccordionItemShadows lerp(ThemeExtension<MoonAccordionItemShadows>? other, double t) {
    if (other is! MoonAccordionItemShadows) return this;

    return MoonAccordionItemShadows(
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionItemShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", shadows));
  }
}
