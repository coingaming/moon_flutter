import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/popover/popover_colors.dart';
import 'package:moon_design/src/theme/popover/popover_properties.dart';
import 'package:moon_design/src/theme/popover/popover_shadows.dart';

@immutable
class MoonPopoverTheme extends ThemeExtension<MoonPopoverTheme> with DiagnosticableTreeMixin {
  static final light = MoonPopoverTheme(
    colors: MoonPopoverColors.light,
    shadows: MoonPopoverShadows.light,
    properties: MoonPopoverProperties.properties,
  );

  static final dark = MoonPopoverTheme(
    colors: MoonPopoverColors.dark,
    shadows: MoonPopoverShadows.dark,
    properties: MoonPopoverProperties.properties,
  );

  /// Popover colors.
  final MoonPopoverColors colors;

  /// Popover shadows.
  final MoonPopoverShadows shadows;

  /// Popover properties.
  final MoonPopoverProperties properties;

  const MoonPopoverTheme({
    required this.colors,
    required this.shadows,
    required this.properties,
  });

  @override
  MoonPopoverTheme copyWith({
    MoonPopoverColors? colors,
    MoonPopoverShadows? shadows,
    MoonPopoverProperties? properties,
  }) {
    return MoonPopoverTheme(
      colors: colors ?? this.colors,
      shadows: shadows ?? this.shadows,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonPopoverTheme lerp(ThemeExtension<MoonPopoverTheme>? other, double t) {
    if (other is! MoonPopoverTheme) return this;

    return MoonPopoverTheme(
      colors: colors.lerp(other.colors, t),
      shadows: shadows.lerp(other.shadows, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonPopoverTheme"))
      ..add(DiagnosticsProperty<MoonPopoverColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonPopoverShadows>("shadows", shadows))
      ..add(DiagnosticsProperty<MoonPopoverProperties>("properties", properties));
  }
}
