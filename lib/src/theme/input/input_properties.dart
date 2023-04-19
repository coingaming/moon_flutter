import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonInputProperties extends ThemeExtension<MoonInputProperties> with DiagnosticableTreeMixin {
  static final properties = MoonInputProperties(
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    labelTextStyle: MoonTextStyles.body.text12,
    supportingTextStyle: MoonTextStyles.body.text12,
  );

  /// Input transition duration.
  final Duration transitionDuration;

  /// Input transition curve.
  final Curve transitionCurve;

  /// Input label text style.
  final TextStyle labelTextStyle;

  /// Input supporting text style.
  final TextStyle supportingTextStyle;

  const MoonInputProperties({
    required this.transitionDuration,
    required this.transitionCurve,
    required this.labelTextStyle,
    required this.supportingTextStyle,
  });

  @override
  MoonInputProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? labelTextStyle,
    TextStyle? supportingTextStyle,
  }) {
    return MoonInputProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      supportingTextStyle: supportingTextStyle ?? this.supportingTextStyle,
    );
  }

  @override
  MoonInputProperties lerp(ThemeExtension<MoonInputProperties>? other, double t) {
    if (other is! MoonInputProperties) return this;

    return MoonInputProperties(
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
      ..add(DiagnosticsProperty("type", "MoonInputProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<TextStyle>("labelTextStyle", labelTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("supportingTextStyle", supportingTextStyle));
  }
}
