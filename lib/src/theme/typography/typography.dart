import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/typography/text_colors.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTypography extends ThemeExtension<MoonTypography> with DiagnosticableTreeMixin {
  static final light = MoonTypography(
    body: MoonTextStyles.body,
    heading: MoonTextStyles.heading,
    colors: MoonTextColors.light,
  );

  static final dark = MoonTypography(
    body: MoonTextStyles.body,
    heading: MoonTextStyles.heading,
    colors: MoonTextColors.dark,
  );

  /// Styles for body text.
  final MoonTextStyles body;

  /// Styles for headings.
  final MoonTextStyles heading;

  /// Colors for body and icons.
  final MoonTextColors colors;

  const MoonTypography({
    required this.body,
    required this.heading,
    required this.colors,
  });

  @override
  MoonTypography copyWith({
    MoonTextStyles? body,
    MoonTextStyles? heading,
    MoonTextColors? colors,
  }) {
    return MoonTypography(
      body: body ?? this.body,
      heading: heading ?? this.heading,
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonTypography lerp(ThemeExtension<MoonTypography>? other, double t) {
    if (other is! MoonTypography) return this;

    return MoonTypography(
      body: body.lerp(other.body, t),
      heading: heading.lerp(other.heading, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTypography"))
      ..add(DiagnosticsProperty("body", body))
      ..add(DiagnosticsProperty("heading", heading))
      ..add(DiagnosticsProperty("colors", colors));
  }
}
