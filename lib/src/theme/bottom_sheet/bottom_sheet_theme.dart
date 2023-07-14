import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_colors.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_properties.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonBottomSheetTheme extends ThemeExtension<MoonBottomSheetTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// BottomSheet colors.
  final MoonBottomSheetColors colors;

  /// BottomSheet properties.
  final MoonBottomSheetProperties properties;

  /// BottomSheet sizes.
  final MoonBottomSheetSizes sizes;

  MoonBottomSheetTheme({
    required this.tokens,
    MoonBottomSheetColors? colors,
    MoonBottomSheetProperties? properties,
    MoonBottomSheetSizes? sizes,
  })  : colors = colors ??
            MoonBottomSheetColors(
              textColor: tokens.typography.colors.bodyPrimary,
              iconColor: tokens.iconography.colors.primaryColor,
              backgroundColor: tokens.colors.gohan,
              barrierColor: tokens.colors.zeno,
            ),
        properties = properties ??
            MoonBottomSheetProperties(
              borderRadius: tokens.borders.surfaceLg,
              transitionDuration: tokens.transitions.defaultTransitionDuration,
              transitionCurve: tokens.transitions.defaultTransitionCurve,
              textStyle: tokens.typography.body.textDefault,
            ),
        sizes = sizes ?? MoonBottomSheetSizes(tokens: tokens);

  @override
  MoonBottomSheetTheme copyWith({
    MoonTokens? tokens,
    MoonBottomSheetColors? colors,
    MoonBottomSheetProperties? properties,
    MoonBottomSheetSizes? sizes,
  }) {
    return MoonBottomSheetTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonBottomSheetTheme lerp(ThemeExtension<MoonBottomSheetTheme>? other, double t) {
    if (other is! MoonBottomSheetTheme) return this;

    return MoonBottomSheetTheme(
      tokens: tokens,
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
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonBottomSheetColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonBottomSheetProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonBottomSheetSizes>("sizes", sizes));
  }
}
