import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonCheckboxProperties extends ThemeExtension<MoonCheckboxProperties> with DiagnosticableTreeMixin {
  static final properties = MoonCheckboxProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    textStyle: MoonTextStyles.body.textDefault,
  );

  /// Checkbox border radius.
  final BorderRadiusGeometry borderRadius;

  /// Checkbox text style.
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
