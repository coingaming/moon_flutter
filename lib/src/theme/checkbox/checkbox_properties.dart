import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonCheckboxProperties extends ThemeExtension<MoonCheckboxProperties> with DiagnosticableTreeMixin {
  /// The border radius of the MoonCheckbox.
  final BorderRadiusGeometry borderRadius;

  /// The text style of the MoonCheckbox.
  final TextStyle textStyle;

  const MoonCheckboxProperties({
    required this.borderRadius,
    required this.textStyle,
  });

  @override
  MoonCheckboxProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    TextStyle? textStyle,
  }) {
    return MoonCheckboxProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonCheckboxProperties lerp(ThemeExtension<MoonCheckboxProperties>? other, double t) {
    if (other is! MoonCheckboxProperties) return this;

    return MoonCheckboxProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCheckboxProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
