import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonLinearLoaderColors extends ThemeExtension<MoonLinearLoaderColors> with DiagnosticableTreeMixin {
  static final light = MoonLinearLoaderColors(
    color: MoonColors.light.hit,
    backgroundColor: Colors.transparent,
  );

  static final dark = MoonLinearLoaderColors(
    color: MoonColors.dark.hit,
    backgroundColor: Colors.transparent,
  );

  /// Linear loader color.
  final Color color;

  /// Linear loader background color.
  final Color backgroundColor;

  const MoonLinearLoaderColors({
    required this.color,
    required this.backgroundColor,
  });

  @override
  MoonLinearLoaderColors copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return MoonLinearLoaderColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonLinearLoaderColors lerp(ThemeExtension<MoonLinearLoaderColors>? other, double t) {
    if (other is! MoonLinearLoaderColors) return this;

    return MoonLinearLoaderColors(
      color: Color.lerp(color, other.color, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonLinearLoaderColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
