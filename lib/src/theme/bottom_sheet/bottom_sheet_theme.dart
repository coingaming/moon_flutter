import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_colors.dart';
import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonBottomSheetTheme extends ThemeExtension<MoonBottomSheetTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonBottomSheet.
  final MoonBottomSheetColors colors;

  /// The properties of the MoonBottomSheet.
  final MoonBottomSheetProperties properties;

  MoonBottomSheetTheme({
    required this.tokens,
    MoonBottomSheetColors? colors,
    MoonBottomSheetProperties? properties,
  })  : colors = colors ??
            MoonBottomSheetColors(
              textColor: tokens.colors.textPrimary,
              iconColor: tokens.colors.iconPrimary,
              backgroundColor: tokens.colors.goku,
              barrierColor: tokens.colors.zeno,
            ),
        properties = properties ??
            MoonBottomSheetProperties(
              borderRadius: tokens.borders.surfaceLg,
              transitionDuration: const Duration(milliseconds: 350),
              transitionCurve: const Cubic(0.0, 0.0, 0.2, 1.0),
              textStyle: tokens.typography.body.textDefault,
            );

  @override
  MoonBottomSheetTheme copyWith({
    MoonTokens? tokens,
    MoonBottomSheetColors? colors,
    MoonBottomSheetProperties? properties,
  }) {
    return MoonBottomSheetTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonBottomSheetTheme lerp(
    ThemeExtension<MoonBottomSheetTheme>? other,
    double t,
  ) {
    if (other is! MoonBottomSheetTheme) return this;

    return MoonBottomSheetTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonBottomSheetTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonBottomSheetColors>("colors", colors))
      ..add(
        DiagnosticsProperty<MoonBottomSheetProperties>(
          "properties",
          properties,
        ),
      );
  }
}
