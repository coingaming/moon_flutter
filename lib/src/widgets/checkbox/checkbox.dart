import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/utils/touch_target_padding.dart';
import 'package:moon_design/src/widgets/checkbox/checkbox_painter.dart';

class MoonCheckbox extends StatefulWidget {
  /// Whether this checkbox is checked.
  ///
  /// When [tristate] is true, a value of null corresponds to the mixed state.
  /// When [tristate] is false, this value must not be null.
  final bool? value;

  /// Callback for when the checkbox value changes.
  final ValueChanged<bool?>? onChanged;

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

  /// The size of the checkbox's tap target.
  ///
  /// Defaults to 40.
  final double tapAreaSizeValue;

  /// The color to use when this checkbox is checked.
  final Color? activeColor;

  /// The color to use when this checkbox is checked.
  final Color? borderColor;

  /// The color to use for the check icon when this checkbox is checked.
  final Color? checkColor;

  /// The color to use for the checkbox's background when the checkbox is not checked.
  final Color? fillColor;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  const MoonCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.tapAreaSizeValue = 40,
    this.activeColor,
    this.borderColor,
    this.checkColor,
    this.fillColor,
    this.focusNode,
    this.autofocus = false,
  });

  static Widget withLabel(
    BuildContext context, {
    Key? key,
    required bool? value,
    required void Function(bool?)? onChanged,
    bool tristate = false,
    double tapAreaSizeValue = 40,
    Color? activeColor,
    Color? borderColor,
    Color? checkColor,
    Color? fillColor,
    FocusNode? focusNode,
    bool autofocus = false,
    required String label,
  }) {
    final Color effectiveTextColor = context.moonColors?.bulma ?? MoonColors.light.bulma;

    final TextStyle effectiveTextStyle =
        context.moonTheme?.typography.body.text14.copyWith(color: effectiveTextColor) ??
            TextStyle(fontSize: 14, color: effectiveTextColor);

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final bool isInteractive = onChanged != null;

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
                value: value,
                onChanged: onChanged,
                tristate: tristate,
                tapAreaSizeValue: 0,
                activeColor: activeColor,
                borderColor: borderColor,
                checkColor: checkColor,
                fillColor: fillColor,
                focusNode: focusNode,
                autofocus: autofocus,
              ),
              const SizedBox(width: 12),
              AnimatedOpacity(
                opacity: isInteractive ? 1 : effectiveDisabledOpacityValue,
                duration: effectiveFocusEffectDuration,
                child: Text(
                  label,
                  style: effectiveTextStyle,
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

    final Color effectiveActiveColor =
        widget.activeColor ?? context.moonTheme?.checkboxTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveCheckColor =
        widget.checkColor ?? context.moonTheme?.checkboxTheme.colors.checkColor ?? MoonColors.light.goten;

    final Color effectiveFillColor =
        widget.fillColor ?? context.moonTheme?.checkboxTheme.colors.fillColor ?? Colors.transparent;

    final Color effectiveBorderColor =
        widget.borderColor ?? context.moonTheme?.checkboxTheme.colors.borderColor ?? MoonColors.light.trunks;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final Curve effectiveFocusEffectCurve =
        context.moonEffects?.controlFocusEffect.effectCurve ?? MoonFocusEffects.lightFocusEffect.effectCurve;

    final Duration effectiveFocusEffectDuration =
        context.moonEffects?.controlFocusEffect.effectDuration ?? MoonFocusEffects.lightFocusEffect.effectDuration;

    final double effectiveBorderRadiusValue = context.moonTheme?.checkboxTheme.properties.borderRadiusValue ?? 4;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final SmoothBorderRadius resolvedBorderRadius = SmoothBorderRadius.all(
      SmoothRadius(
        cornerRadius: effectiveBorderRadiusValue,
        cornerSmoothing: 1,
      ),
    );

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor =
        MaterialStateProperty.resolveWith<MouseCursor>((Set<MaterialState> states) {
      return MaterialStateMouseCursor.clickable.resolve(states);
    });

    return Semantics(
      checked: widget.value ?? false,
      mixed: widget.tristate ? widget.value == null : null,
      child: TouchTargetPadding(
        minSize: Size(widget.tapAreaSizeValue, widget.tapAreaSizeValue),
        child: MoonFocusEffect(
          show: states.contains(MaterialState.focused),
          effectExtent: effectiveFocusEffectExtent,
          childBorderRadius: resolvedBorderRadius,
          effectColor: effectiveFocusEffectColor,
          effectCurve: effectiveFocusEffectCurve,
          effectDuration: effectiveFocusEffectDuration,
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
                ..reaction = reaction
                ..reactionFocusFade = reactionFocusFade
                ..reactionHoverFade = reactionHoverFade
                ..inactiveReactionColor = Colors.transparent
                ..reactionColor = Colors.transparent
                ..hoverColor = Colors.transparent
                ..focusColor = effectiveFocusEffectColor
                ..splashRadius = 0
                ..downPosition = downPosition
                ..isFocused = states.contains(MaterialState.focused)
                ..isHovered = states.contains(MaterialState.hovered)
                ..activeColor = effectiveActiveColor
                ..inactiveColor = effectiveFillColor
                ..checkColor = effectiveCheckColor
                ..value = value
                ..previousValue = _previousValue
                ..shape = SmoothRectangleBorder(borderRadius: resolvedBorderRadius)
                ..side = _resolveSide(BorderSide(color: effectiveBorderColor)),
            ),
          ),
        ),
      ),
    );
  }
}
