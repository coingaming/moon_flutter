import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/bottom_sheet/bottom_sheet_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonBottomSheetSizes extends ThemeExtension<MoonBottomSheetSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Small BottomSheet properties.
  final MoonBottomSheetSizeProperties sm;

  /// Medium BottomSheet properties.
  final MoonBottomSheetSizeProperties md;

  /// Large BottomSheet properties.
  final MoonBottomSheetSizeProperties lg;

  /// Full screen BottomSheet properties.
  final MoonBottomSheetSizeProperties fullScreen;

  MoonBottomSheetSizes({
    required this.tokens,
    MoonBottomSheetSizeProperties? sm,
    MoonBottomSheetSizeProperties? md,
    MoonBottomSheetSizeProperties? lg,
    MoonBottomSheetSizeProperties? fullScreen,
  })  : sm = sm ?? const MoonBottomSheetSizeProperties(normalisedHeight: 0.32),
        md = md ?? const MoonBottomSheetSizeProperties(normalisedHeight: 0.64),
        lg = lg ?? const MoonBottomSheetSizeProperties(normalisedHeight: 0.88),
        fullScreen = fullScreen ?? const MoonBottomSheetSizeProperties(normalisedHeight: 1.0);

  @override
  MoonBottomSheetSizes copyWith({
    MoonTokens? tokens,
    MoonBottomSheetSizeProperties? sm,
    MoonBottomSheetSizeProperties? md,
    MoonBottomSheetSizeProperties? lg,
    MoonBottomSheetSizeProperties? fullScreen,
  }) {
    return MoonBottomSheetSizes(
      tokens: tokens ?? this.tokens,
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
      tokens: tokens,
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
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonBottomSheetSizeProperties>("fullScreen", fullScreen));
  }
}
