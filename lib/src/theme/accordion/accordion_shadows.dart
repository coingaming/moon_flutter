import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonAccordionShadows extends ThemeExtension<MoonAccordionShadows> with DiagnosticableTreeMixin {
  static final light = MoonAccordionShadows(
    accordionShadows: MoonShadows.light.sm,
  );

  static final dark = MoonAccordionShadows(
    accordionShadows: MoonShadows.dark.sm,
  );

  /// Accordion shadows.
  final List<BoxShadow> accordionShadows;

  const MoonAccordionShadows({
    required this.accordionShadows,
  });

  @override
  MoonAccordionShadows copyWith({List<BoxShadow>? accordionShadows}) {
    return MoonAccordionShadows(
      accordionShadows: accordionShadows ?? this.accordionShadows,
    );
  }

  @override
  MoonAccordionShadows lerp(ThemeExtension<MoonAccordionShadows>? other, double t) {
    if (other is! MoonAccordionShadows) return this;

    return MoonAccordionShadows(
      accordionShadows: BoxShadow.lerpList(accordionShadows, other.accordionShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", accordionShadows));
  }
}
