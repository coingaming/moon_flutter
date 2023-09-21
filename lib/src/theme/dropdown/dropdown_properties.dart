import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonDropdownProperties extends ThemeExtension<MoonDropdownProperties> with DiagnosticableTreeMixin {
  /// Dropdown border radius.
  final BorderRadiusGeometry borderRadius;

  /// Dropdown distance to target child widget.
  final double distanceToTarget;

  /// Dropdown transition duration (fade in or out animation).
  final Duration transitionDuration;

  /// Dropdown transition curve (fade in or out animation).
  final Curve transitionCurve;

  /// Padding around dropdown content.
  final EdgeInsetsGeometry contentPadding;

  /// Margin of the dropdown.
  final EdgeInsetsGeometry dropdownMargin;

  /// Dropdown text style.
  final TextStyle textStyle;

  const MoonDropdownProperties({
    required this.borderRadius,
    required this.distanceToTarget,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.contentPadding,
    required this.dropdownMargin,
    required this.textStyle,
  });

  @override
  MoonDropdownProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? distanceToTarget,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? dropdownMargin,
    TextStyle? textStyle,
  }) {
    return MoonDropdownProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      distanceToTarget: distanceToTarget ?? this.distanceToTarget,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      contentPadding: contentPadding ?? this.contentPadding,
      dropdownMargin: dropdownMargin ?? this.dropdownMargin,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonDropdownProperties lerp(ThemeExtension<MoonDropdownProperties>? other, double t) {
    if (other is! MoonDropdownProperties) return this;

    return MoonDropdownProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      distanceToTarget: lerpDouble(distanceToTarget, other.distanceToTarget, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      dropdownMargin: EdgeInsetsGeometry.lerp(dropdownMargin, other.dropdownMargin, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDropdownProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("distanceToTarget", distanceToTarget))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("dropdownMargin", dropdownMargin))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
