import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBorderRadiuses extends ThemeExtension<MoonBorderRadiuses> with DiagnosticableTreeMixin {
  static const borders = MoonBorderRadiuses(
    interactiveXs: BorderRadius.all(Radius.circular(4)),
    interactiveSm: BorderRadius.all(Radius.circular(8)),
    interactiveMd: BorderRadius.all(Radius.circular(12)),
    surfaceXs: BorderRadius.all(Radius.circular(4)),
    surfaceSm: BorderRadius.all(Radius.circular(8)),
    surfaceMd: BorderRadius.all(Radius.circular(12)),
    surfaceLg: BorderRadius.all(Radius.circular(16)),
  );

  /// Interactive radius XS.
  final BorderRadiusGeometry interactiveXs;

  /// Interactive radius SM.
  final BorderRadiusGeometry interactiveSm;

  /// Interactive radius MD.
  final BorderRadiusGeometry interactiveMd;

  /// Surface radius XS.
  final BorderRadiusGeometry surfaceXs;

  /// Surface radius SM.
  final BorderRadiusGeometry surfaceSm;

  /// Surface radius MD.
  final BorderRadiusGeometry surfaceMd;

  /// Surface radius LG.
  final BorderRadiusGeometry surfaceLg;

  const MoonBorderRadiuses({
    required this.interactiveXs,
    required this.interactiveSm,
    required this.interactiveMd,
    required this.surfaceXs,
    required this.surfaceSm,
    required this.surfaceMd,
    required this.surfaceLg,
  });

  @override
  MoonBorderRadiuses copyWith({
    BorderRadiusGeometry? interactiveXs,
    BorderRadiusGeometry? interactiveSm,
    BorderRadiusGeometry? interactiveMd,
    BorderRadiusGeometry? surfaceXs,
    BorderRadiusGeometry? surfaceSm,
    BorderRadiusGeometry? surfaceMd,
    BorderRadiusGeometry? surfaceLg,
  }) {
    return MoonBorderRadiuses(
      interactiveXs: interactiveXs ?? this.interactiveXs,
      interactiveSm: interactiveSm ?? this.interactiveSm,
      interactiveMd: interactiveMd ?? this.interactiveMd,
      surfaceXs: surfaceXs ?? this.surfaceXs,
      surfaceSm: surfaceSm ?? this.surfaceSm,
      surfaceMd: surfaceMd ?? this.surfaceMd,
      surfaceLg: surfaceLg ?? this.surfaceLg,
    );
  }

  @override
  MoonBorderRadiuses lerp(ThemeExtension<MoonBorderRadiuses>? other, double t) {
    if (other is! MoonBorderRadiuses) return this;

    return MoonBorderRadiuses(
      interactiveXs: BorderRadiusGeometry.lerp(interactiveXs, other.interactiveXs, t)!,
      interactiveSm: BorderRadiusGeometry.lerp(interactiveSm, other.interactiveSm, t)!,
      interactiveMd: BorderRadiusGeometry.lerp(interactiveMd, other.interactiveMd, t)!,
      surfaceXs: BorderRadiusGeometry.lerp(surfaceXs, other.surfaceXs, t)!,
      surfaceSm: BorderRadiusGeometry.lerp(surfaceSm, other.surfaceSm, t)!,
      surfaceMd: BorderRadiusGeometry.lerp(surfaceMd, other.surfaceMd, t)!,
      surfaceLg: BorderRadiusGeometry.lerp(surfaceLg, other.surfaceLg, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBorderRadiuses"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("interactiveXs", interactiveXs))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("interactiveSm", interactiveSm))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("interactiveMd", interactiveMd))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceXs", surfaceXs))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceSm", surfaceSm))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceMd", surfaceMd))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceLg", surfaceLg));
  }
}
