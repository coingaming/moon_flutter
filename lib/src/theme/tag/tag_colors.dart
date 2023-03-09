import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonTagColors extends ThemeExtension<MoonTagColors> with DiagnosticableTreeMixin {
  static final light = MoonTagColors(
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonTagColors(
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Tag background color.
  final Color backgroundColor;

  const MoonTagColors({
    required this.backgroundColor,
  });

  @override
  MoonTagColors copyWith({
    Color? backgroundColor,
  }) {
    return MoonTagColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonTagColors lerp(ThemeExtension<MoonTagColors>? other, double t) {
    if (other is! MoonTagColors) return this;

    return MoonTagColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTagColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
