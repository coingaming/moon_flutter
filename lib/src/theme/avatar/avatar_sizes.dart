import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_size_properties.dart';

@immutable
class MoonAvatarSizes extends ThemeExtension<MoonAvatarSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonAvatarSizes(
    xs: MoonAvatarSizeProperties.xs,
    sm: MoonAvatarSizeProperties.sm,
    md: MoonAvatarSizeProperties.md,
    lg: MoonAvatarSizeProperties.lg,
    xl: MoonAvatarSizeProperties.xl,
    x2l: MoonAvatarSizeProperties.x2l,
  );

  /// Extra small avatar properties.
  final MoonAvatarSizeProperties xs;

  /// Small avatar properties.
  final MoonAvatarSizeProperties sm;

  /// Medium avatar properties.
  final MoonAvatarSizeProperties md;

  /// Large avatar properties.
  final MoonAvatarSizeProperties lg;

  /// Extra large avatar properties.
  final MoonAvatarSizeProperties xl;

  /// (2x) Extra large avatar properties.
  final MoonAvatarSizeProperties x2l;

  const MoonAvatarSizes({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.x2l,
  });

  @override
  MoonAvatarSizes copyWith({
    MoonAvatarSizeProperties? xs,
    MoonAvatarSizeProperties? sm,
    MoonAvatarSizeProperties? md,
    MoonAvatarSizeProperties? lg,
    MoonAvatarSizeProperties? xl,
    MoonAvatarSizeProperties? x2l,
  }) {
    return MoonAvatarSizes(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
    );
  }

  @override
  MoonAvatarSizes lerp(ThemeExtension<MoonAvatarSizes>? other, double t) {
    if (other is! MoonAvatarSizes) return this;

    return MoonAvatarSizes(
      xs: xs.lerp(other.xs, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
      x2l: x2l.lerp(other.x2l, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAvatarSizes"))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("xs", xs))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("xl", xl))
      ..add(DiagnosticsProperty<MoonAvatarSizeProperties>("x2l", x2l));
  }
}
