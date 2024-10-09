import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/widgets/text_input/form_text_input.dart';
import 'package:moon_tokens/moon_tokens.dart';

typedef MoonTextAreaErrorBuilder = Widget Function(
  BuildContext context,
  String? errorText,
);

class MoonTextArea extends StatelessWidget {
  /// Sets the auto validation mode of the text area.
  final AutovalidateMode autovalidateMode;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Whether the text area is enabled. When false, taps are ignored and the
  /// opacity reduced.
  final bool enabled;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The border radius of the text area.
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

  /// The background color of the text area.
  final Color? backgroundColor;

  /// The border color of the active or focused text area.
  final Color? activeBorderColor;

  /// The border color of the inactive text area.
  final Color? inactiveBorderColor;

  /// The color of the text area in error state.
  final Color? errorColor;

  /// The border color of the text area on hover.
  final Color? hoverBorderColor;

  /// The text color of the text area.
  final Color? textColor;

  /// The text color of the text area hint.
  final Color? hintTextColor;

  /// The height of the text area (does not include the space taken by
  /// [MoonTextArea.errorBuilder]).
  final double? height;

  /// The duration of the text area transition animation (enable and disable).
  final Duration? transitionDuration;

  /// The curve of the text area transition animation (enable and disable).
  final Curve? transitionCurve;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// The padding of the [helper] and [errorBuilder] widgets.
  final EdgeInsetsGeometry? helperPadding;

  /// The padding of the text content.
  final EdgeInsetsGeometry? textPadding;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The maximum number of characters (unicode grapheme clusters) to allow in
  /// the text area.
  ///
  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///  its parent.
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

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// The custom decoration of the text area.
  final Decoration? decoration;

  /// The hint text to display in the text area.
  final String? hintText;

  /// The initial value of the text area.
  final String? initialValue;

  /// {@template flutter.material.textfield.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///  Flutter.
  /// {@endtemplate}
  final String? restorationId;

  /// The semantic label for the text area.
  final String? semanticLabel;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// The [TextEditingController] used to edit the text in the text area.
  final TextEditingController? controller;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// The text style of the input text.
  ///
  /// This text style is also used as the base style for the [decoration].
  final TextStyle? textStyle;

  /// The text style of the [helper] widget or error state text.
  final TextStyle? helperTextStyle;

  /// The text validator for the text area widget.
  final FormFieldValidator<String>? validator;

  /// The callback that is called when the user taps on the text area.
  final GestureTapCallback? onTap;

