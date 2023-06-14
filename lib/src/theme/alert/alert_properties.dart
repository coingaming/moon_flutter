import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/typography/text_styles.dart';

@immutable
class MoonAlertProperties extends ThemeExtension<MoonAlertProperties> with DiagnosticableTreeMixin {
  static final properties = MoonAlertProperties(
    borderRadius: MoonBorders.borders.interactiveSm,
    horizontalGap: MoonSizes.sizes.x3s,
    minimumHeight: MoonSizes.sizes.xl,
    verticalGap: MoonSizes.sizes.x4s,
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
    padding: EdgeInsets.all(MoonSizes.sizes.x2s),
    bodyTextStyle: MoonTextStyles.body.textDefault,
    titleTextStyle: MoonTextStyles.heading.textDefault,
  );

  /// Border radius for alert.
  final BorderRadiusGeometry borderRadius;

  /// Horizontal space between alert leading, trailing and title.
  final double horizontalGap;

  /// Alert Widget minimum height.
  final double minimumHeight;

  /// Vertical space between alert header and body.
  final double verticalGap;

  /// Alert transition duration (show and hide animation).
  final Duration transitionDuration;

  /// Alert transition curve (show and hide animation).
  final Curve transitionCurve;

  /// Alert padding.
  final EdgeInsetsGeometry padding;

  /// Alert body text style.
  final TextStyle bodyTextStyle;

  /// Alert title text style.
  final TextStyle titleTextStyle;

  const MoonAlertProperties({
    required this.borderRadius,
    required this.horizontalGap,
    required this.minimumHeight,
    required this.verticalGap,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.padding,
    required this.bodyTextStyle,
    required this.titleTextStyle,
  });

  @override
  MoonAlertProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? horizontalGap,
    double? minimumHeight,
    double? verticalGap,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? padding,
    TextStyle? bodyTextStyle,
    TextStyle? titleTextStyle,
  }) {
    return MoonAlertProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      horizontalGap: horizontalGap ?? this.horizontalGap,
      minimumHeight: minimumHeight ?? this.minimumHeight,
      verticalGap: verticalGap ?? this.verticalGap,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      padding: padding ?? this.padding,
      bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }

  @override
  MoonAlertProperties lerp(ThemeExtension<MoonAlertProperties>? other, double t) {
    if (other is! MoonAlertProperties) return this;

    return MoonAlertProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      minimumHeight: lerpDouble(minimumHeight, other.minimumHeight, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("horizontalGap", horizontalGap))
      ..add(DoubleProperty("minimumHeight", minimumHeight))
      ..add(DoubleProperty("verticalGap", verticalGap))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("bodyTextStyle", bodyTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("titleTextStyle", titleTextStyle));
  }
}
