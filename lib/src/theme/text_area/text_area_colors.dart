import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonTextAreaColors extends ThemeExtension<MoonTextAreaColors> with DiagnosticableTreeMixin {
  static final light = MoonTextAreaColors(
    backgroundColor: MoonColors.light.gohan,
    borderColor: MoonColors.light.beerus,
  );

  static final dark = MoonTextAreaColors(
    backgroundColor: MoonColors.dark.gohan,
    borderColor: MoonColors.dark.beerus,
  );

  /// TextArea background color.
  final Color backgroundColor;

  /// TextArea border color.
  final Color borderColor;

  const MoonTextAreaColors({
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  MoonTextAreaColors copyWith({
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return MoonTextAreaColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  MoonTextAreaColors lerp(ThemeExtension<MoonTextAreaColors>? other, double t) {
    if (other is! MoonTextAreaColors) return this;

    return MoonTextAreaColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextAreaColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("borderColor", borderColor));
  }
}
