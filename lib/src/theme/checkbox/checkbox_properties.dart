import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';

@immutable
class MoonCheckboxProperties extends ThemeExtension<MoonCheckboxProperties> with DiagnosticableTreeMixin {
  static final properties = MoonCheckboxProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
  );

  /// Checkbox border radius.
  final BorderRadius borderRadius;

  const MoonCheckboxProperties({
    required this.borderRadius,
  });

  @override
  MoonCheckboxProperties copyWith({
    BorderRadius? borderRadius,
  }) {
    return MoonCheckboxProperties(
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  MoonCheckboxProperties lerp(ThemeExtension<MoonCheckboxProperties>? other, double t) {
    if (other is! MoonCheckboxProperties) return this;

    return MoonCheckboxProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCheckboxProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius));
  }
}
