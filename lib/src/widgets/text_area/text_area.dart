import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/widgets/input/input.dart';

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

  /// The hover effect color of the text area.
  final Color? hoverColor;

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

  /// The padding of the text area [label].
  final EdgeInsetsGeometry? labelPadding;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// The padding of the [helper] and [errorBuilder] widgets.
  final EdgeInsetsGeometry? helperErrorPadding;

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

  /// The helper text to display below the text area. Not displayed in error state.
  /// To customize the helper, use [helper]. Mutually exclusive with [helper].
  final String? helperText;

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

  /// The text style of the [helper] and error state text.
  final TextStyle? helperErrorTextStyle;

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

  /// The widget that describes the text area field. Displayed above the text area.
  final Widget? label;

  /// Creates a Moon Design text area.
  const MoonTextArea({
    super.key,
    this.activeBorderColor,
    this.autocorrect = true,
    this.autofillHints,
    this.autofocus = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.backgroundColor,
    this.borderRadius,
    this.clipBehavior,
    this.controller,
    this.decoration,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.enabled = true,
    this.errorBuilder,
    this.errorColor,
    this.expands = false,
    this.focusNode,
    this.height,
    this.helper,
    this.helperText,
    this.helperErrorPadding,
    this.helperErrorTextStyle,
    this.hintText,
    this.hintTextColor,
    this.hoverColor,
    this.inactiveBorderColor,
    this.initialValue,
    this.inputFormatters,
    this.keyboardAppearance,
    this.label,
    this.labelPadding,
    this.maxLength,
    this.maxLengthEnforcement,
    this.minLines,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
    this.onTap,
    this.onTapOutside,
    this.readOnly = false,
    this.restorationId,
    this.scribbleEnabled = true,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(24.0),
    this.scrollPhysics,
    this.showCursor,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.textColor,
    this.textDirection,
    this.textInputAction,
    this.textPadding,
    this.textStyle,
    this.transitionCurve,
    this.transitionDuration,
    this.validator,
  }) : assert(
          helperText == null || helper == null,
          'Either helperText or helper can be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry effectiveTextPadding =
        textPadding ?? const EdgeInsets.all(12);

    final TextStyle effectiveTextStyle =
        textStyle ?? MoonTypography.typography.body.text16;

    final Color effectiveTextColor = textColor ?? MoonColors.light.textPrimary;

    final TextStyle resolvedTextStyle =
        effectiveTextStyle.copyWith(color: effectiveTextColor);

    return MoonInput.form(
      activeBorderColor: activeBorderColor,
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      controller: controller,
      cursorColor: effectiveTextColor,
      cursorErrorColor: errorColor,
      decoration: decoration,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSuggestions: enableSuggestions,
      enabled: enabled,
      errorBuilder: errorBuilder,
      errorColor: errorColor,
      expands: expands,
      focusNode: focusNode,
      height: height,
      helper: helper,
      helperText: helperText,
      helperErrorPadding: helperErrorPadding,
      helperErrorTextStyle: helperErrorTextStyle,
      hintText: hintText,
      hintTextColor: hintTextColor,
      hoverColor: hoverColor,
      inactiveBorderColor: inactiveBorderColor,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardAppearance: keyboardAppearance,
      keyboardType: TextInputType.multiline,
      label: label,
      labelPadding: labelPadding,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: null,
      minLines: minLines,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onTapOutside: onTapOutside,
      padding: effectiveTextPadding,
      readOnly: readOnly,
      restorationId: restorationId,
      scribbleEnabled: scribbleEnabled,
      scrollController: scrollController,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      showCursor: showCursor,
      strutStyle: strutStyle,
      style: resolvedTextStyle,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.top,
      textCapitalization: textCapitalization,
      textColor: textColor,
      textDirection: textDirection,
      textInputAction: textInputAction,
      transitionCurve: transitionCurve,
      transitionDuration: transitionDuration,
      validator: validator,
    );
  }
}
