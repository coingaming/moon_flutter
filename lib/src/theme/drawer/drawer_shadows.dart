import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonDrawerShadows extends ThemeExtension<MoonDrawerShadows> with DiagnosticableTreeMixin {
  /// The list of shadows applied to the MoonDrawer.
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
