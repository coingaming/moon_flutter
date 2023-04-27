import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/popover/popover_colors.dart';
import 'package:moon_design/src/theme/popover/popover_properties.dart';
import 'package:moon_design/src/theme/popover/popover_shadows.dart';

@immutable
class MoonPopoverTheme extends ThemeExtension<MoonPopoverTheme> with DiagnosticableTreeMixin {
  static final light = MoonPopoverTheme(
    colors: MoonPopoverColors.light,
    properties: MoonPopoverProperties.properties,
    shadows: MoonPopoverShadows.light,
  );

  static final dark = MoonPopoverTheme(
    colors: MoonPopoverColors.dark,
    properties: MoonPopoverProperties.properties,
    shadows: MoonPopoverShadows.dark,
  );

  /// Popover colors.
  final MoonPopoverColors colors;

  /// Popover properties.
  final MoonPopoverProperties properties;

  /// Popover shadows.
  final MoonPopoverShadows shadows;

  const MoonPopoverTheme({
    required this.colors,
    required this.properties,
    required this.shadows,
  });

  @override
  MoonPopoverTheme copyWith({
    MoonPopoverColors? colors,
    MoonPopoverProperties? properties,
    MoonPopoverShadows? shadows,
  }) {
    return MoonPopoverTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonPopoverTheme lerp(ThemeExtension<MoonPopoverTheme>? other, double t) {
    if (other is! MoonPopoverTheme) return this;

    return MoonPopoverTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonPopoverTheme"))
      ..add(DiagnosticsProperty<MoonPopoverColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonPopoverProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonPopoverShadows>("shadows", shadows));
  }
}
