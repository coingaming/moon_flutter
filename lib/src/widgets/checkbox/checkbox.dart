import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';

class MoonCheckbox extends StatelessWidget {
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

  /// The color to use when this checkbox is checked.
  final Color? activeColor;

  /// The color to use for the check icon when this checkbox is checked.
  final Color? checkColor;

  /// The color to use for the checkbox's background when the checkbox is not checked.
  final Color? fillColor;

  /// The focus node for the checkbox.
  final FocusNode? focusNode;

  const MoonCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveActiveColor =
        activeColor ?? context.moonTheme?.checkboxTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveCheckColor =
        activeColor ?? context.moonTheme?.checkboxTheme.colors.checkColor ?? MoonColors.light.goten;

    final Color effectiveFillColor =
        activeColor ?? context.moonTheme?.checkboxTheme.colors.activeColor ?? MoonColors.light.piccolo;

    final Color effectiveFocusEffectColor =
        context.moonEffects?.controlFocusEffect.effectColor ?? MoonFocusEffects.lightFocusEffect.effectColor;

    final Color effectiveBorderColor =
        activeColor ?? context.moonTheme?.checkboxTheme.colors.borderColor ?? MoonColors.light.trunks;

    final MaterialStateProperty<Color> resolvedFillColor =
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return effectiveFillColor.withOpacity(.32);
      }

      if (states.contains(MaterialState.focused)) {
        return effectiveFocusEffectColor;
      }

      return effectiveFillColor;
    });

    final double effectiveBorderRadiusValue = context.moonTheme?.checkboxTheme.properties.borderRadiusValue ?? 4;

    return SizedBox(
      height: 28,
      width: 28,
      child: FittedBox(
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          tristate: tristate,
          focusNode: focusNode,
          activeColor: effectiveActiveColor,
          checkColor: effectiveCheckColor,
          fillColor: resolvedFillColor,
          focusColor: effectiveFocusEffectColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(color: effectiveBorderColor, width: 1.25),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerRadius: effectiveBorderRadiusValue,
                cornerSmoothing: 1,
              ),
            ),
          ),
          splashRadius: 0,
        ),
      ),
    );
  }
}
