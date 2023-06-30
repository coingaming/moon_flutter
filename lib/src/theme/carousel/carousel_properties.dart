import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonCarouselProperties extends ThemeExtension<MoonCarouselProperties> with DiagnosticableTreeMixin {
  static const properties = MoonCarouselProperties(
    transitionDuration: Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Carousel transition duration.
  final Duration transitionDuration;

  /// Carousel transition curve.
  final Curve transitionCurve;

  const MoonCarouselProperties({
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonCarouselProperties copyWith({
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonCarouselProperties(
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonCarouselProperties lerp(ThemeExtension<MoonCarouselProperties>? other, double t) {
    if (other is! MoonCarouselProperties) return this;

    return MoonCarouselProperties(
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonCarouselProperties"))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
