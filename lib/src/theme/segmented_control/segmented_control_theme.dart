import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/segmented_control/segmented_control_colors.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_properties.dart';
import 'package:moon_design/src/theme/segmented_control/segmented_control_sizes.dart';

@immutable
class MoonSegmentedControlTheme extends ThemeExtension<MoonSegmentedControlTheme> with DiagnosticableTreeMixin {
  static final light = MoonSegmentedControlTheme(
    colors: MoonSegmentedControlColors.light,
    properties: MoonSegmentedControlProperties.properties,
    sizes: MoonSegmentedControlSizes.sizes,
  );

  static final dark = MoonSegmentedControlTheme(
    colors: MoonSegmentedControlColors.dark,
    properties: MoonSegmentedControlProperties.properties,
    sizes: MoonSegmentedControlSizes.sizes,
  );

  /// SegmentedControl colors.
  final MoonSegmentedControlColors colors;

  /// SegmentedControl properties.
  final MoonSegmentedControlProperties properties;

  /// SegmentedControl sizes.
  final MoonSegmentedControlSizes sizes;

  const MoonSegmentedControlTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
  });

  @override
  MoonSegmentedControlTheme copyWith({
    MoonSegmentedControlColors? colors,
    MoonSegmentedControlProperties? properties,
    MoonSegmentedControlSizes? sizes,
  }) {
    return MoonSegmentedControlTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonSegmentedControlTheme lerp(ThemeExtension<MoonSegmentedControlTheme>? other, double t) {
    if (other is! MoonSegmentedControlTheme) return this;

    return MoonSegmentedControlTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlTheme"))
      ..add(DiagnosticsProperty<MoonSegmentedControlColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonSegmentedControlProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonSegmentedControlSizes>("sizes", sizes));
  }
}
