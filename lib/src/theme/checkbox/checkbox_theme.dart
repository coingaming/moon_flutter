import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/checkbox/checkbox_colors.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_properties.dart';

@immutable
class MoonCheckboxTheme extends ThemeExtension<MoonCheckboxTheme> with DiagnosticableTreeMixin {
  static final light = MoonCheckboxTheme(
    colors: MoonCheckboxColors.light,
    properties: MoonCheckboxProperties.properties,
  );

  static final dark = MoonCheckboxTheme(
    colors: MoonCheckboxColors.dark,
    properties: MoonCheckboxProperties.properties,
  );

  /// Checkbox colors.
  final MoonCheckboxColors colors;

  /// Checkbox properties.
  final MoonCheckboxProperties properties;

  const MoonCheckboxTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonCheckboxTheme copyWith({
    MoonCheckboxColors? colors,
    MoonCheckboxProperties? properties,
  }) {
    return MoonCheckboxTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonCheckboxTheme lerp(ThemeExtension<MoonCheckboxTheme>? other, double t) {
    if (other is! MoonCheckboxTheme) return this;

    return MoonCheckboxTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonCheckboxTheme"))
      ..add(DiagnosticsProperty<MoonCheckboxColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCheckboxProperties>("properties", properties));
  }
}
