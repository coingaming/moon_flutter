import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonSnackbarColors extends ThemeExtension<MoonSnackbarColors> with DiagnosticableTreeMixin {
  static final light = MoonSnackbarColors(
    lightVariantBackgroundColor: MoonColors.light.gohan,
    darkVariantBackgroundColor: MoonColors.dark.gohan,
  );

  static final dark = MoonSnackbarColors(
    lightVariantBackgroundColor: MoonColors.dark.gohan,
    darkVariantBackgroundColor: MoonColors.light.gohan,
  );

  /// Snackbar light varian background color.
  final Color lightVariantBackgroundColor;

  /// Snackbar dark variant background color.
  final Color darkVariantBackgroundColor;

  const MoonSnackbarColors({
    required this.lightVariantBackgroundColor,
    required this.darkVariantBackgroundColor,
  });

  @override
  MoonSnackbarColors copyWith({
    Color? lightVariantBackgroundColor,
    Color? darkVariantBackgroundColor,
  }) {
    return MoonSnackbarColors(
      lightVariantBackgroundColor: lightVariantBackgroundColor ?? this.lightVariantBackgroundColor,
      darkVariantBackgroundColor: darkVariantBackgroundColor ?? this.darkVariantBackgroundColor,
    );
  }

  @override
  MoonSnackbarColors lerp(ThemeExtension<MoonSnackbarColors>? other, double t) {
    if (other is! MoonSnackbarColors) return this;

    return MoonSnackbarColors(
      lightVariantBackgroundColor: Color.lerp(lightVariantBackgroundColor, other.lightVariantBackgroundColor, t)!,
      darkVariantBackgroundColor: Color.lerp(darkVariantBackgroundColor, other.darkVariantBackgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSnackbarColors"))
      ..add(ColorProperty("lightVariantBackgroundColor", lightVariantBackgroundColor))
      ..add(ColorProperty("darkVariantBackgroundColor", darkVariantBackgroundColor));
  }
}
