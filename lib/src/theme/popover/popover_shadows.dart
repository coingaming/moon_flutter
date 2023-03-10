import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonPopoverShadows extends ThemeExtension<MoonPopoverShadows> with DiagnosticableTreeMixin {
  static final light = MoonPopoverShadows(
    popoverShadows: MoonShadows.light.sm,
  );

  static final dark = MoonPopoverShadows(
    popoverShadows: MoonShadows.dark.sm,
  );

  /// Popover shadows.
  final List<BoxShadow> popoverShadows;

  const MoonPopoverShadows({
    required this.popoverShadows,
  });

  @override
  MoonPopoverShadows copyWith({List<BoxShadow>? popoverShadows}) {
    return MoonPopoverShadows(
      popoverShadows: popoverShadows ?? this.popoverShadows,
    );
  }

  @override
  MoonPopoverShadows lerp(ThemeExtension<MoonPopoverShadows>? other, double t) {
    if (other is! MoonPopoverShadows) return this;

    return MoonPopoverShadows(
      popoverShadows: BoxShadow.lerpList(popoverShadows, other.popoverShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonPopoverShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", popoverShadows));
  }
}
