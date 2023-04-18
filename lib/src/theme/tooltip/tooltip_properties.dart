import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonTooltipProperties extends ThemeExtension<MoonTooltipProperties> with DiagnosticableTreeMixin {
  static final properties = MoonTooltipProperties(
    arrowBaseWidth: MoonSizes.sizes.x2s,
    arrowLength: MoonSizes.sizes.x4s,
    arrowTipDistance: MoonSizes.sizes.x4s,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveXs,
    transitionDuration: const Duration(milliseconds: 150),
    transitionCurve: Curves.easeInOutCubic,
    textStyle: MoonTextStyles.body.text12,
  );

  /// The tooltip arrows base width.
  final double arrowBaseWidth;

  /// The length of the tooltip arrow.
  final double arrowLength;

  /// The distance between the tooltip arrow and the widget it is attached to.
  final double arrowTipDistance;

  /// Padding around tooltip content.
  final EdgeInsetsGeometry contentPadding;

  /// Tooltip border radius.
  final BorderRadius borderRadius;

  /// Tooltip transition duration (fade in or out animation).
  final Duration transitionDuration;

  /// Tooltip transition curve (fade in or out animation).
  final Curve transitionCurve;

  /// Tooltip body style.
  final TextStyle textStyle;

  const MoonTooltipProperties({
    required this.arrowBaseWidth,
    required this.arrowLength,
    required this.arrowTipDistance,
    required this.contentPadding,
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.textStyle,
  });

  @override
  MoonTooltipProperties copyWith({
    double? arrowBaseWidth,
    double? arrowLength,
    double? arrowTipDistance,
    EdgeInsetsGeometry? contentPadding,
    BorderRadius? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
    TextStyle? textStyle,
  }) {
    return MoonTooltipProperties(
      arrowBaseWidth: arrowBaseWidth ?? this.arrowBaseWidth,
      arrowLength: arrowLength ?? this.arrowLength,
      arrowTipDistance: arrowTipDistance ?? this.arrowTipDistance,
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonTooltipProperties lerp(ThemeExtension<MoonTooltipProperties>? other, double t) {
    if (other is! MoonTooltipProperties) return this;

    return MoonTooltipProperties(
      arrowBaseWidth: lerpDouble(arrowBaseWidth, other.arrowBaseWidth, t)!,
      arrowLength: lerpDouble(arrowLength, other.arrowLength, t)!,
      arrowTipDistance: lerpDouble(arrowTipDistance, other.arrowTipDistance, t)!,
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTooltipProperties"))
      ..add(DoubleProperty("arrowBaseWidth", arrowBaseWidth))
      ..add(DoubleProperty("arrowLength", arrowLength))
      ..add(DoubleProperty("arrowTipDistance", arrowTipDistance))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
