import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/checkbox/checkbox_painter.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';

class MoonCheckbox extends StatefulWidget {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// [Checkbox] displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  /// Whether this checkbox is checked.
  ///
  /// When [tristate] is true, a value of null corresponds to the mixed state.
  /// When [tristate] is false, this value must not be null.
  final bool? value;

  /// The color to use when this checkbox is checked.
  final Color? activeColor;

  /// The color to use when this checkbox is checked.
  final Color? borderColor;

  /// The color to use for the check icon when this checkbox is checked.
  final Color? checkColor;

  /// The color to use for the checkbox's background when the checkbox is not checked.
  final Color? inactiveColor;

  /// The size of the checkbox's tap target.
  ///
  /// Defaults to 40.
  final double tapAreaSizeValue;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The semantic label for the checkbox.
  final String? semanticLabel;

  /// Callback for when the checkbox value changes.
  final ValueChanged<bool?>? onChanged;

  /// MDS checkbox widget.
  const MoonCheckbox({
    super.key,
    this.autofocus = false,
    this.tristate = false,
    required this.value,
    this.activeColor,
    this.borderColor,
    this.checkColor,
    this.inactiveColor,
    this.tapAreaSizeValue = 40,
    this.focusNode,
    this.semanticLabel,
    required this.onChanged,
  });

  static Widget withLabel(
    BuildContext context, {
    Key? key,
    bool autofocus = false,
    bool tristate = false,
    required bool? value,
    Color? activeColor,
    Color? borderColor,
    Color? checkColor,
    Color? inactiveColor,
    double tapAreaSizeValue = 40,
    FocusNode? focusNode,
    required String label,
    required ValueChanged<bool?>? onChanged,
  }) {
    final bool isInteractive = onChanged != null;

    final Color effectiveTextColor = context.moonColors?.bulma ?? MoonColors.light.bulma;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.typography.body.text14.copyWith(color: effectiveTextColor) ??
            TextStyle(fontSize: 14, color: effectiveTextColor);

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    return GestureDetector(
      onTap: () => onChanged?.call(!value!),
      child: MouseRegion(
        cursor: isInteractive ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: tapAreaSizeValue),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MoonCheckbox(
                key: key,
                autofocus: autofocus,
                tristate: tristate,
                value: value,
                activeColor: activeColor,
                borderColor: borderColor,
                checkColor: checkColor,
                inactiveColor: inactiveColor,
                tapAreaSizeValue: 0,
                focusNode: focusNode,
                onChanged: onChanged,
              ),
              const SizedBox(width: 12),
              RepaintBoundary(
                child: AnimatedOpacity(
                  opacity: isInteractive ? 1 : effectiveDisabledOpacityValue,
                  duration: effectiveFocusEffectDuration,
                  child: Text(
                    label,
                    style: effectiveTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<MoonCheckbox> createState() => _MoonCheckboxState();
}

class _MoonCheckboxState extends State<MoonCheckbox> with TickerProviderStateMixin, ToggleableStateMixin {
  final MoonCheckboxPainter _painter = MoonCheckboxPainter();

  bool? _previousValue;

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged;

  @override
  bool get tristate => widget.tristate;

  @override
  bool? get value => widget.value;

  BorderSide? _resolveSide(BorderSide? side) {
    if (side is MaterialStateBorderSide) {
      return MaterialStateProperty.resolveAs<BorderSide?>(side, states);
    }
    if (!states.contains(MaterialState.selected)) {
      return side;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(MoonCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Size size = Size(16, 16);

    final BorderRadius effectiveBorderRadius =
        context.moonTheme?.checkboxTheme.properties.borderRadius ?? MoonBorders.borders.interactiveXs;

    final Color effectiveActiveColor =
        widget.activeColor ?? context.moonTheme?.checkboxTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveColor =
        widget.inactiveColor ?? context.moonTheme?.checkboxTheme.colors.inactiveColor ?? Colors.transparent;

    final Color effectiveCheckColor =
        widget.checkColor ?? context.moonTheme?.checkboxTheme.colors.checkColor ?? MoonColors.light.goten;

    final Color effectiveBorderColor =
        widget.borderColor ?? context.moonTheme?.checkboxTheme.colors.borderColor ?? MoonColors.light.trunks;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ?? MoonFocusEffects.lightFocusEffect.effectCurve;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>((Set<MaterialState> states) {
      return MaterialStateMouseCursor.clickable.resolve(states);
    });

    return Semantics(
      label: widget.semanticLabel,
      checked: widget.value ?? false,
      mixed: widget.tristate ? widget.value == null : null,
      child: TouchTargetPadding(
        minSize: Size(widget.tapAreaSizeValue, widget.tapAreaSizeValue),
        child: MoonFocusEffect(
          show: states.contains(MaterialState.focused),
          childBorderRadius: effectiveBorderRadius,
          effectColor: effectiveFocusEffectColor,
          effectCurve: effectiveFocusEffectCurve,
          effectDuration: effectiveFocusEffectDuration,
          effectExtent: effectiveFocusEffectExtent,
          child: RepaintBoundary(
            child: AnimatedOpacity(
              opacity: states.contains(MaterialState.disabled) ? effectiveDisabledOpacityValue : 1,
              duration: effectiveFocusEffectDuration,
              child: buildToggleable(
                mouseCursor: effectiveMouseCursor,
                focusNode: widget.focusNode,
                autofocus: widget.autofocus,
                size: size,
                painter: _painter
                  ..position = position
                  ..activeColor = effectiveActiveColor
                  ..inactiveColor = effectiveInactiveColor
                  ..checkColor = effectiveCheckColor
                  ..value = value
                  ..previousValue = _previousValue
                  ..shape = SmoothRectangleBorder(borderRadius: effectiveBorderRadius.smoothBorderRadius)
                  ..side = _resolveSide(BorderSide(color: effectiveBorderColor)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
