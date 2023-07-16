import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/segmented_control/segmented_control_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonSegmentedControlSizes extends ThemeExtension<MoonSegmentedControlSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Small segmentedControl item properties.
  final MoonSegmentedControlSizeProperties sm;

  /// Medium segmentedControl item properties.
  final MoonSegmentedControlSizeProperties md;

  MoonSegmentedControlSizes({
    required this.tokens,
    MoonSegmentedControlSizeProperties? sm,
    MoonSegmentedControlSizeProperties? md,
  })  : sm = sm ??
            MoonSegmentedControlSizeProperties(
              segmentBorderRadius: tokens.borders.interactiveSm,
              segmentGap: tokens.sizes.x5s,
              height: tokens.sizes.md,
              iconSizeValue: tokens.sizes.xs,
              segmentPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              textStyle: tokens.typography.heading.textDefault,
            ),
        md = md ??
            MoonSegmentedControlSizeProperties(
              segmentBorderRadius: tokens.borders.interactiveSm,
              segmentGap: tokens.sizes.x4s,
              height: tokens.sizes.lg,
              iconSizeValue: tokens.sizes.xs,
              segmentPadding: EdgeInsets.symmetric(horizontal: tokens.sizes.x2s),
              textStyle: tokens.typography.heading.textDefault,
            );

  @override
  MoonSegmentedControlSizes copyWith({
    MoonTokens? tokens,
    MoonSegmentedControlSizeProperties? sm,
    MoonSegmentedControlSizeProperties? md,
  }) {
    return MoonSegmentedControlSizes(
      tokens: tokens ?? this.tokens,
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonSegmentedControlSizes lerp(ThemeExtension<MoonSegmentedControlSizes>? other, double t) {
    if (other is! MoonSegmentedControlSizes) return this;

    return MoonSegmentedControlSizes(
      tokens: tokens.lerp(other.tokens, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSegmentedControlSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonSegmentedControlSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonSegmentedControlSizeProperties>("md", md));
  }
}
