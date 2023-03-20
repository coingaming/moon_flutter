import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/radio/radio_colors.dart';

@immutable
class MoonRadioTheme extends ThemeExtension<MoonRadioTheme> with DiagnosticableTreeMixin {
  static final light = MoonRadioTheme(
    colors: MoonRadioColors.light,
  );

  static final dark = MoonRadioTheme(
    colors: MoonRadioColors.dark,
  );

  /// Radio colors.
  final MoonRadioColors colors;

  const MoonRadioTheme({
    required this.colors,
  });

  @override
  MoonRadioTheme copyWith({
    MoonRadioColors? colors,
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
      ..add(DiagnosticsProperty<MoonRadioColors>("colors", colors));
  }
}
