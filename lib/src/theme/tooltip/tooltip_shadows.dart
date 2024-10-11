import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTooltipShadows extends ThemeExtension<MoonTooltipShadows>
    with DiagnosticableTreeMixin {
  /// The list of shadows applied to the MoonTooltip.
  final List<BoxShadow> tooltipShadows;

  const MoonTooltipShadows({required this.tooltipShadows});

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
      tooltipShadows: BoxShadow.lerpList(
        tooltipShadows,
        other.tooltipShadows,
        t,
      )!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonTooltipShadows"),
      )
      ..add(
        DiagnosticsProperty<List<BoxShadow>>("tooltipShadows", tooltipShadows),
      );
  }
}
