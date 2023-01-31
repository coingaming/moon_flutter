import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBorders extends ThemeExtension<MoonBorders> with DiagnosticableTreeMixin {
  static const borders = MoonBorders(
    interactiveXs: BorderRadius.all(Radius.circular(4)),
    interactiveSm: BorderRadius.all(Radius.circular(8)),
    interactiveMd: BorderRadius.all(Radius.circular(12)),
    surfaceXs: BorderRadius.all(Radius.circular(4)),
    surfaceSm: BorderRadius.all(Radius.circular(8)),
    surfaceMd: BorderRadius.all(Radius.circular(12)),
    surfaceLg: BorderRadius.all(Radius.circular(16)),
    borderWidth: 1,
  );

  /// Interactive radius XS.
  final BorderRadius interactiveXs;

  /// Interactive radius SM.
  final BorderRadius interactiveSm;

  /// Interactive radius MD.
  final BorderRadius interactiveMd;

  /// Surface radius XS.
  final BorderRadius surfaceXs;

  /// Surface radius SM.
  final BorderRadius surfaceSm;

  /// Surface radius MD.
  final BorderRadius surfaceMd;

  /// Surface radius LG.
  final BorderRadius surfaceLg;

  /// Default border width.
  final double borderWidth;

  const MoonBorders({
    required this.interactiveXs,
    required this.interactiveSm,
    required this.interactiveMd,
    required this.surfaceXs,
    required this.surfaceSm,
    required this.surfaceMd,
    required this.surfaceLg,
    required this.borderWidth,
  });

  @override
  MoonBorders copyWith({
    BorderRadius? interactiveXs,
    BorderRadius? interactiveSm,
    BorderRadius? interactiveMd,
    BorderRadius? surfaceXs,
    BorderRadius? surfaceSm,
    BorderRadius? surfaceMd,
    BorderRadius? surfaceLg,
    double? borderWidth,
  }) {
    return MoonBorders(
      interactiveXs: interactiveXs ?? this.interactiveXs,
      interactiveSm: interactiveSm ?? this.interactiveSm,
      interactiveMd: interactiveMd ?? this.interactiveMd,
      surfaceXs: surfaceXs ?? this.surfaceXs,
      surfaceSm: surfaceSm ?? this.surfaceSm,
      surfaceMd: surfaceMd ?? this.surfaceMd,
      surfaceLg: surfaceLg ?? this.surfaceLg,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  @override
  MoonBorders lerp(ThemeExtension<MoonBorders>? other, double t) {
    if (other is! MoonBorders) return this;

    return MoonBorders(
      interactiveXs: BorderRadius.lerp(interactiveXs, other.interactiveXs, t)!,
      interactiveSm: BorderRadius.lerp(interactiveSm, other.interactiveSm, t)!,
      interactiveMd: BorderRadius.lerp(interactiveMd, other.interactiveMd, t)!,
      surfaceXs: BorderRadius.lerp(surfaceXs, other.surfaceXs, t)!,
      surfaceSm: BorderRadius.lerp(surfaceSm, other.surfaceSm, t)!,
      surfaceMd: BorderRadius.lerp(surfaceMd, other.surfaceMd, t)!,
      surfaceLg: BorderRadius.lerp(surfaceLg, other.surfaceLg, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBorders"))
      ..add(DiagnosticsProperty<BorderRadius>("interactiveXs", interactiveXs))
      ..add(DiagnosticsProperty<BorderRadius>("interactiveSm", interactiveSm))
      ..add(DiagnosticsProperty<BorderRadius>("interactiveMd", interactiveMd))
      ..add(DiagnosticsProperty<BorderRadius>("surfaceXs", surfaceXs))
      ..add(DiagnosticsProperty<BorderRadius>("surfaceSm", surfaceSm))
      ..add(DiagnosticsProperty<BorderRadius>("surfaceMd", surfaceMd))
      ..add(DiagnosticsProperty<BorderRadius>("surfaceLg", surfaceLg))
      ..add(DoubleProperty("borderWidth", borderWidth));
  }
}
