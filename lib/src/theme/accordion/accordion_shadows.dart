import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAccordionShadows extends ThemeExtension<MoonAccordionShadows>
    with DiagnosticableTreeMixin {
  /// The list of shadows applied to the MoonAccordion.
  final List<BoxShadow> shadows;

  const MoonAccordionShadows({required this.shadows});

  @override
  MoonAccordionShadows copyWith({List<BoxShadow>? shadows}) {
    return MoonAccordionShadows(
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonAccordionShadows lerp(
    ThemeExtension<MoonAccordionShadows>? other,
    double t,
  ) {
    if (other is! MoonAccordionShadows) return this;

    return MoonAccordionShadows(
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", shadows));
  }
}
