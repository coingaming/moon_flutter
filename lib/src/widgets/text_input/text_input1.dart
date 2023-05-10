/* import 'package:flutter/material.dart' hide InputDecoration, FloatingLabelAlignment, FloatingLabelBehavior;
import 'package:flutter/services.dart';

import 'package:moon_design/src/theme/borders.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/effects/focus_effects.dart';
import 'package:moon_design/src/theme/opacity.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/text_input/text_input_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/widgets/common/animated_icon_theme.dart';
import 'package:moon_design/src/widgets/common/effects/focus_effect.dart';
import 'package:moon_design/src/widgets/common/text/input_decorator.dart';

enum MoonTextInputSize {
  sm,
  md,
  lg,
  xl,
}

typedef MoonTextInputErrorBuilder = Widget Function(BuildContext context, String? errorText);

class MoonTextInput extends StatefulWidget {
  /// Used to set the auto validation mode.
  final AutovalidateMode autovalidateMode;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// If false the widget is "disabled": it ignores taps and it has a reduced opacity.
  final bool enabled;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// Whether the text input has floating label.
  final bool hasFloatingLabel;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The border radius of the input.
  final BorderRadiusGeometry? borderRadius;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the input.
  final Color? backgroundColor;

  /// The border color of the active or focused input.
  final Color? activeBorderColor;

  /// The border color of the inactive input.
  final Color? inactiveBorderColor;

  /// The border color of the error input.
  final Color? errorBorderColor;

  /// The border color of the hovered input.
  final Color? hoverBorderColor;

  /// The text color of the input.
  final Color? textColor;

  /// The text color of the hint in input.
  final Color? hintTextColor;

  /// The gap between the leading or trailing and the label widgets.
  final double? gap;

  /// The height of the input (this does not include the space taken by [MoonTextInput.errorBuilder]).
  final double? height;

  /// The transition duration for disable animation.
  final Duration? transitionDuration;

  /// The transition curve for disable animation.
  final Curve? transitionCurve;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// The padding of the text input.
  final EdgeInsetsGeometry? padding;

  /// The padding around supporting widget or error builder.
  final EdgeInsetsGeometry? supportingPadding;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The maximum number of characters (Unicode grapheme clusters) to allow in the input.
  ///
  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of its parent.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Determines how the [maxLength] limit should be enforced.
  ///
  /// {@macro flutter.services.textFormatter.effectiveMaxLengthEnforcement}
  ///
  /// {@macro flutter.services.textFormatter.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// The size of the text input.
  final MoonTextInputSize? textInputSize;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// The text for the hint.
  final String? hintText;

  /// The initial value of the input.
  final String? initialValue;

  /// {@template flutter.material.textfield.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  /// {@endtemplate}
  final String? restorationId;

  /// The semantic label for the widget.
  final String? semanticLabel;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  final TextStyle? textStyle;

  /// The style to use for the error state text.
  final TextStyle? supportingTextStyle;

  /// Validator for the input widget.
  final FormFieldValidator<String>? validator;

  /// A callback that is called when the user taps the input widget.
  final GestureTapCallback? onTap;

  /// A callback that is called when the user taps outside the input widget.
  final TapRegionCallback? onTapOutside;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters]: which are called before [onChanged] runs and can validate and change ("format") the input
  ///    value.
  ///  * [onEditingComplete], [onSubmitted]: which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// [FormState.save].
  final ValueChanged<String?>? onSaved;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which automatically shift the focus to the next/previous
  ///    focusable item when the user is done editing.
  final ValueChanged<String>? onSubmitted;

  /// Builder for the error widget.
  final MoonTextInputErrorBuilder? errorBuilder;

  /// The widget in the leading slot of the text input.
  final Widget? leading;

  /// The widget in the trailing slot of the text input.
  final Widget? trailing;

  /// The widget in the supporting slot of the text area.
  final Widget? supporting;

  const MoonTextInput({
    super.key,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.hasFloatingLabel = false,
    this.readOnly = false,
    this.scribbleEnabled = true,
    this.showCursor,
    this.borderRadius,
    this.keyboardAppearance,
    this.clipBehavior,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.hoverBorderColor,
    this.textColor,
    this.hintTextColor,
    this.gap,
    this.height,
    this.transitionDuration,
    this.transitionCurve,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.padding,
    this.supportingPadding,
    this.focusNode,
    this.maxLength,
    this.minLines,
    this.autofillHints,
    this.inputFormatters,
    this.maxLengthEnforcement,
    this.textInputSize,
    this.scrollController,
    this.scrollPhysics,
    this.hintText,
    this.initialValue,
    this.restorationId,
    this.semanticLabel,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.controller,
    this.textInputAction,
    this.textStyle,
    this.supportingTextStyle,
    this.validator,
    this.onTap,
    this.onTapOutside,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
    this.errorBuilder,
    this.leading,
    this.trailing,
    this.supporting,
  });

  @override
  State<MoonTextInput> createState() => _MoonTextInputState();
}

class _MoonTextInputState extends State<MoonTextInput> {
  bool _isFocused = false;
  bool _isHovered = false;
  String? _errorText;

  MoonTextInputSizeProperties _getMoonTextInputSize(BuildContext context, MoonTextInputSize? moonTextInputSize) {
    switch (moonTextInputSize) {
      case MoonTextInputSize.sm:
        return context.moonTheme?.textInputTheme.sizes.sm ?? MoonTextInputSizeProperties.sm;
      case MoonTextInputSize.md:
        return context.moonTheme?.textInputTheme.sizes.md ?? MoonTextInputSizeProperties.md;
      case MoonTextInputSize.lg:
        return context.moonTheme?.textInputTheme.sizes.lg ?? MoonTextInputSizeProperties.lg;
      case MoonTextInputSize.xl:
        return context.moonTheme?.textInputTheme.sizes.xl ?? MoonTextInputSizeProperties.xl;
      default:
        return context.moonTheme?.textInputTheme.sizes.md ?? MoonTextInputSizeProperties.md;
    }
  }

  Color _getTextColor(BuildContext context, {required Color effectiveBackgroundColor}) {
    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  void _setFocusStatus(bool isFocused) {
    setState(() => _isFocused = isFocused);
  }

  void _setHoverStatus(bool isHovered) {
    setState(() => _isHovered = isHovered);
  }

  String? _validateInput(String? value) {
    final validationResult = widget.validator?.call(value);
    _errorText = validationResult;

    return validationResult;
  }

  @override
  Widget build(BuildContext context) {
    final MoonTextInputSizeProperties effectiveMoonTextInputSize = _getMoonTextInputSize(context, widget.textInputSize);

    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ?? effectiveMoonTextInputSize.borderRadius;

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? context.moonTheme?.textInputTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveActiveBorderColor = widget.activeBorderColor ??
        context.moonTheme?.textInputTheme.colors.activeBorderColor ??
        MoonColors.light.piccolo;

    final Color effectiveInactiveBorderColor = widget.inactiveBorderColor ??
        context.moonTheme?.textInputTheme.colors.inactiveBorderColor ??
        MoonColors.light.beerus;

    final Color effectiveErrorBorderColor = widget.errorBorderColor ??
        context.moonTheme?.textInputTheme.colors.errorBorderColor ??
        MoonColors.light.chiChi100;

    final Color effectiveHoverBorderColor =
        widget.hoverBorderColor ?? context.moonTheme?.textInputTheme.colors.hoverBorderColor ?? MoonColors.light.beerus;

    final Color focusEffectColor =
        context.isDarkMode ? effectiveActiveBorderColor.withOpacity(0.4) : effectiveActiveBorderColor.withOpacity(0.2);

    final Color errorFocusEffectColor =
        context.isDarkMode ? effectiveErrorBorderColor.withOpacity(0.4) : effectiveErrorBorderColor.withOpacity(0.2);

    final Color effectiveTextColor =
        widget.textColor ?? _getTextColor(context, effectiveBackgroundColor: effectiveBackgroundColor);

    final Color effectiveHintTextColor =
        widget.hintTextColor ?? context.moonTheme?.textInputTheme.colors.supportingTextColor ?? MoonColors.light.trunks;

    final double effectiveGap = widget.gap ?? effectiveMoonTextInputSize.gap;

    final double effectiveHeight = widget.height ?? effectiveMoonTextInputSize.height;

    final double effectiveDisabledOpacityValue = context.moonTheme?.opacity.disabled ?? MoonOpacity.opacities.disabled;

    final double effectiveFocusEffectExtent =
        context.moonEffects?.controlFocusEffect.effectExtent ?? MoonFocusEffects.lightFocusEffect.effectExtent;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.textInputTheme.properties.transitionDuration ??
        const Duration(milliseconds: 200);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.textInputTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final EdgeInsetsGeometry effectivePadding = widget.padding ?? effectiveMoonTextInputSize.padding;

    final EdgeInsetsGeometry effectiveSupportingPadding = widget.supportingPadding ??
        context.moonTheme?.textInputTheme.properties.supportingPadding ??
        EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s, vertical: MoonSizes.sizes.x4s);

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final TextStyle effectiveTextStyle = widget.textStyle ?? effectiveMoonTextInputSize.textStyle;

    final TextStyle effectiveSupportingTextStyle = widget.supportingTextStyle ??
        context.moonTheme?.textInputTheme.properties.supportingTextStyle ??
        const TextStyle(fontSize: 12);

    final RoundedRectangleBorder defaultBorder = RoundedRectangleBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      side: BorderSide(
        color: _isHovered ? effectiveHoverBorderColor : effectiveInactiveBorderColor,
        strokeAlign: BorderSide.strokeAlignOutside,
        width: _isHovered ? MoonBorders.borders.activeBorderWidth : MoonBorders.borders.defaultBorderWidth,
      ),
    );

    final RoundedRectangleBorder focusBorder = RoundedRectangleBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      side: BorderSide(
        color: effectiveActiveBorderColor,
        strokeAlign: BorderSide.strokeAlignOutside,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final RoundedRectangleBorder errorBorder = RoundedRectangleBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      side: BorderSide(
        color: effectiveErrorBorderColor,
        strokeAlign: BorderSide.strokeAlignOutside,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final RoundedRectangleBorder resolvedBorder = _errorText != null
        ? errorBorder
        : _isFocused
            ? focusBorder
            : defaultBorder;

    return Semantics(
      label: widget.semanticLabel,
      child: RepaintBoundary(
        child: AnimatedOpacity(
          opacity: widget.enabled ? 1.0 : effectiveDisabledOpacityValue,
          curve: effectiveTransitionCurve,
          duration: effectiveTransitionDuration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoonFocusEffect(
                show: _isFocused,
                effectExtent: effectiveFocusEffectExtent,
                effectColor: _errorText == null ? focusEffectColor : errorFocusEffectColor,
                childBorderRadius: effectiveBorderRadius,
                effectDuration: effectiveTransitionDuration,
                effectCurve: effectiveTransitionCurve,
                child: AnimatedContainer(
                  height: effectiveHeight,
                  duration: effectiveTransitionDuration,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shape: resolvedBorder,
                  ),
                  child: MouseRegion(
                    onEnter: (_) => _setHoverStatus(true),
                    onExit: (_) => _setHoverStatus(false),
                    child: Focus(
                      canRequestFocus: false,
                      onFocusChange: _setFocusStatus,
                      child: TextFormField(
                        autocorrect: widget.autocorrect,
                        autofillHints: widget.autofillHints,
                        autofocus: widget.autofocus,
                        autovalidateMode: widget.autovalidateMode,
                        controller: widget.controller,
                        cursorColor: effectiveTextColor,
                        enabled: widget.enabled,
                        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
                        enableInteractiveSelection: widget.enableInteractiveSelection,
                        enableSuggestions: widget.enableSuggestions,
                        focusNode: widget.focusNode,
                        initialValue: widget.initialValue,
                        inputFormatters: widget.inputFormatters,
                        keyboardAppearance: widget.keyboardAppearance,
                        onChanged: widget.onChanged,
                        onEditingComplete: widget.onEditingComplete,
                        onFieldSubmitted: widget.onSubmitted,
                        onSaved: widget.onSaved,
                        onTap: widget.onTap,
                        onTapOutside: widget.onTapOutside,
                        readOnly: widget.readOnly,
                        restorationId: widget.restorationId,
                        scrollController: widget.scrollController,
                        scrollPadding: widget.scrollPadding,
                        scrollPhysics: widget.scrollPhysics,
                        showCursor: widget.showCursor,
                        strutStyle: widget.strutStyle,
                        style: effectiveTextStyle.copyWith(color: effectiveTextColor /* , height: 1 */),
                        textAlign: widget.textAlign,
                        textAlignVertical: TextAlignVertical.center,
                        textCapitalization: widget.textCapitalization,
                        textDirection: widget.textDirection,
                        textInputAction: widget.textInputAction,
                        validator: _validateInput,
                        decoration: InputDecoration(
                          contentPadding: resolvedDirectionalPadding,
                          isDense: true,
                          border: InputBorder.none,
                          errorStyle: const TextStyle(height: 0.1, fontSize: 0),
                          hintText: widget.hasFloatingLabel ? null : widget.hintText,
                          hintStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor /* , height: 1 */),
                          labelText: widget.hasFloatingLabel ? widget.hintText : null,
                          labelStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
                          floatingLabelStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          prefixStyle: effectiveTextStyle.copyWith(color: effectiveTextColor),
                          prefixIconColor: effectiveTextColor,
                          prefixIconConstraints: BoxConstraints.tightFor(height: effectiveHeight),
                          prefixIcon: widget.leading != null
                              ? Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: resolvedDirectionalPadding.left,
                                    end: effectiveGap,
                                  ),
                                  child: widget.leading,
                                )
                              : null,
                          suffixStyle: effectiveTextStyle.copyWith(color: effectiveTextColor),
                          suffixIconColor: effectiveTextColor,
                          suffixIconConstraints: BoxConstraints.tightFor(height: effectiveHeight),
                          suffixIcon: widget.trailing != null
                              ? Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    end: resolvedDirectionalPadding.right,
                                  ),
                                  child: widget.trailing,
                                )
                              : SizedBox(height: effectiveHeight),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.supporting != null || (_errorText != null && widget.errorBuilder != null))
                RepaintBoundary(
                  child: AnimatedIconTheme(
                    color: _errorText != null && widget.errorBuilder != null
                        ? effectiveErrorBorderColor
                        : effectiveHintTextColor,
                    duration: effectiveTransitionDuration,
                    child: AnimatedDefaultTextStyle(
                      style: effectiveSupportingTextStyle.copyWith(
                        color: _errorText != null && widget.errorBuilder != null
                            ? effectiveErrorBorderColor
                            : effectiveHintTextColor,
                      ),
                      duration: effectiveTransitionDuration,
                      child: Padding(
                        padding: effectiveSupportingPadding,
                        child: _errorText != null && widget.errorBuilder != null
                            ? widget.errorBuilder!(context, _errorText)
                            : widget.supporting,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
 */