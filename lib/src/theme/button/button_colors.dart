import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

@immutable
class MoonButtonColors extends ThemeExtension<MoonButtonColors> with DiagnosticableTreeMixin {
  static final light = MoonButtonColors(
    borderColor: MoonColors.light.trunks,
    primaryBackgroundColor: MoonColors.light.piccolo,
    tertiaryBackgroundColor: MoonColors.light.hit,
    ghostTextColor: MoonColors.light.trunks,
    ghostFocusColor: MoonColors.light.piccolo,
    ghostHoverColor: MoonColors.light.jiren,
  );

  static final dark = MoonButtonColors(
    borderColor: MoonColors.dark.trunks,
    primaryBackgroundColor: MoonColors.dark.piccolo,
    tertiaryBackgroundColor: MoonColors.dark.hit,
    ghostTextColor: MoonColors.dark.trunks,
    ghostFocusColor: MoonColors.dark.piccolo,
    ghostHoverColor: MoonColors.dark.jiren,
  );

  /// Button border color.
  final Color borderColor;

  /// Primary button background color.
  final Color primaryBackgroundColor;

  /// Tertiary button background color.
  final Color tertiaryBackgroundColor;

  /// Ghost button text color.
  final Color ghostTextColor;

  /// Ghost button focus effect color.
  final Color ghostFocusColor;

  /// Ghost button hover effect color.
  final Color ghostHoverColor;

  const MoonButtonColors({
    required this.borderColor,
    required this.primaryBackgroundColor,
    required this.tertiaryBackgroundColor,
    required this.ghostTextColor,
    required this.ghostFocusColor,
    required this.ghostHoverColor,
  });

  @override
  MoonButtonColors copyWith({
    Color? borderColor,
    Color? primaryBackgroundColor,
    Color? tertiaryBackgroundColor,
    Color? ghostTextColor,
    Color? ghostFocusColor,
    Color? ghostHoverColor,
  }) {
    return MoonButtonColors(
      borderColor: borderColor ?? this.borderColor,
      primaryBackgroundColor: primaryBackgroundColor ?? this.primaryBackgroundColor,
      tertiaryBackgroundColor: tertiaryBackgroundColor ?? this.tertiaryBackgroundColor,
      ghostTextColor: ghostTextColor ?? this.ghostTextColor,
      ghostFocusColor: ghostFocusColor ?? this.ghostFocusColor,
      ghostHoverColor: ghostHoverColor ?? this.ghostHoverColor,
    );
  }

  @override
  MoonButtonColors lerp(ThemeExtension<MoonButtonColors>? other, double t) {
    if (other is! MoonButtonColors) return this;

    return MoonButtonColors(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      primaryBackgroundColor: Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t)!,
      tertiaryBackgroundColor: Color.lerp(tertiaryBackgroundColor, other.tertiaryBackgroundColor, t)!,
      ghostTextColor: Color.lerp(ghostTextColor, other.ghostTextColor, t)!,
      ghostFocusColor: Color.lerp(ghostFocusColor, other.ghostFocusColor, t)!,
      ghostHoverColor: Color.lerp(ghostHoverColor, other.ghostHoverColor, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonButtonColors"))
      ..add(ColorProperty("borderColor", borderColor))
      ..add(ColorProperty("primaryBackgroundColor", primaryBackgroundColor))
      ..add(ColorProperty("tertiaryBackgroundColor", tertiaryBackgroundColor))
      ..add(ColorProperty("ghostTextColor", ghostTextColor))
      ..add(ColorProperty("ghostFocusColor", ghostFocusColor))
      ..add(ColorProperty("ghostHoverColor", ghostHoverColor));
  }
}
