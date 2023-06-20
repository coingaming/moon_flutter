import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/modal/modal_colors.dart';
import 'package:moon_design/src/theme/modal/modal_properties.dart';

@immutable
class MoonModalTheme extends ThemeExtension<MoonModalTheme> with DiagnosticableTreeMixin {
  static final light = MoonModalTheme(
    colors: MoonModalColors.light,
    properties: MoonModalProperties.properties,
  );

  static final dark = MoonModalTheme(
    colors: MoonModalColors.dark,
    properties: MoonModalProperties.properties,
  );

  /// Modal colors.
  final MoonModalColors colors;

  /// Modal properties.
  final MoonModalProperties properties;

  const MoonModalTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonModalTheme copyWith({
    MoonModalColors? colors,
    MoonModalProperties? properties,
  }) {
    return MoonModalTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonModalTheme lerp(ThemeExtension<MoonModalTheme>? other, double t) {
    if (other is! MoonModalTheme) return this;

    return MoonModalTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonModalTheme"))
      ..add(DiagnosticsProperty<MoonModalColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonModalProperties>("properties", properties));
  }
}
