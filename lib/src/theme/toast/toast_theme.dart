import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/toast/toast_colors.dart';
import 'package:moon_design/src/theme/toast/toast_properties.dart';
import 'package:moon_design/src/theme/toast/toast_shadows.dart';

@immutable
class MoonToastTheme extends ThemeExtension<MoonToastTheme> with DiagnosticableTreeMixin {
  static final light = MoonToastTheme(
    colors: MoonToastColors.light,
    properties: MoonToastProperties.properties,
    shadows: MoonToastShadows.light,
  );

  static final dark = MoonToastTheme(
    colors: MoonToastColors.dark,
    properties: MoonToastProperties.properties,
    shadows: MoonToastShadows.dark,
  );

  /// Toast colors.
  final MoonToastColors colors;

  /// Toast properties.
  final MoonToastProperties properties;

  /// Toast shadows.
  final MoonToastShadows shadows;

  const MoonToastTheme({
    required this.colors,
    required this.properties,
    required this.shadows,
  });

  @override
  MoonToastTheme copyWith({
    MoonToastColors? colors,
    MoonToastProperties? properties,
    MoonToastShadows? shadows,
  }) {
    return MoonToastTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonToastTheme lerp(ThemeExtension<MoonToastTheme>? other, double t) {
    if (other is! MoonToastTheme) return this;

    return MoonToastTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonToastTheme"))
      ..add(DiagnosticsProperty<MoonToastColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonToastProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonToastShadows>("shadows", shadows));
  }
}
