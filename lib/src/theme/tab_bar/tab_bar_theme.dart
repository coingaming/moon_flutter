import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tab_bar/tab_bar_colors.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_properties.dart';
import 'package:moon_design/src/theme/tab_bar/tab_bar_sizes.dart';

@immutable
class MoonTabBarTheme extends ThemeExtension<MoonTabBarTheme> with DiagnosticableTreeMixin {
  static final light = MoonTabBarTheme(
    colors: MoonTabBarColors.light,
    properties: MoonTabBarProperties.properties,
    sizes: MoonTabBarSizes.sizes,
  );

  static final dark = MoonTabBarTheme(
    colors: MoonTabBarColors.dark,
    properties: MoonTabBarProperties.properties,
    sizes: MoonTabBarSizes.sizes,
  );

  /// TabBar colors.
  final MoonTabBarColors colors;

  /// TabBar properties.
  final MoonTabBarProperties properties;

  /// TabBar sizes.
  final MoonTabBarSizes sizes;

  const MoonTabBarTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
  });

  @override
  MoonTabBarTheme copyWith({
    MoonTabBarColors? colors,
    MoonTabBarProperties? properties,
    MoonTabBarSizes? sizes,
  }) {
    return MoonTabBarTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTabBarTheme lerp(ThemeExtension<MoonTabBarTheme>? other, double t) {
    if (other is! MoonTabBarTheme) return this;

    return MoonTabBarTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonTabBarTheme"))
      ..add(DiagnosticsProperty<MoonTabBarColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTabBarProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonTabBarSizes>("sizes", sizes));
  }
}
