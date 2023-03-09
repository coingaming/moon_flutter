import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/avatar/avatar_colors.dart';

import 'package:moon_design/src/theme/avatar/avatar_sizes.dart';

@immutable
class MoonAvatarTheme extends ThemeExtension<MoonAvatarTheme> with DiagnosticableTreeMixin {
  static final light = MoonAvatarTheme(
    xs: MoonAvatarSizes.xs,
    sm: MoonAvatarSizes.sm,
    md: MoonAvatarSizes.md,
    lg: MoonAvatarSizes.lg,
    xl: MoonAvatarSizes.xl,
    x2l: MoonAvatarSizes.x2l,
    colors: MoonAvatarColors.light,
  );

  static final dark = MoonAvatarTheme(
    xs: MoonAvatarSizes.xs,
    sm: MoonAvatarSizes.sm,
    md: MoonAvatarSizes.md,
    lg: MoonAvatarSizes.lg,
    xl: MoonAvatarSizes.xl,
    x2l: MoonAvatarSizes.x2l,
    colors: MoonAvatarColors.dark,
  );

  /// Extra small avatar properties.
  final MoonAvatarSizes xs;

  /// Small avatar properties.
  final MoonAvatarSizes sm;

  /// Medium avatar properties.
  final MoonAvatarSizes md;

  /// Large avatar properties.
  final MoonAvatarSizes lg;

  /// Extra large avatar properties.
  final MoonAvatarSizes xl;

  /// (2x) Extra large avatar properties.
  final MoonAvatarSizes x2l;

  /// Avatar colors.
  final MoonAvatarColors colors;

  const MoonAvatarTheme({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.x2l,
    required this.colors,
  });

  @override
  MoonAvatarTheme copyWith({
    MoonAvatarSizes? xs,
    MoonAvatarSizes? sm,
    MoonAvatarSizes? md,
    MoonAvatarSizes? lg,
    MoonAvatarSizes? xl,
    MoonAvatarSizes? x2l,
    MoonAvatarColors? colors,
  }) {
    return MoonAvatarTheme(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
      colors: colors ?? this.colors,
    );
  }

  @override
  MoonAvatarTheme lerp(ThemeExtension<MoonAvatarTheme>? other, double t) {
    if (other is! MoonAvatarTheme) return this;

    return MoonAvatarTheme(
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
      x2l: x2l.lerp(other.x2l, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarTheme"))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("xs", xs))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("sm", sm))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("md", md))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("lg", lg))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("xl", xl))
      ..add(DiagnosticsProperty<MoonAvatarSizes>("x2l", x2l))
      ..add(DiagnosticsProperty<MoonAvatarColors>("colors", colors));
  }
}
