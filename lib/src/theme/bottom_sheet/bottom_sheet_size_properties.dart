import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonBottomSheetSizeProperties extends ThemeExtension<MoonBottomSheetSizeProperties> with DiagnosticableTreeMixin {
  static const sm = MoonBottomSheetSizeProperties(
    normalisedHeight: 0.32,
  );

  static const md = MoonBottomSheetSizeProperties(
    normalisedHeight: 0.64,
  );

  static const lg = MoonBottomSheetSizeProperties(
    normalisedHeight: 0.88,
  );

  static const fullScreen = MoonBottomSheetSizeProperties(
    normalisedHeight: 1.0,
  );

  /// The normalised percentage value of the BottomSheet height.
  final double normalisedHeight;

  const MoonBottomSheetSizeProperties({
    required this.normalisedHeight,
  });

  @override
  MoonBottomSheetSizeProperties copyWith({
    double? normalisedHeight,
  }) {
    return MoonBottomSheetSizeProperties(
      normalisedHeight: normalisedHeight ?? this.normalisedHeight,
    );
  }

  @override
  MoonBottomSheetSizeProperties lerp(ThemeExtension<MoonBottomSheetSizeProperties>? other, double t) {
    if (other is! MoonBottomSheetSizeProperties) return this;

    return MoonBottomSheetSizeProperties(
      normalisedHeight: lerpDouble(normalisedHeight, other.normalisedHeight, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBottomSheetSizeProperties"))
      ..add(DoubleProperty("normalisedHeight", normalisedHeight));
  }
}
