import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonSnackbarProperties extends ThemeExtension<MoonSnackbarProperties> with DiagnosticableTreeMixin {
  static final properties = MoonSnackbarProperties(
    borderRadius: MoonBorders.borders.surfaceSm,
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x2s),
    gap: MoonSizes.sizes.x2s,
    displayDuration: const Duration(seconds: 5),
    transitionDuration: const Duration(milliseconds: 200),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Snackbar border radius.
  final BorderRadius borderRadius;

  /// Padding around snackbar content.
  final EdgeInsets contentPadding;

  /// Space between snackbar children.
  final double gap;

  /// Snackbar display duration.
  final Duration displayDuration;

  /// Snackbar transition duration.
  final Duration transitionDuration;

  /// Snackbar transition curve.
  final Curve transitionCurve;

  const MoonSnackbarProperties({
    required this.borderRadius,
    required this.contentPadding,
    required this.gap,
    required this.displayDuration,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonSnackbarProperties copyWith({
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
    double? gap,
    Duration? displayDuration,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonSnackbarProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      gap: gap ?? this.gap,
      displayDuration: displayDuration ?? this.displayDuration,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonSnackbarProperties lerp(ThemeExtension<MoonSnackbarProperties>? other, double t) {
    if (other is! MoonSnackbarProperties) return this;

    return MoonSnackbarProperties(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
      gap: lerpDouble(gap, other.gap, t)!,
      displayDuration: lerpDuration(displayDuration, other.displayDuration, t),
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSnackbarProperties"))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<EdgeInsets>("contentPadding", contentPadding))
      ..add(DoubleProperty("gap", gap))
      ..add(DiagnosticsProperty<Duration>("displayDuration", displayDuration))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
