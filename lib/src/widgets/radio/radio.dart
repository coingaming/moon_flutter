import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/effects/focus_effect.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

import 'package:moon_tokens/moon_tokens.dart';

class MoonRadio<T> extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Set to true if this radio button is allowed to be returned to an
  /// indeterminate state by selecting it again when selected.
  ///
  /// To indicate returning to an indeterminate state, [onChanged] is called
  /// with null.
  ///
  /// If true, [onChanged] is called with [value] when selected while
  /// [groupValue] != [value], or with null when selected again while
  /// [groupValue] == [value].
  ///
  /// If false, [onChanged] is called with [value] when selected while
  /// [groupValue] != [value], and only by selecting another radio button in the
  /// group (i.e. changing the value of [groupValue]) can this radio button be
  /// unselected.
  final bool toggleable;

  /// The color of the active (selected) radio button.
  final Color? activeColor;

  /// The background color of the inactive (unselected) radio button.
  final Color? inactiveColor;

  /// The size of the radio button tap target.
  ///
  /// Defaults to 40.
  final double tapAreaSizeValue;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label for the radio button.
  final String? semanticLabel;

  /// The value of the radio button.
  final T value;

  /// The value of a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;

  /// The callback that is called when the user selects the radio button.
  ///
  /// The radio button passes its [value] as a parameter to [onChanged]
  /// callback. The radio button does not actually change state until the parent
  /// widget rebuilds the radio button with the new [groupValue].
  ///
  /// If null, the radio button is displayed as disabled.
  ///
  /// The provided callback is not invoked if this radio button is already
  /// selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt.
  final ValueChanged<T?>? onChanged;

  /// Creates a Moon Design radio button.
  const MoonRadio({
    super.key,
    this.autofocus = false,
    this.toggleable = false,
    this.activeColor,
    this.inactiveColor,
    this.tapAreaSizeValue = 40,
    this.focusNode,
    this.semanticLabel,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<MoonRadio<T>> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<MoonRadio<T>> {
  bool get _selected => widget.value == widget.groupValue;

  ShapeDecorationWithPremultipliedAlpha _getFocusDecoration(
    double width,
    Color color,
  ) =>
      ShapeDecorationWithPremultipliedAlpha(
        shape: CircleBorder(
          side: BorderSide(
            width: width,
            color: color,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const double sizeValue = 16;
    const double dotSizeValue = (sizeValue - 1) / 2;

    final MoonFocusEffect focusEffect =
        MoonEffectsTheme(tokens: MoonTokens.light).controlFocusEffect;

    final Color effectiveActiveColor =
        widget.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveColor =
        widget.inactiveColor ?? MoonColors.light.trunks;

    final Color effectiveFocusEffectColor = focusEffect.effectColor;

    final double effectiveFocusEffectExtent = focusEffect.effectExtent;

    final Duration effectiveFocusEffectDuration = focusEffect.effectDuration;

    final Curve effectiveFocusEffectCurve = focusEffect.effectCurve;

    final double effectiveDisabledOpacityValue =
        context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    final Style dotStyle = Style(
      $box.chain
        ..width(_selected ? dotSizeValue : 0)
        ..height(_selected ? dotSizeValue : 0)
        ..color(effectiveActiveColor)
        ..shape.circle(),
    ).animate(duration: effectiveFocusEffectDuration);

    final Style baseStyle = Style(
      $box.chain
        ..height(sizeValue)
        ..width(sizeValue)
        ..border
            .color(_selected ? effectiveActiveColor : effectiveInactiveColor)
        ..alignment.center()
        ..shape.circle(),
    ).animate(duration: effectiveFocusEffectDuration);

    final Style effectsStyle = Style(
      $box.shapeDecoration.as(_getFocusDecoration(0, Colors.transparent)),
      $with.animatedOpacity(
        opacity: widget.onChanged == null ? effectiveDisabledOpacityValue : 1,
        duration: effectiveFocusEffectDuration,
      ),
      $on.focus(
        $box.shapeDecoration.as(
          _getFocusDecoration(
            effectiveFocusEffectExtent,
            effectiveFocusEffectColor,
          ),
        ),
      ),
    ).animate(
      duration: effectiveFocusEffectDuration,
      curve: effectiveFocusEffectCurve,
    );

    return MoonBaseSingleSelectWidget(
      value: widget.value,
      groupValue: widget.groupValue,
      toggleable: widget.toggleable,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      semanticLabel: widget.semanticLabel,
      tapAreaSizeValue: widget.tapAreaSizeValue,
      style: effectsStyle,
      onChanged: widget.onChanged,
      child: Box(
        style: baseStyle,
        child: Box(
          style: dotStyle,
        ),
      ),
    );
  }
}
