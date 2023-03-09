import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tooltip/tooltip_colors.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_properties.dart';
import 'package:moon_design/src/theme/tooltip/tooltip_shadows.dart';

@immutable
class MoonTooltipTheme extends ThemeExtension<MoonTooltipTheme> with DiagnosticableTreeMixin {
  static final light = MoonTooltipTheme(
    colors: MoonTooltipColors.light,
    shadows: MoonTooltipShadows.light,
    properties: MoonTooltipProperties.properties,
  );

  static final dark = MoonTooltipTheme(
    colors: MoonTooltipColors.dark,
    shadows: MoonTooltipShadows.dark,
    properties: MoonTooltipProperties.properties,
  );

  /// Tooltip colors.
  final MoonTooltipColors colors;

  /// Tooltip shadows.
  final MoonTooltipShadows shadows;

  /// Tooltip properties.
  final MoonTooltipProperties properties;

  const MoonTooltipTheme({
    required this.colors,
    required this.shadows,
    required this.properties,
  });

  @override
  MoonTooltipTheme copyWith({
    MoonTooltipColors? colors,
    MoonTooltipShadows? shadows,
    MoonTooltipProperties? properties,
  }) {
    return MoonTooltipTheme(
      colors: colors ?? this.colors,
      shadows: shadows ?? this.shadows,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonTooltipTheme lerp(ThemeExtension<MoonTooltipTheme>? other, double t) {
    if (other is! MoonTooltipTheme) return this;

    return MoonTooltipTheme(
      colors: colors.lerp(other.colors, t),
      shadows: shadows.lerp(other.shadows, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTooltipTheme"))
      ..add(DiagnosticsProperty<MoonTooltipColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTooltipShadows>("shadows", shadows))
      ..add(DiagnosticsProperty<MoonTooltipProperties>("properties", properties));
  }
}
