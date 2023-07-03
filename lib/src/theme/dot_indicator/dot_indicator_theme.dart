import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/dot_indicator/dot_indicator_colors.dart';
import 'package:moon_design/src/theme/dot_indicator/dot_indicator_properties.dart';

@immutable
class MoonDotIndicatorTheme extends ThemeExtension<MoonDotIndicatorTheme> with DiagnosticableTreeMixin {
  static final light = MoonDotIndicatorTheme(
    colors: MoonDotIndicatorColors.light,
    properties: MoonDotIndicatorProperties.properties,
  );

  static final dark = MoonDotIndicatorTheme(
    colors: MoonDotIndicatorColors.dark,
    properties: MoonDotIndicatorProperties.properties,
  );

  /// DotIndicator colors.
  final MoonDotIndicatorColors colors;

  /// DotIndicator properties.
  final MoonDotIndicatorProperties properties;

  const MoonDotIndicatorTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonDotIndicatorTheme copyWith({
    MoonDotIndicatorColors? colors,
    MoonDotIndicatorProperties? properties,
  }) {
    return MoonDotIndicatorTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonDotIndicatorTheme lerp(ThemeExtension<MoonDotIndicatorTheme>? other, double t) {
    if (other is! MoonDotIndicatorTheme) return this;

    return MoonDotIndicatorTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonDotIndicatorTheme"))
      ..add(DiagnosticsProperty<MoonDotIndicatorColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonDotIndicatorProperties>("properties", properties));
  }
}
