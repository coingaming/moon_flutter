import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/text_input/text_input_size_properties.dart';

@immutable
class MoonTextInputSizes extends ThemeExtension<MoonTextInputSizes> with DiagnosticableTreeMixin {
  static final sizes = MoonTextInputSizes(
    sm: MoonTextInputSizeProperties.sm,
    md: MoonTextInputSizeProperties.md,
    lg: MoonTextInputSizeProperties.lg,
    xl: MoonTextInputSizeProperties.xl,
  );

  /// Small TextInput properties.
  final MoonTextInputSizeProperties sm;

  /// Medium TextInput properties.
  final MoonTextInputSizeProperties md;

  /// Large TextInput properties.
  final MoonTextInputSizeProperties lg;

  /// Extra large (floating) TextInput properties.
  final MoonTextInputSizeProperties xl;

  const MoonTextInputSizes({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  @override
  MoonTextInputSizes copyWith({
    MoonTextInputSizeProperties? sm,
    MoonTextInputSizeProperties? md,
    MoonTextInputSizeProperties? lg,
    MoonTextInputSizeProperties? xl,
  }) {
    return MoonTextInputSizes(
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
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("md", md))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("lg", lg))
      ..add(DiagnosticsProperty<MoonTextInputSizeProperties>("xl", xl));
  }
}
