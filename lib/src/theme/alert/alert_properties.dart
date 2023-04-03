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
    bodyTextStyle: MoonTextStyles.body.text14,
    titleTextStyle: MoonTextStyles.heading.text14,
  );

  /// Border radius for alert.
  final BorderRadius borderRadius;

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
  final EdgeInsets padding;

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
    BorderRadius? borderRadius,
    double? horizontalGap,
    double? minimumHeight,
    double? verticalGap,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsets? padding,
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
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      minimumHeight: lerpDouble(minimumHeight, other.minimumHeight, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<double>("horizontalGap", horizontalGap))
      ..add(DiagnosticsProperty<double>("minimumHeight", minimumHeight))
      ..add(DiagnosticsProperty<double>("verticalGap", verticalGap))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsets>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("contentTextStyle", bodyTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("titleTextStyle", titleTextStyle));
  }
}
