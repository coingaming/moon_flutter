import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_colors.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_properties.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_sizes.dart';

@immutable
class MoonBottomSheetTheme extends ThemeExtension<MoonBottomSheetTheme> with DiagnosticableTreeMixin {
  static final light = MoonBottomSheetTheme(
    colors: MoonBottomSheetColors.light,
    properties: MoonBottomSheetProperties.properties,
    sizes: MoonBottomSheetSizes.sizes,
  );

  static final dark = MoonBottomSheetTheme(
    colors: MoonBottomSheetColors.dark,
    properties: MoonBottomSheetProperties.properties,
    sizes: MoonBottomSheetSizes.sizes,
  );

  /// BottomSheet colors.
  final MoonBottomSheetColors colors;

  /// BottomSheet properties.
  final MoonBottomSheetProperties properties;

  /// BottomSheet sizes.
  final MoonBottomSheetSizes sizes;

  const MoonBottomSheetTheme({
    required this.colors,
    required this.properties,
    required this.sizes,
  });

  @override
  MoonBottomSheetTheme copyWith({
    MoonBottomSheetColors? colors,
    MoonBottomSheetProperties? properties,
    MoonBottomSheetSizes? sizes,
  }) {
    return MoonBottomSheetTheme(
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonBottomSheetTheme lerp(ThemeExtension<MoonBottomSheetTheme>? other, double t) {
    if (other is! MoonBottomSheetTheme) return this;

    return MoonBottomSheetTheme(
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
      sizes: sizes.lerp(other.sizes, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonBottomSheetTheme"))
      ..add(DiagnosticsProperty<MoonBottomSheetColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonBottomSheetProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonBottomSheetSizes>("sizes", sizes));
  }
}
