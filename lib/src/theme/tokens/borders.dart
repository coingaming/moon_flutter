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
    defaultBorderWidth: 1,
    activeBorderWidth: 1.5,
  );

  /// The extra small interactive radius.
  final BorderRadiusGeometry interactiveXs;

  /// The small interactive radius.
  final BorderRadiusGeometry interactiveSm;

  /// The medium interactive radius.
  final BorderRadiusGeometry interactiveMd;

  /// The extra small surface radius.
  final BorderRadiusGeometry surfaceXs;

  /// The small surface radius.
  final BorderRadiusGeometry surfaceSm;

  /// The medium surface radius.
  final BorderRadiusGeometry surfaceMd;

  /// The large surface radius.
  final BorderRadiusGeometry surfaceLg;

  /// The default border width.
  final double defaultBorderWidth;

  /// The active border width.
  final double activeBorderWidth;

  const MoonBorders({
    required this.interactiveXs,
    required this.interactiveSm,
    required this.interactiveMd,
    required this.surfaceXs,
    required this.surfaceSm,
    required this.surfaceMd,
    required this.surfaceLg,
    required this.defaultBorderWidth,
    required this.activeBorderWidth,
  });

  @override
  MoonBorders copyWith({
    BorderRadiusGeometry? interactiveXs,
    BorderRadiusGeometry? interactiveSm,
    BorderRadiusGeometry? interactiveMd,
    BorderRadiusGeometry? surfaceXs,
    BorderRadiusGeometry? surfaceSm,
    BorderRadiusGeometry? surfaceMd,
    BorderRadiusGeometry? surfaceLg,
    double? defaultBorderWidth,
    double? activeBorderWidth,
  }) {
    return MoonBorders(
      interactiveXs: interactiveXs ?? this.interactiveXs,
      interactiveSm: interactiveSm ?? this.interactiveSm,
      interactiveMd: interactiveMd ?? this.interactiveMd,
      surfaceXs: surfaceXs ?? this.surfaceXs,
      surfaceSm: surfaceSm ?? this.surfaceSm,
      surfaceMd: surfaceMd ?? this.surfaceMd,
      surfaceLg: surfaceLg ?? this.surfaceLg,
      defaultBorderWidth: defaultBorderWidth ?? this.defaultBorderWidth,
      activeBorderWidth: activeBorderWidth ?? this.activeBorderWidth,
    );
  }

  @override
  MoonBorders lerp(ThemeExtension<MoonBorders>? other, double t) {
    if (other is! MoonBorders) return this;

    return MoonBorders(
      interactiveXs: BorderRadiusGeometry.lerp(interactiveXs, other.interactiveXs, t)!,
      interactiveSm: BorderRadiusGeometry.lerp(interactiveSm, other.interactiveSm, t)!,
      interactiveMd: BorderRadiusGeometry.lerp(interactiveMd, other.interactiveMd, t)!,
      surfaceXs: BorderRadiusGeometry.lerp(surfaceXs, other.surfaceXs, t)!,
      surfaceSm: BorderRadiusGeometry.lerp(surfaceSm, other.surfaceSm, t)!,
      surfaceMd: BorderRadiusGeometry.lerp(surfaceMd, other.surfaceMd, t)!,
      surfaceLg: BorderRadiusGeometry.lerp(surfaceLg, other.surfaceLg, t)!,
      defaultBorderWidth: lerpDouble(defaultBorderWidth, other.defaultBorderWidth, t)!,
      activeBorderWidth: lerpDouble(activeBorderWidth, other.activeBorderWidth, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBorders"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("interactiveXs", interactiveXs))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("interactiveSm", interactiveSm))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("interactiveMd", interactiveMd))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceXs", surfaceXs))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceSm", surfaceSm))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceMd", surfaceMd))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("surfaceLg", surfaceLg))
      ..add(DoubleProperty("defaultBorderWidth", defaultBorderWidth))
      ..add(DoubleProperty("activeBorderWidth", activeBorderWidth));
  }
}
