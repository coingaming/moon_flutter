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
    itemSizes: MoonAccordionItemSizes.sizes,
    itemShadows: MoonAccordionItemShadows.light,
  );

  static final dark = MoonAccordionTheme(
    itemColors: MoonAccordionItemColors.dark,
    itemProperties: MoonAccordionItemProperties.properties,
    itemSizes: MoonAccordionItemSizes.sizes,
    itemShadows: MoonAccordionItemShadows.dark,
  );

  /// Accordion item colors.
  final MoonAccordionItemColors itemColors;

  /// Accordion item properties.
  final MoonAccordionItemProperties itemProperties;

  /// Accordion item sizes.
  final MoonAccordionItemSizes itemSizes;

  /// Accordion item shadows.
  final MoonAccordionItemShadows itemShadows;

  const MoonAccordionTheme({
    required this.itemColors,
    required this.itemProperties,
    required this.itemSizes,
    required this.itemShadows,
  });

  @override
  MoonAccordionTheme copyWith({
    MoonAccordionItemColors? itemColors,
    MoonAccordionItemProperties? itemProperties,
    MoonAccordionItemSizes? itemSizes,
    MoonAccordionItemShadows? itemShadows,
  }) {
    return MoonAccordionTheme(
      itemColors: itemColors ?? this.itemColors,
      itemProperties: itemProperties ?? this.itemProperties,
      itemSizes: itemSizes ?? this.itemSizes,
      itemShadows: itemShadows ?? this.itemShadows,
    );
  }

  @override
  MoonAccordionTheme lerp(ThemeExtension<MoonAccordionTheme>? other, double t) {
    if (other is! MoonAccordionTheme) return this;

    return MoonAccordionTheme(
      itemColors: itemColors.lerp(other.itemColors, t),
      itemProperties: itemProperties.lerp(other.itemProperties, t),
      itemSizes: itemSizes.lerp(other.itemSizes, t),
      itemShadows: itemShadows.lerp(other.itemShadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAccordionTheme"))
      ..add(DiagnosticsProperty<MoonAccordionItemColors>("itemColors", itemColors))
      ..add(DiagnosticsProperty<MoonAccordionItemProperties>("itemProperties", itemProperties))
      ..add(DiagnosticsProperty<MoonAccordionItemSizes>("itemSizes", itemSizes))
      ..add(DiagnosticsProperty<MoonAccordionItemShadows>("itemShadows", itemShadows));
  }
}
