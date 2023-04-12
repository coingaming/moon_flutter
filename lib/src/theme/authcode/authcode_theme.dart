import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/authcode/authcode_colors.dart';
import 'package:moon_design/src/theme/authcode/authcode_properties.dart';

@immutable
class MoonAuthCodeTheme extends ThemeExtension<MoonAuthCodeTheme> with DiagnosticableTreeMixin {
  static final light = MoonAuthCodeTheme(
    colors: MoonAuthCodeColors.light,
    properties: MoonAuthCodeProperties.properties,
  );

  static final dark = MoonAuthCodeTheme(
    colors: MoonAuthCodeColors.dark,
    properties: MoonAuthCodeProperties.properties,
  );

  /// AuthCode colors.
  final MoonAuthCodeColors colors;

  /// AuthCode properties.
  final MoonAuthCodeProperties properties;

  const MoonAuthCodeTheme({
    required this.colors,
    required this.properties,
  });

  @override
  MoonAuthCodeTheme copyWith({
    MoonAuthCodeColors? colors,
    MoonAuthCodeProperties? properties,
  }) {
    return MoonAuthCodeTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonAuthCodeTheme lerp(ThemeExtension<MoonAuthCodeTheme>? other, double t) {
    if (other is! MoonAuthCodeTheme) return this;

    return MoonAuthCodeTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonAuthCodeTheme"))
      ..add(DiagnosticsProperty<MoonAuthCodeColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonAuthCodeProperties>("properties", properties));
  }
}
