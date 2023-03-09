import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonTooltipColors extends ThemeExtension<MoonTooltipColors> with DiagnosticableTreeMixin {
  static final light = MoonTooltipColors(
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonTooltipColors(
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Tooltip background color.
  final Color backgroundColor;

  const MoonTooltipColors({
    required this.backgroundColor,
  });

  @override
  MoonTooltipColors copyWith({Color? backgroundColor}) {
    return MoonTooltipColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonTooltipColors lerp(ThemeExtension<MoonTooltipColors>? other, double t) {
    if (other is! MoonTooltipColors) return this;

    return MoonTooltipColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTooltipColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
