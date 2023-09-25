import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_input/text_input_colors.dart';
import 'package:moon_design/src/theme/text_input/text_input_properties.dart';
import 'package:moon_design/src/theme/text_input/text_input_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTextInputTheme extends ThemeExtension<MoonTextInputTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// TextInput colors.
  final MoonTextInputColors colors;

  /// TextInput properties.
  final MoonTextInputProperties properties;

  /// TextInput sizes.
  final MoonTextInputSizes sizes;

  MoonTextInputTheme({
    required this.tokens,
    MoonTextInputColors? colors,
    MoonTextInputProperties? properties,
    MoonTextInputSizes? sizes,
  })  : colors = colors ??
            MoonTextInputColors(
              backgroundColor: tokens.colors.goku,
              activeBorderColor: tokens.colors.piccolo,
              inactiveBorderColor: tokens.colors.beerus,
              errorColor: tokens.colors.chiChi100,
              hoverBorderColor: tokens.colors.beerus,
              textColor: tokens.colors.textPrimary,
              helperTextColor: tokens.colors.textSecondary,
            ),
        properties = properties ??
            MoonTextInputProperties(
              // The duration value extracted from:
              // https://github.com/material-components/material-components-android/blob/master/lib/java/com/google/android/material/textfield/TextInputLayout.java
              transitionDuration: const Duration(milliseconds: 167),
              transitionCurve: Curves.fastOutSlowIn,
              helperPadding: EdgeInsets.only(
                left: tokens.sizes.x3s,
                top: tokens.sizes.x4s,
                right: tokens.sizes.x3s,
              ),
              helperTextStyle: tokens.typography.body.text12,
            ),
        sizes = sizes ?? MoonTextInputSizes(tokens: tokens);

  @override
  MoonTextInputTheme copyWith({
    MoonTokens? tokens,
    MoonTextInputColors? colors,
    MoonTextInputProperties? properties,
    MoonTextInputSizes? sizes,
  }) {
    return MoonTextInputTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
      sizes: sizes ?? this.sizes,
    );
  }

  @override
  MoonTextInputTheme lerp(ThemeExtension<MoonTextInputTheme>? other, double t) {
    if (other is! MoonTextInputTheme) return this;

    return MoonTextInputTheme(
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
      ..add(DiagnosticsProperty("type", "MoonTextInputTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTextInputColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonTextInputProperties>("properties", properties))
      ..add(DiagnosticsProperty<MoonTextInputSizes>("sizes", sizes));
  }
}
