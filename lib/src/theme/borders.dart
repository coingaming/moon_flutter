import 'dart:ui';

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonBorders extends ThemeExtension<MoonBorders> with DiagnosticableTreeMixin {
  /// Interactive radius XS.
  final BorderRadiusGeometry iXs;

  /// Interactive radius SM.
  final BorderRadiusGeometry iSm;

  /// Interactive radius MD.
  final BorderRadiusGeometry iMd;

  /// Surface radius XS.
  final BorderRadiusGeometry sXs;

  /// Surface radius SM.
  final BorderRadiusGeometry sSm;

  /// Surface radius MD.
  final BorderRadiusGeometry sMd;

  /// Surface radius LG.
  final BorderRadiusGeometry sLg;

  /// Default border width.
  final double borderDefault;

  /// Focus border width.
  final double borderFocus;

  const MoonBorders({
    this.iXs = const BorderRadius.all(Radius.circular(4)),
    this.iSm = const BorderRadius.all(Radius.circular(8)),
    this.iMd = const BorderRadius.all(Radius.circular(12)),
    this.sXs = const BorderRadius.all(Radius.circular(4)),
    this.sSm = const BorderRadius.all(Radius.circular(8)),
    this.sMd = const BorderRadius.all(Radius.circular(12)),
    this.sLg = const BorderRadius.all(Radius.circular(16)),
    this.borderDefault = 1,
    this.borderFocus = 4,
  });

  @override
  MoonBorders copyWith({
    BorderRadiusGeometry? iXs,
    BorderRadiusGeometry? iSm,
    BorderRadiusGeometry? iMd,
    BorderRadiusGeometry? sXs,
    BorderRadiusGeometry? sSm,
    BorderRadiusGeometry? sMd,
    BorderRadiusGeometry? sLg,
    double? borderDefault,
    double? borderFocus,
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
      borderFocus: borderFocus ?? this.borderFocus,
    );
  }

  @override
  MoonBorders lerp(ThemeExtension<MoonBorders>? other, double t) {
    if (other is! MoonBorders) return this;

    return MoonBorders(
      iXs: BorderRadiusGeometry.lerp(iXs, other.iXs, t)!,
      iSm: BorderRadiusGeometry.lerp(iSm, other.iSm, t)!,
      iMd: BorderRadiusGeometry.lerp(iMd, other.iMd, t)!,
      sXs: BorderRadiusGeometry.lerp(sXs, other.sXs, t)!,
      sSm: BorderRadiusGeometry.lerp(sSm, other.sSm, t)!,
      sMd: BorderRadiusGeometry.lerp(sMd, other.sMd, t)!,
      sLg: BorderRadiusGeometry.lerp(sLg, other.sLg, t)!,
      borderDefault: lerpDouble(borderDefault, other.borderDefault, t)!,
      borderFocus: lerpDouble(borderFocus, other.borderFocus, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBorders"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("iXs", iXs))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("iSm", iSm))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("iMd", iMd))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("sXs", sXs))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("sSm", sSm))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("sMd", sMd))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("sLg", sLg))
      ..add(DoubleProperty("border", borderDefault))
      ..add(DoubleProperty("borderFocus", borderFocus));
  }
}
