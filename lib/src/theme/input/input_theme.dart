import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/input/input_colors.dart';
import 'package:moon_design/src/theme/input/input_properties.dart';
import 'package:moon_design/src/theme/input/input_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonInputTheme extends ThemeExtension<MoonInputTheme>
    with DiagnosticableTreeMixin {
  /// The tokens of the Moon Design System.
  final MoonTokens tokens;

  /// The colors of the MoonInput.
  final MoonInputColors colors;

  /// The properties of the MoonInput.
  final MoonInputProperties properties;

  /// The sizes of the MoonInput.
  final MoonInputSizes sizes;

  MoonInputTheme({
    required this.tokens,
    MoonInputColors? colors,
    MoonInputProperties? properties,
    MoonInputSizes? sizes,
  })  : colors = colors ??
            MoonInputColors(
              backgroundColor: tokens.colors.goku,
              activeBorderColor: tokens.colors.piccolo,
              inactiveBorderColor: tokens.colors.beerus,
              errorColor: tokens.colors.chichi,
              hoverColor: tokens.colors.beerus,
              textColor: tokens.colors.textPrimary,
              helperTextColor: tokens.colors.textSecondary,
            ),
        properties = properties ??
            MoonInputProperties(
              // The duration value extracted from:
              // https://github.com/material-components/material-components-android/blob/master/lib/java/com/google/android/material/textfield/TextInputLayout.java
              transitionDuration: const Duration(milliseconds: 167),
              transitionCurve: Curves.fastOutSlowIn,
              helperPadding: EdgeInsets.only(top: tokens.sizes.x4s),
              helperTextStyle: tokens.typography.body.text12,
            ),
        sizes = sizes ?? MoonInputSizes(tokens: tokens);

  @override
  MoonInputTheme copyWith({
    MoonTokens? tokens,
    MoonInputColors? colors,
    MoonInputProperties? properties,
    MoonInputSizes? sizes,
  }) {
    return MoonInputTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonInputTheme lerp(ThemeExtension<MoonInputTheme>? other, double t) {
    if (other is! MoonInputTheme) return this;

    return MoonInputTheme(
      tokens: tokens.lerp(other.tokens, t),
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
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonInputColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonInputProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonInputSizes>("sizes", sizes));
  }
}
