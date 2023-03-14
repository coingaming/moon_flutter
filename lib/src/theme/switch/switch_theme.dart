import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/switch/switch_colors.dart';
import 'package:moon_design/src/theme/switch/switch_properties.dart';
import 'package:moon_design/src/theme/switch/switch_shadows.dart';
import 'package:moon_design/src/theme/switch/switch_sizes.dart';

@immutable
class MoonSwitchTheme extends ThemeExtension<MoonSwitchTheme> with DiagnosticableTreeMixin {
  static final light = MoonSwitchTheme(
    colors: MoonSwitchColors.light,
    properties: MoonSwitchProperties.properties,
    shadows: MoonSwitchShadows.light,
    sizes: MoonSwitchSizes.sizes,
  );

  static final dark = MoonSwitchTheme(
    colors: MoonSwitchColors.dark,
    properties: MoonSwitchProperties.properties,
    shadows: MoonSwitchShadows.dark,
    sizes: MoonSwitchSizes.sizes,
  );

  /// Switch colors.
  final MoonSwitchColors colors;

  /// Switch properties.
  final MoonSwitchProperties properties;

  /// Switch shadows.
  final MoonSwitchShadows shadows;

  /// Switch sizes.
  final MoonSwitchSizes sizes;

  const MoonSwitchTheme({
    required this.colors,
    required this.properties,
    required this.shadows,
    required this.sizes,
  });

  @override
  MoonSwitchTheme copyWith({
    MoonSwitchColors? colors,
    MoonSwitchProperties? properties,
    MoonSwitchShadows? shadows,
    MoonSwitchSizes? sizes,
  }) {
    return MoonSwitchTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      shadows: shadows ?? this.shadows,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonSwitchTheme lerp(ThemeExtension<MoonSwitchTheme>? other, double t) {
    if (other is! MoonSwitchTheme) return this;

    return MoonSwitchTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      shadows: shadows.lerp(other.shadows, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonSwitchTheme"))
      ..add(DiagnosticsProperty<MoonSwitchColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonSwitchProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonSwitchShadows>("shadows", shadows))
      ..add(DiagnosticsProperty<MoonSwitchSizes>("sizes", sizes));
  }
}