  /// The callback that is called when the user taps outside the text area.
  final TapRegionCallback? onTapOutside;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters]: called before the [onChanged] runs and can validate
  ///  and change/format the input value.
  ///  * [onEditingComplete], [onSubmitted]: more specialized input change
  ///  notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// [FormState.save].
  final ValueChanged<String?>? onSaved;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///  automatically shift the focus to the next/previous focusable item when
  ///  the user is done editing.
  final ValueChanged<String>? onSubmitted;

  /// A builder to build the text area error widget.
  final MoonTextAreaErrorBuilder? errorBuilder;

  /// The widget to display below the text area. Not displayed in error state.
  final Widget? helper;

  /// Creates a Moon Design text area.
  const MoonTextArea({
    super.key,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.expands = false,
    this.readOnly = false,
    this.scribbleEnabled = true,
    this.showCursor,
    this.borderRadius,
    this.keyboardAppearance,
    this.clipBehavior,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.hintTextColor,
    this.height,
    this.transitionDuration,
    this.transitionCurve,
    this.scrollPadding = const EdgeInsets.all(24.0),
    this.helperPadding,
    this.textPadding,
    this.focusNode,
    this.validator,
    this.maxLength,
    this.minLines,
    this.autofillHints,
    this.inputFormatters,
    this.maxLengthEnforcement,
    this.scrollController,
    this.scrollPhysics,
    this.decoration,
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
    this.helperTextStyle,
    this.onTap,
    this.onTapOutside,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
    this.errorBuilder,
    this.helper,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ??
        context.moonTheme?.textAreaTheme.properties.borderRadius ??
        BorderRadius.circular(8);

    final Color effectiveBackgroundColor = backgroundColor ??
        context.moonTheme?.textAreaTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveActiveBorderColor = activeBorderColor ??
        context.moonTheme?.textAreaTheme.colors.activeBorderColor ??
        MoonColors.light.piccolo;

    final Color effectiveInactiveBorderColor = inactiveBorderColor ??
        context.moonTheme?.textAreaTheme.colors.inactiveBorderColor ??
        MoonColors.light.beerus;

    final Color effectiveErrorColor = errorColor ??
        context.moonTheme?.textAreaTheme.colors.errorColor ??
        MoonColors.light.chichi;

    final Color effectiveHoverBorderColor = hoverBorderColor ??
        context.moonTheme?.textAreaTheme.colors.hoverBorderColor ??
        MoonColors.light.beerus;

    final Color effectiveTextColor = textColor ??
        context.moonTheme?.textAreaTheme.colors.textColor ??
        MoonColors.light.textPrimary;

    final Color effectiveHelperTextColor = hintTextColor ??
        context.moonTheme?.textAreaTheme.colors.helperTextColor ??
        MoonColors.light.trunks;

    final EdgeInsetsGeometry effectiveHelperPadding = helperPadding ??
        context.moonTheme?.textAreaTheme.properties.helperPadding ??
        EdgeInsets.only(
          left: MoonSizes.sizes.x3s,
          top: MoonSizes.sizes.x4s,
          right: MoonSizes.sizes.x3s,
        );

    final EdgeInsetsGeometry effectiveTextPadding = textPadding ??
        context.moonTheme?.textAreaTheme.properties.textPadding ??
        const EdgeInsets.all(16);

    final TextStyle effectiveTextStyle = textStyle ??
        context.moonTheme?.textAreaTheme.properties.textStyle ??
        MoonTypography.typography.body.text16;

    final TextStyle effectiveHelperTextStyle = helperTextStyle ??
        context.moonTheme?.textAreaTheme.properties.helperTextStyle ??
        MoonTypography.typography.body.text12;

    final Duration effectiveTransitionDuration = transitionDuration ??
        context.moonTheme?.textAreaTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = transitionCurve ??
        context.moonTheme?.textAreaTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    return MoonFormTextInput(
      activeBorderColor: effectiveActiveBorderColor,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      backgroundColor: effectiveBackgroundColor,
      borderRadius: effectiveBorderRadius,
      controller: controller,
      cursorColor: effectiveTextColor,
      cursorErrorColor: effectiveErrorColor,
      enabled: enabled,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSuggestions: enableSuggestions,
      errorColor: effectiveErrorColor,
      errorBuilder: errorBuilder,
      expands: expands,
      focusNode: focusNode,
      height: height,
      helper: helper,
      helperPadding: effectiveHelperPadding,
      helperTextStyle: effectiveHelperTextStyle,
      hintText: hintText,
      hintTextColor: effectiveHelperTextColor,
      hoverBorderColor: effectiveHoverBorderColor,
      inactiveBorderColor: effectiveInactiveBorderColor,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardAppearance: keyboardAppearance,
      keyboardType: TextInputType.multiline,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: null,
      minLines: minLines,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      onTapOutside: onTapOutside,
      padding: effectiveTextPadding,
      readOnly: readOnly,
      restorationId: restorationId,
      scrollController: scrollController,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      decoration: decoration,
      showCursor: showCursor,
      strutStyle: strutStyle,
      style: effectiveTextStyle.copyWith(color: effectiveTextColor),
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.top,
      textCapitalization: textCapitalization,
      textColor: effectiveTextColor,
      textDirection: textDirection,
      textInputAction: textInputAction,
      transitionCurve: effectiveTransitionCurve,
      transitionDuration: effectiveTransitionDuration,
      validator: validator,
    );
  }
}
