import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/typography/text_colors.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTypography extends ThemeExtension<MoonTypography> with DiagnosticableTreeMixin {
  static final light = MoonTypography(
    text: MoonTextStyles.text,
    heading: MoonTextStyles.heading,
    colors: MoonTextColors.light,
  );

  static final dark = MoonTypography(
    text: MoonTextStyles.text,
    heading: MoonTextStyles.heading,
    colors: MoonTextColors.dark,
  );

  /// Styles for text.
  final MoonTextStyles text;

  /// Styles for headings.
  final MoonTextStyles heading;

  /// Colors for text and icons.
  final MoonTextColors colors;

  const MoonTypography({
    required this.text,
    required this.heading,
    required this.colors,
  });

  @override
  MoonTypography copyWith({
    MoonTextStyles? text,
    MoonTextStyles? heading,
    MoonTextColors? colors,
  }) {
    return MoonTypography(
      text: text ?? this.text,
      heading: heading ?? this.heading,
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonTypography lerp(ThemeExtension<MoonTypography>? other, double t) {
    if (other is! MoonTypography) return this;

    return MoonTypography(
      text: text.lerp(other.text, t),
      heading: heading.lerp(other.heading, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTypography"))
      ..add(DiagnosticsProperty("text", text))
      ..add(DiagnosticsProperty("heading", heading))
      ..add(DiagnosticsProperty("colors", colors));
  }
}
