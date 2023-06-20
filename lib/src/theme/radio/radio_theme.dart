import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/radio/radio_colors.dart';
import 'package:moon_design/src/theme/radio/radio_properties.dart';

@immutable
class MoonRadioTheme extends ThemeExtension<MoonRadioTheme> with DiagnosticableTreeMixin {
  static final light = MoonRadioTheme(
    colors: MoonRadioColors.light,
    properties: MoonRadioProperties.properties,
  );

  static final dark = MoonRadioTheme(
    colors: MoonRadioColors.dark,
    properties: MoonRadioProperties.properties,
  );

  /// Radio colors.
  final MoonRadioColors colors;

  /// Radio properties.
  final MoonRadioProperties properties;

  const MoonRadioTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonRadioTheme copyWith({
    MoonRadioColors? colors,
    MoonRadioProperties? properties,
  }) {
    return MoonRadioTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonRadioTheme lerp(ThemeExtension<MoonRadioTheme>? other, double t) {
    if (other is! MoonRadioTheme) return this;

    return MoonRadioTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonRadioTheme"))
      ..add(DiagnosticsProperty<MoonRadioColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonRadioProperties>("properties", properties));
  }
}
