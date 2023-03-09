import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonCircularLoaderColors extends ThemeExtension<MoonCircularLoaderColors> with DiagnosticableTreeMixin {
  static final light = MoonCircularLoaderColors(
    color: MoonColors.light.hit,
    backgroundColor: Colors.transparent,
  );

  static final dark = MoonCircularLoaderColors(
    color: MoonColors.dark.hit,
    backgroundColor: Colors.transparent,
  );

  /// Circular loader color.
  final Color color;

  /// Circular loader background color.
  final Color backgroundColor;

  const MoonCircularLoaderColors({
    required this.color,
    required this.backgroundColor,
  });

  @override
  MoonCircularLoaderColors copyWith({
    Color? color,
    Color? backgroundColor,
  }) {
    return MoonCircularLoaderColors(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonCircularLoaderColors lerp(ThemeExtension<MoonCircularLoaderColors>? other, double t) {
    if (other is! MoonCircularLoaderColors) return this;

    return MoonCircularLoaderColors(
      color: Color.lerp(color, other.color, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCircularLoaderColors"))
      ..add(ColorProperty("color", color))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
