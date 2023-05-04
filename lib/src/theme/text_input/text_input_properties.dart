import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTextInputProperties extends ThemeExtension<MoonTextInputProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTextInputProperties(
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    supportingPadding: EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s, vertical: MoonSizes.sizes.x4s),
    labelTextStyle: MoonTextStyles.body.text12,
    supportingTextStyle: MoonTextStyles.body.text12,
  );

  /// TextInput transition duration.
  final Duration transitionDuration;

  /// TextInput transition curve.
  final Curve transitionCurve;

  /// The padding around TextInput supporting widget or error builder.
  final EdgeInsetsGeometry supportingPadding;

  /// TextInput label text style.
  final TextStyle labelTextStyle;

  /// TextInput supporting or error text style.
  final TextStyle supportingTextStyle;

  const MoonTextInputProperties({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.supportingPadding,
    required this.labelTextStyle,
    required this.supportingTextStyle,
  });

  @override
  MoonTextInputProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? supportingPadding,
    TextStyle? labelTextStyle,
    TextStyle? supportingTextStyle,
  }) {
    return MoonTextInputProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      supportingPadding: supportingPadding ?? this.supportingPadding,
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
      supportingPadding: EdgeInsetsGeometry.lerp(supportingPadding, other.supportingPadding, t)!,
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
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("supportingPadding", supportingPadding))
      ..add(DiagnosticsProperty<TextStyle>("labelTextStyle", labelTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("supportingTextStyle", supportingTextStyle));
  }
}
