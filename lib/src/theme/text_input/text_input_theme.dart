import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_input/text_input_colors.dart';
import 'package:moon_design/src/theme/text_input/text_input_properties.dart';
import 'package:moon_design/src/theme/text_input/text_input_sizes.dart';

@immutable
class MoonTextInputTheme extends ThemeExtension<MoonTextInputTheme> with DiagnosticableTreeMixin {
  static final light = MoonTextInputTheme(
    colors: MoonTextInputColors.light,
    properties: MoonTextInputProperties.properties,
    sizes: MoonTextInputSizes.sizes,
  );

  static final dark = MoonTextInputTheme(
    colors: MoonTextInputColors.dark,
    properties: MoonTextInputProperties.properties,
    sizes: MoonTextInputSizes.sizes,
  );

  /// TextInput colors.
  final MoonTextInputColors colors;

  /// TextInput properties.
  final MoonTextInputProperties properties;

  /// TextInput sizes.
  final MoonTextInputSizes sizes;

  const MoonTextInputTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
  });

  @override
  MoonTextInputTheme copyWith({
    MoonTextInputColors? colors,
    MoonTextInputProperties? properties,
    MoonTextInputSizes? sizes,
  }) {
    return MoonTextInputTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTextInputTheme lerp(ThemeExtension<MoonTextInputTheme>? other, double t) {
    if (other is! MoonTextInputTheme) return this;

    return MoonTextInputTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTextInputTheme"))
      ..add(DiagnosticsProperty<MoonTextInputColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTextInputProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonTextInputSizes>("sizes", sizes));
  }
}
