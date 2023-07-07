import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/drawer/drawer_colors.dart';
import 'package:moon_design/src/theme/drawer/drawer_properties.dart';
import 'package:moon_design/src/theme/drawer/drawer_shadows.dart';

@immutable
class MoonDrawerTheme extends ThemeExtension<MoonDrawerTheme> with DiagnosticableTreeMixin {
  static final light = MoonDrawerTheme(
    colors: MoonDrawerColors.light,
    properties: MoonDrawerProperties.properties,
    shadows: MoonDrawerShadows.light,
  );

  static final dark = MoonDrawerTheme(
    colors: MoonDrawerColors.dark,
    properties: MoonDrawerProperties.properties,
    shadows: MoonDrawerShadows.dark,
  );

  /// Drawer colors.
  final MoonDrawerColors colors;

  /// Drawer properties.
  final MoonDrawerProperties properties;

  /// Drawer shadows.
  final MoonDrawerShadows shadows;

  const MoonDrawerTheme({
    required this.colors,
    required this.properties,
    required this.shadows,
  });

  @override
  MoonDrawerTheme copyWith({
    MoonDrawerColors? colors,
    MoonDrawerProperties? properties,
    MoonDrawerShadows? shadows,
  }) {
    return MoonDrawerTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonDrawerTheme lerp(ThemeExtension<MoonDrawerTheme>? other, double t) {
    if (other is! MoonDrawerTheme) return this;

    return MoonDrawerTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonDrawerTheme"))
      ..add(DiagnosticsProperty<MoonDrawerColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonDrawerProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonDrawerShadows>("shadows", shadows));
  }
}
