import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTextInputProperties extends ThemeExtension<MoonTextInputProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTextInputProperties(
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    helperPadding: EdgeInsets.only(top: MoonSizes.sizes.x4s),
    labelTextStyle: MoonTextStyles.body.text12,
    helperTextStyle: MoonTextStyles.body.text12,
  );

  /// TextInput transition duration.
  final Duration transitionDuration;

  /// TextInput transition curve.
  final Curve transitionCurve;

  /// The padding around TextInput helper widget or error builder.
  final EdgeInsetsGeometry helperPadding;

  /// TextInput label text style.
  final TextStyle labelTextStyle;

  /// TextInput helper or error text style.
  final TextStyle helperTextStyle;

  const MoonTextInputProperties({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.helperPadding,
    required this.labelTextStyle,
    required this.helperTextStyle,
  });

  @override
  MoonTextInputProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? helperPadding,
    TextStyle? labelTextStyle,
    TextStyle? helperTextStyle,
  }) {
    return MoonTextInputProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      helperPadding: helperPadding ?? this.helperPadding,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
    );
  }

  @override
  MoonTextInputProperties lerp(ThemeExtension<MoonTextInputProperties>? other, double t) {
    if (other is! MoonTextInputProperties) return this;

    return MoonTextInputProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      helperPadding: EdgeInsetsGeometry.lerp(helperPadding, other.helperPadding, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("helperPadding", helperPadding))
      ..add(DiagnosticsProperty<TextStyle>("labelTextStyle", labelTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("helperTextStyle", helperTextStyle));
  }
}
