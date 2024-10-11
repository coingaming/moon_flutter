import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonCheckboxProperties extends ThemeExtension<MoonCheckboxProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonCheckbox.
  final BorderRadiusGeometry borderRadius;

  const MoonCheckboxProperties({required this.borderRadius});

  @override
  MoonCheckboxProperties copyWith({BorderRadiusGeometry? borderRadius}) {
    return MoonCheckboxProperties(
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  MoonCheckboxProperties lerp(
    ThemeExtension<MoonCheckboxProperties>? other,
    double t,
  ) {
    if (other is! MoonCheckboxProperties) return this;

    return MoonCheckboxProperties(
      borderRadius: BorderRadiusGeometry.lerp(
        borderRadius,
        other.borderRadius,
        t,
      )!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonCheckboxProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      );
  }
}
