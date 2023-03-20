import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonRadioColors extends ThemeExtension<MoonRadioColors> with DiagnosticableTreeMixin {
  static final light = MoonRadioColors(
    selectedColor: MoonColors.light.piccolo,
    unselectedColor: MoonColors.light.trunks,
  );

  static final dark = MoonRadioColors(
    selectedColor: MoonColors.dark.piccolo,
    unselectedColor: MoonColors.dark.trunks,
  );

  /// Radio selected track color.
  final Color selectedColor;

  /// Radio unselected track color.
  final Color unselectedColor;

  const MoonRadioColors({
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  MoonRadioColors copyWith({
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return MoonRadioColors(
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
    );
  }

  @override
  MoonRadioColors lerp(ThemeExtension<MoonRadioColors>? other, double t) {
    if (other is! MoonRadioColors) return this;

    return MoonRadioColors(
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonRadioColors"))
      ..add(ColorProperty("selectedColor", selectedColor))
      ..add(ColorProperty("unselectedColor", unselectedColor));
  }
}
