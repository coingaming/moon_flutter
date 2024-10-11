import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/effects_theme.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/radio/radio_painter.dart';
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

  bool get _selected => value == groupValue;

  @override
  State<MoonRadio<T>> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<MoonRadio<T>>
    with TickerProviderStateMixin, ToggleableStateMixin {
  final MoonRadioPainter _painter = MoonRadioPainter();

  void _handleChanged(bool? selected) {
    if (selected == null) {
      widget.onChanged!(null);

      return;
    }
    if (selected) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  void didUpdateWidget(MoonRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget._selected != oldWidget._selected) animateToValue();
  }

  @override
  void dispose() {
    _painter.dispose();

    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged =>
      widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => widget.toggleable;

  @override
  bool? get value => widget._selected;

  @override
  Widget build(BuildContext context) {
    const Size size = Size(16, 16);

    final Color effectiveActiveColor = widget.activeColor ??
        context.moonTheme?.radioTheme.colors.activeColor ??
        MoonColors.light.piccolo;

    final Color effectiveInactiveColor = widget.inactiveColor ??
        context.moonTheme?.radioTheme.colors.inactiveColor ??
        MoonColors.light.trunks;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlFocusEffect
                .effectColor;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlFocusEffect
                .effectExtent;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlFocusEffect
                .effectDuration;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ??
            MoonEffectsTheme(tokens: MoonTokens.light)
                .controlFocusEffect
                .effectCurve;

    final double effectiveDisabledOpacityValue =
        context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>(
            (Set<MaterialState> states) {
      return MaterialStateMouseCursor.clickable.resolve(states);
    });

    return Semantics(
      label: widget.semanticLabel,
      inMutuallyExclusiveGroup: true,
      checked: widget._selected,
      child: TouchTargetPadding(
        minSize: Size(widget.tapAreaSizeValue, widget.tapAreaSizeValue),
        child: MoonFocusEffect(
          show: states.contains(MaterialState.focused),
          effectExtent: effectiveFocusEffectExtent,
          childBorderRadius: BorderRadius.circular(8),
          effectColor: effectiveFocusEffectColor,
          effectCurve: effectiveFocusEffectCurve,
          effectDuration: effectiveFocusEffectDuration,
          child: RepaintBoundary(
            child: AnimatedOpacity(
              opacity: states.contains(MaterialState.disabled)
                  ? effectiveDisabledOpacityValue
                  : 1,
              duration: effectiveFocusEffectDuration,
              child: buildToggleable(
                focusNode: widget.focusNode,
                autofocus: widget.autofocus,
                mouseCursor: effectiveMouseCursor,
                size: size,
                painter: _painter
                  ..position = position
                  ..activeColor = effectiveActiveColor
                  ..inactiveColor = effectiveInactiveColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
