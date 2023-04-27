import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/accordion/accordion_item_colors.dart';
import 'package:moon_design/src/theme/accordion/accordion_item_properties.dart';
import 'package:moon_design/src/theme/accordion/accordion_item_shadows.dart';
import 'package:moon_design/src/theme/accordion/accordion_item_sizes.dart';

@immutable
class MoonAccordionTheme extends ThemeExtension<MoonAccordionTheme> with DiagnosticableTreeMixin {
  static final light = MoonAccordionTheme(
    itemColors: MoonAccordionItemColors.light,
    itemProperties: MoonAccordionItemProperties.properties,
    itemShadows: MoonAccordionItemShadows.light,
    itemSizes: MoonAccordionItemSizes.sizes,
  );

  static final dark = MoonAccordionTheme(
    itemColors: MoonAccordionItemColors.dark,
    itemProperties: MoonAccordionItemProperties.properties,
    itemShadows: MoonAccordionItemShadows.dark,
    itemSizes: MoonAccordionItemSizes.sizes,
  );

  /// Accordion item colors.
  final MoonAccordionItemColors itemColors;

  /// Accordion item properties.
  final MoonAccordionItemProperties itemProperties;

  /// Accordion item shadows.
  final MoonAccordionItemShadows itemShadows;

  /// Accordion item sizes.
  final MoonAccordionItemSizes itemSizes;

  const MoonAccordionTheme({
    required this.itemColors,
    required this.itemProperties,
    required this.itemShadows,
    required this.itemSizes,
  });

  @override
  MoonAccordionTheme copyWith({
    MoonAccordionItemColors? itemColors,
    MoonAccordionItemProperties? itemProperties,
    MoonAccordionItemShadows? itemShadows,
    MoonAccordionItemSizes? itemSizes,
  }) {
    return MoonAccordionTheme(
      itemColors: itemColors ?? this.itemColors,
      itemProperties: itemProperties ?? this.itemProperties,
      itemShadows: itemShadows ?? this.itemShadows,
      itemSizes: itemSizes ?? this.itemSizes,
    );
  }

  @override
  MoonAccordionTheme lerp(ThemeExtension<MoonAccordionTheme>? other, double t) {
    if (other is! MoonAccordionTheme) return this;

    return MoonAccordionTheme(
      itemColors: itemColors.lerp(other.itemColors, t),
      itemProperties: itemProperties.lerp(other.itemProperties, t),
      itemShadows: itemShadows.lerp(other.itemShadows, t),
      itemSizes: itemSizes.lerp(other.itemSizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAccordionTheme"))
      ..add(DiagnosticsProperty<MoonAccordionItemColors>("itemColors", itemColors))
      ..add(DiagnosticsProperty<MoonAccordionItemProperties>("itemProperties", itemProperties))
      ..add(DiagnosticsProperty<MoonAccordionItemShadows>("itemShadows", itemShadows))
      ..add(DiagnosticsProperty<MoonAccordionItemSizes>("itemSizes", itemSizes));
  }
}
