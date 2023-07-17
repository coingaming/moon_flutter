import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonTypography extends ThemeExtension<MoonTypography> with DiagnosticableTreeMixin {
  static const typography = MoonTypography(
    body: MoonTextStyles.body,
    caption: MoonTextStyles.caption,
    heading: MoonTextStyles.heading,
  );

  /// Styles for body text.
  final MoonTextStyles body;

  /// Styles for body text.
  final MoonTextStyles caption;

  /// Styles for headings.
  final MoonTextStyles heading;

  const MoonTypography({
    required this.body,
    required this.caption,
    required this.heading,
  });

  @override
  MoonTypography copyWith({
    MoonTextStyles? body,
    MoonTextStyles? caption,
    MoonTextStyles? heading,
  }) {
    return MoonTypography(
      body: body ?? this.body,
      caption: caption ?? this.caption,
      heading: heading ?? this.heading,
    );
  }

  @override
  MoonTypography lerp(ThemeExtension<MoonTypography>? other, double t) {
    if (other is! MoonTypography) return this;

    return MoonTypography(
      body: body.lerp(other.body, t),
      caption: caption.lerp(other.caption, t),
      heading: heading.lerp(other.heading, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTypography"))
      ..add(DiagnosticsProperty("body", body))
      ..add(DiagnosticsProperty("caption", caption))
      ..add(DiagnosticsProperty("heading", heading));
  }
}
