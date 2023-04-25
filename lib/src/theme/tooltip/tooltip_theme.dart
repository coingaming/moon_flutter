import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tooltip/tooltip_colors.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_properties.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_shadows.dart';

@immutable
class MoonTooltipTheme extends ThemeExtension<MoonTooltipTheme> with DiagnosticableTreeMixin {
  static final light = MoonTooltipTheme(
    colors: MoonTooltipColors.light,
    properties: MoonTooltipProperties.properties,
    shadows: MoonTooltipShadows.light,
  );

  static final dark = MoonTooltipTheme(
    colors: MoonTooltipColors.dark,
    properties: MoonTooltipProperties.properties,
    shadows: MoonTooltipShadows.dark,
  );

  /// Tooltip colors.
  final MoonTooltipColors colors;

  /// Tooltip properties.
  final MoonTooltipProperties properties;

  /// Tooltip shadows.
  final MoonTooltipShadows shadows;

  const MoonTooltipTheme({
    required this.colors,
    required this.properties,
    required this.shadows,
  });

  @override
  MoonTooltipTheme copyWith({
    MoonTooltipColors? colors,
    MoonTooltipProperties? properties,
    MoonTooltipShadows? shadows,
  }) {
    return MoonTooltipTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonTooltipTheme lerp(ThemeExtension<MoonTooltipTheme>? other, double t) {
    if (other is! MoonTooltipTheme) return this;

    return MoonTooltipTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTooltipTheme"))
      ..add(DiagnosticsProperty<MoonTooltipColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTooltipProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonTooltipShadows>("shadows", shadows));
  }
}
