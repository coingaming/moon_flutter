import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/input/input_colors.dart';
import 'package:moon_design/src/theme/input/input_properties.dart';
import 'package:moon_design/src/theme/input/input_sizes.dart';

@immutable
class MoonInputTheme extends ThemeExtension<MoonInputTheme> with DiagnosticableTreeMixin {
  static final light = MoonInputTheme(
    colors: MoonInputColors.light,
    properties: MoonInputProperties.properties,
    sizes: MoonInputSizes.sizes,
  );

  static final dark = MoonInputTheme(
    colors: MoonInputColors.dark,
    properties: MoonInputProperties.properties,
    sizes: MoonInputSizes.sizes,
  );

  /// Input colors.
  final MoonInputColors colors;

  /// Input properties.
  final MoonInputProperties properties;

  /// Input sizes.
  final MoonInputSizes sizes;

  const MoonInputTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
  });

  @override
  MoonInputTheme copyWith({
    MoonInputColors? colors,
    MoonInputProperties? properties,
    MoonInputSizes? sizes,
  }) {
    return MoonInputTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonInputTheme lerp(ThemeExtension<MoonInputTheme>? other, double t) {
    if (other is! MoonInputTheme) return this;

    return MoonInputTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonInputTheme"))
      ..add(DiagnosticsProperty<MoonInputColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonInputProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonInputSizes>("sizes", sizes));
  }
}
