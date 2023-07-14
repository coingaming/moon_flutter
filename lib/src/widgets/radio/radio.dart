import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/opacity.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/radio/radio_painter.dart';

class MoonRadio<T> extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Set to true if this radio button is allowed to be returned to an
  /// indeterminate state by selecting it again when selected.
  ///
  /// To indicate returning to an indeterminate state, [onChanged] will be
  /// called with null.
  ///
  /// If true, [onChanged] can be called with [value] when selected while
  /// [groupValue] != [value], or with null when selected again while
  /// [groupValue] == [value].
  ///
  /// If false, [onChanged] will be called with [value] when it is selected
  /// while [groupValue] != [value], and only by selecting another radio button
  /// in the group (i.e. changing the value of [groupValue]) can this radio
  /// button be unselected.
  ///
  /// Defaults to false.
  final bool toggleable;

  /// The color to use when this radio is checked.
  final Color? activeColor;

  /// The color to use for the radio's background when the radio is not checked.
  final Color? inactiveColor;

  /// The size of the radio's tap target.
  ///
  /// Defaults to 40.
  final double tapAreaSizeValue;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the radio.
  final String? semanticLabel;

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;

  /// Called when the user selects this radio button.
  ///
  /// The radio button passes [value] as a parameter to this callback. The radio
  /// button does not actually change state until the parent widget rebuilds the
  /// radio button with the new [groupValue].
  ///
  /// If null, the radio button will be displayed as disabled.
  ///
  /// The provided callback will not be invoked if this radio button is already
  /// selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt.
  final ValueChanged<T?>? onChanged;

  /// MDS radio widget.
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

  static Widget withLabel<T>(
    BuildContext context, {
    Key? key,
    bool autofocus = false,
    bool toggleable = false,
    Color? activeColor,
    Color? inactiveColor,
    double tapAreaSizeValue = 40,
    FocusNode? focusNode,
    TextStyle? textStyle,
    required String label,
    required T value,
    required T? groupValue,
    required ValueChanged<T?>? onChanged,
  }) {
    final bool isInteractive = onChanged != null;

    final Color effectiveTextColor =
        context.moonTheme?.radioTheme.colors.textColor ?? MoonTypography.light.colors.bodyPrimary;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.radioTheme.properties.textStyle ?? MoonTextStyles.body.textDefault;

    final TextStyle resolvedTextStyle = effectiveTextStyle.copyWith(color: effectiveTextColor).merge(textStyle);

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    return GestureDetector(
      onTap: () => onChanged?.call(value),
      child: MouseRegion(
        cursor: isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: tapAreaSizeValue),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MoonRadio<T>(
                key: key,
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                toggleable: toggleable,
                tapAreaSizeValue: 0,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                focusNode: focusNode,
                autofocus: autofocus,
              ),
              const SizedBox(width: 12),
              AnimatedOpacity(
                opacity: isInteractive ? 1 : effectiveDisabledOpacityValue,
                duration: effectiveFocusEffectDuration,
                child: DefaultTextStyle(
                  style: resolvedTextStyle,
                  child: Text(label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _selected => value == groupValue;

  @override
  State<MoonRadio<T>> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<MoonRadio<T>> with TickerProviderStateMixin, ToggleableStateMixin {
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
    if (widget._selected != oldWidget._selected) {
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => widget.toggleable;

  @override
  bool? get value => widget._selected;

  @override
  Widget build(BuildContext context) {
    const Size size = Size(16, 16);

    final Color effectiveActiveColor =
        widget.activeColor ?? context.moonTheme?.radioTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveColor =
        widget.inactiveColor ?? context.moonTheme?.radioTheme.colors.inactiveColor ?? MoonColors.light.trunks;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ?? MoonFocusEffects.lightFocusEffect.effectCurve;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>((Set<MaterialState> states) {
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
              opacity: states.contains(MaterialState.disabled) ? effectiveDisabledOpacityValue : 1,
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
