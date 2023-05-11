import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTextAreaProperties extends ThemeExtension<MoonTextAreaProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTextAreaProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    supportingPadding: EdgeInsets.symmetric(vertical: MoonSizes.sizes.x4s),
    textPadding: const EdgeInsets.all(16),
    textStyle: MoonTextStyles.body.text16,
    helperTextStyle: MoonTextStyles.body.text12,
  );

  /// TextArea border radius.
  final BorderRadiusGeometry borderRadius;

  /// TextArea transition duration.
  final Duration transitionDuration;

  /// TextArea transition curve.
  final Curve transitionCurve;

  /// The padding around TextArea helper widget or error builder.
  final EdgeInsetsGeometry supportingPadding;

  /// TextArea text padding.
  final EdgeInsetsGeometry textPadding;

  /// TextArea text style.
  final TextStyle textStyle;

  /// TextArea helper or error text style.
  final TextStyle helperTextStyle;

  const MoonTextAreaProperties({
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.supportingPadding,
    required this.textPadding,
    required this.textStyle,
    required this.helperTextStyle,
  });

  @override
  MoonTextAreaProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? supportingPadding,
    EdgeInsetsGeometry? textPadding,
    TextStyle? textStyle,
    TextStyle? helperTextStyle,
  }) {
    return MoonTextAreaProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      supportingPadding: supportingPadding ?? this.supportingPadding,
      textPadding: textPadding ?? this.textPadding,
      textStyle: textStyle ?? this.textStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
    );
  }

  @override
  MoonTextAreaProperties lerp(ThemeExtension<MoonTextAreaProperties>? other, double t) {
    if (other is! MoonTextAreaProperties) return this;

    return MoonTextAreaProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      supportingPadding: EdgeInsetsGeometry.lerp(supportingPadding, other.supportingPadding, t)!,
      textPadding: EdgeInsetsGeometry.lerp(textPadding, other.textPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextAreaProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("supportingPadding", supportingPadding))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("textPadding", textPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle));
  }
}
