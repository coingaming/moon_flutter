import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTextInputProperties extends ThemeExtension<MoonTextInputProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTextInputProperties(
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    labelTextStyle: MoonTextStyles.body.text12,
    supportingTextStyle: MoonTextStyles.body.text12,
  );

  /// TextInput transition duration.
  final Duration transitionDuration;

  /// TextInput transition curve.
  final Curve transitionCurve;

  /// TextInput label text style.
  final TextStyle labelTextStyle;

  /// TextInput supporting text style.
  final TextStyle supportingTextStyle;

  const MoonTextInputProperties({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.labelTextStyle,
    required this.supportingTextStyle,
  });

  @override
  MoonTextInputProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? labelTextStyle,
    TextStyle? supportingTextStyle,
  }) {
    return MoonTextInputProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      supportingTextStyle: supportingTextStyle ?? this.supportingTextStyle,
    );
  }

  @override
  MoonTextInputProperties lerp(ThemeExtension<MoonTextInputProperties>? other, double t) {
    if (other is! MoonTextInputProperties) return this;

    return MoonTextInputProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      supportingTextStyle: TextStyle.lerp(supportingTextStyle, other.supportingTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<TextStyle>("labelTextStyle", labelTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("supportingTextStyle", supportingTextStyle));
  }
}
