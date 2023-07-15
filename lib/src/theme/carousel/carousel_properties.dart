import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonCarouselProperties extends ThemeExtension<MoonCarouselProperties> with DiagnosticableTreeMixin {
  /// Gap between Carousel items.
  final double gap;

  /// Carousel item text style.
  final TextStyle textStyle;

  /// Carousel auto play delay between items.
  final Duration autoPlayDelay;

  /// Carousel transition duration.
  final Duration transitionDuration;

  /// Carousel transition curve.
  final Curve transitionCurve;

  const MoonCarouselProperties({
    required this.gap,
    required this.textStyle,
    required this.autoPlayDelay,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonCarouselProperties copyWith({
    double? gap,
    TextStyle? textStyle,
    Duration? autoPlayDelay,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonCarouselProperties(
      gap: gap ?? this.gap,
      textStyle: textStyle ?? this.textStyle,
      autoPlayDelay: autoPlayDelay ?? this.autoPlayDelay,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonCarouselProperties lerp(ThemeExtension<MoonCarouselProperties>? other, double t) {
    if (other is! MoonCarouselProperties) return this;

    return MoonCarouselProperties(
      gap: lerpDouble(gap, other.gap, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      autoPlayDelay: lerpDuration(autoPlayDelay, other.autoPlayDelay, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselProperties"))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle))
      ..add(DiagnosticsProperty<Duration>("autoPlayDelay", autoPlayDelay))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
