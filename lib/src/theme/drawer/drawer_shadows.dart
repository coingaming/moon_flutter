import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonDrawerShadows extends ThemeExtension<MoonDrawerShadows> with DiagnosticableTreeMixin {
  static final light = MoonDrawerShadows(
    drawerShadows: MoonShadows.light.lg,
  );

  static final dark = MoonDrawerShadows(
    drawerShadows: MoonShadows.dark.lg,
  );

  /// Drawer shadows.
  final List<BoxShadow> drawerShadows;

  const MoonDrawerShadows({
    required this.drawerShadows,
  });

  @override
  MoonDrawerShadows copyWith({List<BoxShadow>? drawerShadows}) {
    return MoonDrawerShadows(
      drawerShadows: drawerShadows ?? this.drawerShadows,
    );
  }

  @override
  MoonDrawerShadows lerp(ThemeExtension<MoonDrawerShadows>? other, double t) {
    if (other is! MoonDrawerShadows) return this;

    return MoonDrawerShadows(
      drawerShadows: BoxShadow.lerpList(drawerShadows, other.drawerShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDrawerShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("drawerShadows", drawerShadows));
  }
}
