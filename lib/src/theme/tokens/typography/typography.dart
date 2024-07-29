import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonTypography extends ThemeExtension<MoonTypography>
    with DiagnosticableTreeMixin {
  static const typography = MoonTypography(
    body: MoonTextStyles.body,
    heading: MoonTextStyles.heading,
  );

  /// The text styles for the body.
  final MoonTextStyles body;

  /// The text styles for the heading.
  final MoonTextStyles heading;

  const MoonTypography({required this.body, required this.heading});

  @override
  MoonTypography copyWith({MoonTextStyles? body, MoonTextStyles? heading}) {
    return MoonTypography(
      body: body ?? this.body,
      heading: heading ?? this.heading,
    );
  }

  @override
  MoonTypography lerp(ThemeExtension<MoonTypography>? other, double t) {
    if (other is! MoonTypography) return this;

    return MoonTypography(
      body: body.lerp(other.body, t),
      heading: heading.lerp(other.heading, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTypography"))
      ..add(DiagnosticsProperty("body", body))
      ..add(DiagnosticsProperty("heading", heading));
  }
}
