import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_input/text_input_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonTextInputSizes extends ThemeExtension<MoonTextInputSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Small TextInput properties.
  final MoonTextInputSizeProperties sm;

  /// Medium TextInput properties.
  final MoonTextInputSizeProperties md;

  /// Large TextInput properties.
  final MoonTextInputSizeProperties lg;

  /// Extra large (floating) TextInput properties.
  final MoonTextInputSizeProperties xl;

  MoonTextInputSizes({
    required this.tokens,
    MoonTextInputSizeProperties? sm,
    MoonTextInputSizeProperties? md,
    MoonTextInputSizeProperties? lg,
    MoonTextInputSizeProperties? xl,
  })  : sm = sm ??
            MoonTextInputSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              height: tokens.sizes.sm,
              gap: tokens.sizes.x4s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x4s,
                vertical: tokens.sizes.x6s,
              ),
              textStyle: tokens.typography.body.textDefault,
            ),
        md = md ??
            MoonTextInputSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              height: tokens.sizes.md,
              gap: tokens.sizes.x4s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x3s,
                vertical: 6,
              ),
              textStyle: tokens.typography.body.textDefault,
            ),
        lg = lg ??
            MoonTextInputSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              height: tokens.sizes.lg,
              gap: tokens.sizes.x4s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x3s,
                vertical: tokens.sizes.x4s,
              ),
              textStyle: tokens.typography.body.text16,
            ),
        xl = xl ??
            MoonTextInputSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              height: tokens.sizes.xl,
              gap: tokens.sizes.x2s,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(
                horizontal: tokens.sizes.x2s,
                vertical: 10,
              ),
              textStyle: tokens.typography.body.text16,
            );

  @override
  MoonTextInputSizes copyWith({
    MoonTokens? tokens,
    MoonTextInputSizeProperties? sm,
    MoonTextInputSizeProperties? md,
    MoonTextInputSizeProperties? lg,
    MoonTextInputSizeProperties? xl,
  }) {
    return MoonTextInputSizes(
      tokens: tokens ?? this.tokens,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  MoonTextInputSizes lerp(ThemeExtension<MoonTextInputSizes>? other, double t) {
    if (other is! MoonTextInputSizes) return this;

    return MoonTextInputSizes(
      tokens: tokens.lerp(other.tokens, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
      lg: lg.lerp(other.lg, t),
      xl: xl.lerp(other.xl, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextInputSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("xl", xl));
  }
}
