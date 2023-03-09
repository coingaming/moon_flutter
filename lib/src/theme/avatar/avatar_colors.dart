import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonAvatarColors extends ThemeExtension<MoonAvatarColors> with DiagnosticableTreeMixin {
  static final light = MoonAvatarColors(
    backgroundColor: MoonColors.light.gohan,
    badgeColor: MoonColors.light.roshi100,
  );

  static final dark = MoonAvatarColors(
    backgroundColor: MoonColors.dark.gohan,
    badgeColor: MoonColors.dark.roshi100,
  );

  /// Avatar background color.
  final Color backgroundColor;

  /// Avatar badge color.
  final Color badgeColor;

  const MoonAvatarColors({
    required this.backgroundColor,
    required this.badgeColor,
  });

  @override
  MoonAvatarColors copyWith({
    Color? backgroundColor,
    Color? badgeColor,
  }) {
    return MoonAvatarColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      badgeColor: badgeColor ?? this.badgeColor,
    );
  }

  @override
  MoonAvatarColors lerp(ThemeExtension<MoonAvatarColors>? other, double t) {
    if (other is! MoonAvatarColors) return this;

    return MoonAvatarColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      badgeColor: Color.lerp(badgeColor, other.badgeColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor))
      ..add(ColorProperty("badgeColor", badgeColor));
  }
}
