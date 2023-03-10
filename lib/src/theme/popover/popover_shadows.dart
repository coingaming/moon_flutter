import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonPopoverShadows extends ThemeExtension<MoonPopoverShadows> with DiagnosticableTreeMixin {
  static final light = MoonPopoverShadows(
    tooltipShadows: MoonShadows.light.sm,
  );

  static final dark = MoonPopoverShadows(
    tooltipShadows: MoonShadows.dark.sm,
  );

  /// Popover shadows.
  final List<BoxShadow> tooltipShadows;

  const MoonPopoverShadows({
    required this.tooltipShadows,
  });

  @override
  MoonPopoverShadows copyWith({List<BoxShadow>? tooltipShadows}) {
    return MoonPopoverShadows(
      tooltipShadows: tooltipShadows ?? this.tooltipShadows,
    );
  }

  @override
  MoonPopoverShadows lerp(ThemeExtension<MoonPopoverShadows>? other, double t) {
    if (other is! MoonPopoverShadows) return this;

    return MoonPopoverShadows(
      tooltipShadows: BoxShadow.lerpList(tooltipShadows, other.tooltipShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", tooltipShadows));
  }
}
