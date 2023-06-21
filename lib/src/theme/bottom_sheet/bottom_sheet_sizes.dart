import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_size_properties.dart';

@immutable
class MoonBottomSheetSizes extends ThemeExtension<MoonBottomSheetSizes> with DiagnosticableTreeMixin {
  static const sizes = MoonBottomSheetSizes(
    sm: MoonBottomSheetSizeProperties.sm,
    md: MoonBottomSheetSizeProperties.md,
    lg: MoonBottomSheetSizeProperties.lg,
    fullScreen: MoonBottomSheetSizeProperties.fullScreen,
  );

  /// Small BottomSheet properties.
  final MoonBottomSheetSizeProperties sm;

  /// Medium BottomSheet properties.
  final MoonBottomSheetSizeProperties md;

  /// Large BottomSheet properties.
  final MoonBottomSheetSizeProperties lg;

  /// Full screen BottomSheet properties.
  final MoonBottomSheetSizeProperties fullScreen;

  const MoonBottomSheetSizes({
    required this.sm,
    required this.md,
    required this.lg,
    required this.fullScreen,
  });

  @override
  MoonBottomSheetSizes copyWith({
    MoonBottomSheetSizeProperties? sm,
    MoonBottomSheetSizeProperties? md,
    MoonBottomSheetSizeProperties? lg,
    MoonBottomSheetSizeProperties? fullScreen,
  }) {
    return MoonBottomSheetSizes(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      fullScreen: fullScreen ?? this.fullScreen,
    );
  }

  @override
  MoonBottomSheetSizes lerp(ThemeExtension<MoonBottomSheetSizes>? other, double t) {
    if (other is! MoonBottomSheetSizes) return this;

    return MoonBottomSheetSizes(
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      fullScreen: fullScreen.lerp(other.fullScreen, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonBottomSheetSizes"))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("fullScreen", fullScreen));
  }
}
