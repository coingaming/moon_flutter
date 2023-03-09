import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonTooltipShadows extends ThemeExtension<MoonTooltipShadows> with DiagnosticableTreeMixin {
  static final light = MoonTooltipShadows(
    tooltipShadows: MoonShadows.light.sm,
  );

  static final dark = MoonTooltipShadows(
    tooltipShadows: MoonShadows.dark.sm,
  );

  /// Tooltip shadows.
  final List<BoxShadow> tooltipShadows;

  const MoonTooltipShadows({
    required this.tooltipShadows,
  });

  @override
  MoonTooltipShadows copyWith({List<BoxShadow>? tooltipShadows}) {
    return MoonTooltipShadows(
      tooltipShadows: tooltipShadows ?? this.tooltipShadows,
    );
  }

  @override
  MoonTooltipShadows lerp(ThemeExtension<MoonTooltipShadows>? other, double t) {
    if (other is! MoonTooltipShadows) return this;

    return MoonTooltipShadows(
      tooltipShadows: BoxShadow.lerpList(tooltipShadows, other.tooltipShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTooltipShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", tooltipShadows));
  }
}
