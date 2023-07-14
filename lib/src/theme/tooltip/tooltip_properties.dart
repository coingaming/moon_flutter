import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonTooltipProperties extends ThemeExtension<MoonTooltipProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTooltipProperties(
    borderRadius: MoonBorders.borders.interactiveXs,
    arrowBaseWidth: MoonSizes.sizes.x2s,
    arrowLength: MoonSizes.sizes.x4s,
    arrowTipDistance: MoonSizes.sizes.x4s,
    transitionDuration: const Duration(milliseconds: 150),
    transitionCurve: Curves.easeInOutCubic,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x3s),
    textStyle: MoonTextStyles.body.text12,
  );

  /// Tooltip border radius.
  final BorderRadiusGeometry borderRadius;

  /// The tooltip arrows base width.
  final double arrowBaseWidth;

  /// The length of the tooltip arrow.
  final double arrowLength;

  /// The distance between the tooltip arrow and the widget it is attached to.
  final double arrowTipDistance;

  /// Tooltip transition duration (fade in or out animation).
  final Duration transitionDuration;

  /// Tooltip transition curve (fade in or out animation).
  final Curve transitionCurve;

  /// Padding around tooltip content.
  final EdgeInsetsGeometry contentPadding;

  /// Tooltip body style.
  final TextStyle textStyle;

  const MoonTooltipProperties({
    required this.borderRadius,
    required this.arrowBaseWidth,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.contentPadding,
    required this.textStyle,
  });

  @override
  MoonTooltipProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? arrowBaseWidth,
    double? arrowLength,
    double? arrowTipDistance,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
  }) {
    return MoonTooltipProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      arrowBaseWidth: arrowBaseWidth ?? this.arrowBaseWidth,
      arrowLength: arrowLength ?? this.arrowLength,
      arrowTipDistance: arrowTipDistance ?? this.arrowTipDistance,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      contentPadding: contentPadding ?? this.contentPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonTooltipProperties lerp(ThemeExtension<MoonTooltipProperties>? other, double t) {
    if (other is! MoonTooltipProperties) return this;

    return MoonTooltipProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      arrowBaseWidth: lerpDouble(arrowBaseWidth, other.arrowBaseWidth, t)!,
      arrowLength: lerpDouble(arrowLength, other.arrowLength, t)!,
      arrowTipDistance: lerpDouble(arrowTipDistance, other.arrowTipDistance, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTooltipProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("arrowBaseWidth", arrowBaseWidth))
      ..add(DoubleProperty("arrowLength", arrowLength))
      ..add(DoubleProperty("arrowTipDistance", arrowTipDistance))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
