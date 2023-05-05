import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_area/text_area_colors.dart';
import 'package:moon_design/src/theme/text_area/text_area_properties.dart';

@immutable
class MoonTextAreaTheme extends ThemeExtension<MoonTextAreaTheme> with DiagnosticableTreeMixin {
  static final light = MoonTextAreaTheme(
    colors: MoonTextAreaColors.light,
    properties: MoonTextAreaProperties.properties,
  );

  static final dark = MoonTextAreaTheme(
    colors: MoonTextAreaColors.dark,
    properties: MoonTextAreaProperties.properties,
  );

  /// TextArea colors.
  final MoonTextAreaColors colors;

  /// TextArea properties.
  final MoonTextAreaProperties properties;

  const MoonTextAreaTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonTextAreaTheme copyWith({
    MoonTextAreaColors? colors,
    MoonTextAreaProperties? properties,
  }) {
    return MoonTextAreaTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonTextAreaTheme lerp(ThemeExtension<MoonTextAreaTheme>? other, double t) {
    if (other is! MoonTextAreaTheme) return this;

    return MoonTextAreaTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTextAreaTheme"))
      ..add(DiagnosticsProperty<MoonTextAreaColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTextAreaProperties>("properties", properties));
  }
}
