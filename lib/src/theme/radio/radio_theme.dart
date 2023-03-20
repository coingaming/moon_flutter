import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/checkbox/checkbox_colors.dart';
import 'package:moon_design/src/theme/checkbox/checkbox_properties.dart';

@immutable
class MoonRadioTheme extends ThemeExtension<MoonRadioTheme> with DiagnosticableTreeMixin {
  static final light = MoonRadioTheme(
    colors: MoonCheckboxColors.light,
  );

  static final dark = MoonRadioTheme(
    colors: MoonCheckboxColors.dark,
  );

  /// Radio colors.
  final MoonCheckboxColors colors;

  const MoonRadioTheme({
    required this.colors,
  });

  @override
  MoonRadioTheme copyWith({
    MoonCheckboxColors? colors,
  }) {
    return MoonRadioTheme(
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonRadioTheme lerp(ThemeExtension<MoonRadioTheme>? other, double t) {
    if (other is! MoonRadioTheme) return this;

    return MoonRadioTheme(
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonRadioTheme"))
      ..add(DiagnosticsProperty<MoonCheckboxColors>("colors", colors));
  }
}
