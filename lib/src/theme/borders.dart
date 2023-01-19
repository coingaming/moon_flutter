import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonBorders extends ThemeExtension<MoonBorders> with DiagnosticableTreeMixin {
  /// Interactive radius XS.
  final Radius iXs;

  /// Interactive radius SM.
  final Radius iSm;

  /// Interactive radius MD.
  final Radius iMd;

  /// Surface radius XS.
  final Radius sXs;

  /// Surface radius SM.
  final Radius sSm;

  /// Surface radius MD.
  final Radius sMd;

  /// Surface radius LG.
  final Radius sLg;

  /// Default border width.
  final double borderDefault;

  /// Interactive border width.
  final double borderInteractive;

  const MoonBorders({
    this.iXs = const Radius.circular(4),
    this.iSm = const Radius.circular(8),
    this.iMd = const Radius.circular(12),
    this.sXs = const Radius.circular(4),
    this.sSm = const Radius.circular(8),
    this.sMd = const Radius.circular(12),
    this.sLg = const Radius.circular(16),
    this.borderDefault = 1,
    this.borderInteractive = 2,
  });

  @override
  MoonBorders copyWith({
    Radius? iXs,
    Radius? iSm,
    Radius? iMd,
    Radius? sXs,
    Radius? sSm,
    Radius? sMd,
    Radius? sLg,
    double? borderDefault,
    double? borderInteractive,
  }) {
    return MoonBorders(
      iXs: iXs ?? this.iXs,
      iSm: iSm ?? this.iSm,
      iMd: iMd ?? this.iMd,
      sXs: sXs ?? this.sXs,
      sSm: sSm ?? this.sSm,
      sMd: sMd ?? this.sMd,
      sLg: sLg ?? this.sLg,
      borderDefault: borderDefault ?? this.borderDefault,
      borderInteractive: borderInteractive ?? this.borderInteractive,
    );
  }

  @override
  MoonBorders lerp(ThemeExtension<MoonBorders>? other, double t) {
    if (other is! MoonBorders) return this;

    return MoonBorders(
      iXs: Radius.lerp(iXs, other.iXs, t)!,
      iSm: Radius.lerp(iSm, other.iSm, t)!,
      iMd: Radius.lerp(iMd, other.iMd, t)!,
      sXs: Radius.lerp(sXs, other.sXs, t)!,
      sSm: Radius.lerp(sSm, other.sSm, t)!,
      sMd: Radius.lerp(sMd, other.sMd, t)!,
      sLg: Radius.lerp(sLg, other.sLg, t)!,
      borderDefault: lerpDouble(borderDefault, other.borderDefault, t)!,
      borderInteractive: lerpDouble(borderInteractive, other.borderInteractive, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBorders"))
      ..add(DiagnosticsProperty<Radius>("iXs", iXs))
      ..add(DiagnosticsProperty<Radius>("iSm", iSm))
      ..add(DiagnosticsProperty<Radius>("iMd", iMd))
      ..add(DiagnosticsProperty<Radius>("sXs", sXs))
      ..add(DiagnosticsProperty<Radius>("sSm", sSm))
      ..add(DiagnosticsProperty<Radius>("sMd", sMd))
      ..add(DiagnosticsProperty<Radius>("sLg", sLg))
      ..add(DoubleProperty("border", borderDefault))
      ..add(DoubleProperty("borderInteractive", borderInteractive));
  }
}
