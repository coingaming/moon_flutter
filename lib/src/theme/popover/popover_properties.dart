import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/sizes.dart';

@immutable
class MoonPopoverProperties extends ThemeExtension<MoonPopoverProperties> with DiagnosticableTreeMixin {
  static final properties = MoonPopoverProperties(
    contentPadding: EdgeInsets.all(MoonSizes.sizes.x3s),
    borderRadius: MoonBorders.borders.interactiveXs,
    transitionDuration: const Duration(milliseconds: 150),
    transitionCurve: Curves.easeInOutCubic,
  );

  /// Padding around popover content.
  final EdgeInsets contentPadding;

  /// Tooltip border radius.
  final BorderRadius borderRadius;

  /// Tooltip transition duration (fade in or out animation).
  final Duration transitionDuration;

  /// Tooltip transition curve (fade in or out animation).
  final Curve transitionCurve;

  const MoonPopoverProperties({
    required this.contentPadding,
    required this.borderRadius,
    required this.transitionDuration,
    required this.transitionCurve,
  });

  @override
  MoonPopoverProperties copyWith({
    EdgeInsets? contentPadding,
    BorderRadius? borderRadius,
    Duration? transitionDuration,
    Curve? transitionCurve,
  }) {
    return MoonPopoverProperties(
      contentPadding: contentPadding ?? this.contentPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
    );
  }

  @override
  MoonPopoverProperties lerp(ThemeExtension<MoonPopoverProperties>? other, double t) {
    if (other is! MoonPopoverProperties) return this;

    return MoonPopoverProperties(
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverProperties"))
      ..add(DiagnosticsProperty<EdgeInsets>("contentPadding", contentPadding))
      ..add(DiagnosticsProperty<BorderRadius>("borderRadius", borderRadius))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve));
  }
}
