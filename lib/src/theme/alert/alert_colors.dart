import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonAlertColors extends ThemeExtension<MoonAlertColors> with DiagnosticableTreeMixin {
  static final light = MoonAlertColors(
    backgroundColor: MoonColors.light.gohan,
  );

  static final dark = MoonAlertColors(
    backgroundColor: MoonColors.dark.gohan,
  );

  /// Alert background color.
  final Color backgroundColor;

  const MoonAlertColors({
    required this.backgroundColor,
  });

  @override
  MoonAlertColors copyWith({
    Color? backgroundColor,
  }) {
    return MoonAlertColors(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  MoonAlertColors lerp(ThemeExtension<MoonAlertColors>? other, double t) {
    if (other is! MoonAlertColors) return this;

    return MoonAlertColors(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertColors"))
      ..add(ColorProperty("backgroundColor", backgroundColor));
  }
}
