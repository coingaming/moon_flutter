import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tab_bar/tab_bar_size_properties.dart';

@immutable
class MoonTabBarSizes extends ThemeExtension<MoonTabBarSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonTabBarSizes(
    sm: MoonTabBarSizeProperties.sm,
    md: MoonTabBarSizeProperties.md,
  );

  /// Small TabBar item properties.
  final MoonTabBarSizeProperties sm;

  /// Medium TabBar item properties.
  final MoonTabBarSizeProperties md;

  const MoonTabBarSizes({
    required this.sm,
    required this.md,
  });

  @override
  MoonTabBarSizes copyWith({
    MoonTabBarSizeProperties? sm,
    MoonTabBarSizeProperties? md,
  }) {
    return MoonTabBarSizes(
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonTabBarSizes lerp(ThemeExtension<MoonTabBarSizes>? other, double t) {
    if (other is! MoonTabBarSizes) return this;

    return MoonTabBarSizes(
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTabBarSizes"))
      ..add(DiagnosticsProperty<MoonTabBarSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonTabBarSizeProperties>("md", md));
  }
}
