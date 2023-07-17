import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonIconColors extends ThemeExtension<MoonIconColors> with DiagnosticableTreeMixin {
  /// Primary icon color.
  final Color primaryColor;

  const MoonIconColors({
    required this.primaryColor,
  });

  @override
  MoonIconColors copyWith({
    Color? primaryColor,
  }) {
    return MoonIconColors(
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }

  @override
  MoonIconColors lerp(ThemeExtension<MoonIconColors>? other, double t) {
    if (other is! MoonIconColors) return this;

    return MoonIconColors(
      primaryColor: colorPremulLerp(primaryColor, other.primaryColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonIcons"))
      ..add(ColorProperty("primaryColor", primaryColor));
  }
}
