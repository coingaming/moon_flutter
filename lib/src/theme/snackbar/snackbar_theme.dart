import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/snackbar/snackbar_colors.dart';
import 'package:moon_design/src/theme/snackbar/snackbar_properties.dart';
import 'package:moon_design/src/theme/snackbar/snackbar_shadows.dart';

@immutable
class MoonSnackbarTheme extends ThemeExtension<MoonSnackbarTheme> with DiagnosticableTreeMixin {
  static final light = MoonSnackbarTheme(
    colors: MoonSnackbarColors.light,
    properties: MoonSnackbarProperties.properties,
    shadows: MoonSnackbarShadows.light,
  );

  static final dark = MoonSnackbarTheme(
    colors: MoonSnackbarColors.dark,
    properties: MoonSnackbarProperties.properties,
    shadows: MoonSnackbarShadows.dark,
  );

  /// Snackbar colors.
  final MoonSnackbarColors colors;

  /// Snackbar properties.
  final MoonSnackbarProperties properties;

  /// Snackbar shadows.
  final MoonSnackbarShadows shadows;

  const MoonSnackbarTheme({
    required this.colors,
    required this.properties,
    required this.shadows,
  });

  @override
  MoonSnackbarTheme copyWith({
    MoonSnackbarColors? colors,
    MoonSnackbarProperties? properties,
    MoonSnackbarShadows? shadows,
  }) {
    return MoonSnackbarTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonSnackbarTheme lerp(ThemeExtension<MoonSnackbarTheme>? other, double t) {
    if (other is! MoonSnackbarTheme) return this;

    return MoonSnackbarTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonSnackbarTheme"))
      ..add(DiagnosticsProperty<MoonSnackbarColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonSnackbarProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonSnackbarShadows>("shadows", shadows));
  }
}
