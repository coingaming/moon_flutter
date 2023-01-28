import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import 'package:moon_design/src/theme/text_styles.dart';

@immutable
class MoonTypography extends ThemeExtension<MoonTypography> with DiagnosticableTreeMixin {
  /// Styles for text.
  final MoonTextStyles text;

  /// Styles for headings.
  final MoonTextStyles heading;

  const MoonTypography({
    this.text = MoonTextStyles.text,
    this.heading = MoonTextStyles.heading,
  });

  @override
  MoonTypography copyWith({
    MoonTextStyles? text,
    MoonTextStyles? heading,
  }) {
    return MoonTypography(
      text: text ?? this.text,
      heading: heading ?? this.heading,
    );
  }

  @override
  MoonTypography lerp(ThemeExtension<MoonTypography>? other, double t) {
    if (other is! MoonTypography) return this;

    return MoonTypography(
      text: text.lerp(other.text, t),
      heading: heading.lerp(other.heading, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTypography"))
      ..add(DiagnosticsProperty("text", text))
      ..add(DiagnosticsProperty("heading", heading));
  }
}
