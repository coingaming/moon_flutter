import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonPopoverColors extends ThemeExtension<MoonPopoverColors> with DiagnosticableTreeMixin {
  static final light = MoonPopoverColors(
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonPopoverColors(
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Popover background color.
  final Color backgroundColor;

  const MoonPopoverColors({
    required this.backgroundColor,
  });

  @override
  MoonPopoverColors copyWith({Color? backgroundColor}) {
    return MoonPopoverColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonPopoverColors lerp(ThemeExtension<MoonPopoverColors>? other, double t) {
    if (other is! MoonPopoverColors) return this;

    return MoonPopoverColors(
      backgroundColor: colorPremulLerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
