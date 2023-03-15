import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonCheckboxProperties extends ThemeExtension<MoonCheckboxProperties> with DiagnosticableTreeMixin {
  static final properties = MoonCheckboxProperties(
    borderRadiusValue: MoonBorders.borders.interactiveXs.topLeft.x,
  );

  /// Checkbox border radius value.
  final double borderRadiusValue;

  const MoonCheckboxProperties({
    required this.borderRadiusValue,
  });

  @override
  MoonCheckboxProperties copyWith({
    double? borderRadiusValue,
  }) {
    return MoonCheckboxProperties(
      borderRadiusValue: borderRadiusValue ?? this.borderRadiusValue,
    );
  }

  @override
  MoonCheckboxProperties lerp(ThemeExtension<MoonCheckboxProperties>? other, double t) {
    if (other is! MoonCheckboxProperties) return this;

    return MoonCheckboxProperties(
      borderRadiusValue: lerpDouble(borderRadiusValue, other.borderRadiusValue, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCheckboxProperties"))
      ..add(DiagnosticsProperty<double>("borderRadiusValue", borderRadiusValue));
  }
}
