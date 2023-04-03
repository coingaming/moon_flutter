import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/alert/alert_colors.dart';
import 'package:moon_design/src/theme/alert/alert_properties.dart';

@immutable
class MoonAlertTheme extends ThemeExtension<MoonAlertTheme> with DiagnosticableTreeMixin {
  static final light = MoonAlertTheme(
    colors: MoonAlertColors.light,
    properties: MoonAlertProperties.properties,
  );

  static final dark = MoonAlertTheme(
    colors: MoonAlertColors.dark,
    properties: MoonAlertProperties.properties,
  );

  /// Alert colors.
  final MoonAlertColors colors;

  /// Alert properties.
  final MoonAlertProperties properties;

  const MoonAlertTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonAlertTheme copyWith({
    MoonAlertColors? colors,
    MoonAlertProperties? properties,
  }) {
    return MoonAlertTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonAlertTheme lerp(ThemeExtension<MoonAlertTheme>? other, double t) {
    if (other is! MoonAlertTheme) return this;

    return MoonAlertTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAlertTheme"))
      ..add(DiagnosticsProperty<MoonAlertColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAlertProperties>("properties", properties));
  }
}
