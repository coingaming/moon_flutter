import 'dart:ui' as ui hide TextStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/input/input_size_properties.dart';
import 'package:moon_design/src/theme/input/input_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';

import 'package:moon_tokens/moon_tokens.dart';

export 'package:flutter/services.dart'
    show
        SmartDashesType,
        SmartQuotesType,
        TextCapitalization,
        TextInputAction,
        TextInputType;

enum MoonInputSize {
  sm,
  md,
  lg,
  xl,
}

class MoonInput extends StatelessWidget {
  final bool _isFormInput;

  // Moon Design System properties.
  /// Whether the input has floating label. Applied when [label] is not null.
  final bool hasFloatingLabel;

  /// The border radius of the input.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the input.
  final Color? backgroundColor;

  /// The border color of the active or focused input.
  final Color? activeBorderColor;

  /// The border color of the input in error state.
  /// Takes precedence over [errorColor] if provided.
  final Color? errorBorderColor;

  /// The border color of the inactive input.
  final Color? inactiveBorderColor;

  /// The general color of the input in error state.
  final Color? errorColor;

  /// The hover effect color of the input.
  final Color? hoverColor;

  /// The text color of the input.
  final Color? textColor;

  /// The text color of the input hint.
  final Color? hintTextColor;

  /// The custom decoration of the input.
  final Decoration? decoration;

  /// The gap between the [leading] widget, input area and [trailing] widget.
  final double? gap;

  /// The height of the input (does not include the space taken by [MoonInput.errorBuilder]).
  final double? height;

  /// The width of the input.
  final double? width;

  /// The duration of the input transition animation (enable and disable).
  final Duration? transitionDuration;

  /// The curve of the input transition animation (enable and disable).
  final Curve? transitionCurve;

  /// The padding of the input text.
  final EdgeInsetsGeometry? padding;

  /// The padding of the helper and error widget.
  final EdgeInsetsGeometry? helperErrorPadding;

  /// The padding of the [label]. Applies only when [hasFloatingLabel] is false.
  final EdgeInsetsGeometry? labelPadding;

  /// The size of the input.
  final MoonInputSize? inputSize;

  /// The error text can be used to force input into an error state.
  /// Useful for asynchronous errors.
  ///
  /// The validator errors take precedence over the provided [errorText].
  /// Mutually exclusive with [errorBuilder].
  final String? errorText;

  /// The helper text to display below the input area. Not displayed in error state.
  /// To customize the helper, use [helper].
  /// Mutually exclusive with [helper].
  final String? helperText;

  /// The hint text to display in the input area.
  /// Displayed when the input is empty and focused.
  final String? hintText;

  /// The initial value of the input. If [controller] is provided,
  /// this value is ignored and [controller]'s value is used.
  final String? initialValue;

  /// The text style of the [helper] and error state text.
  final TextStyle? helperErrorTextStyle;

  /// A builder to build and customise the text input [errorText] widget.
  /// If errorBuilder is not provided, default [MoonMessage] is used to
  /// display the [errorText].
  /// Mutually exclusive with [errorText].
  final MoonTextInputErrorBuilder? errorBuilder;

  /// The widget to display before the input area.
  final Widget? leading;

  /// The widget to display after the input area.
  final Widget? trailing;

  /// The widget to display below the input. Not displayed in error state.
  /// Mutually exclusive with [helperText].
  final Widget? helper;

  /// The widget to display above the input if [hasFloatingLabel] is false or
  /// inside the input if [hasFloatingLabel] is true.
  /// If [hasFloatingLabel] is false, the label is always displayed regardless
  /// of input state.
  /// If [hasFloatingLabel] is true, the label is displayed when the input
  /// is empty and not focused. When focused, the label will float to the top
  /// of the input.
  final Widget? label;

  // Flutter properties.

  /// {@macro flutter.widgets.magnifier.TextMagnifierConfiguration.intro}
  ///
  /// {@macro flutter.widgets.magnifier.intro}
  ///
  /// {@macro flutter.widgets.magnifier.TextMagnifierConfiguration.details}
  ///
  /// By default, builds a [CupertinoTextMagnifier] on iOS and [TextMagnifier]
  /// on Android, and builds nothing on all other platforms. If it is desired to
  /// suppress the magnifier, consider passing [TextMagnifierConfiguration.disabled].
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to customize the magnifier that this text field uses.
  ///
  /// ** See code in examples/api/lib/widgets/text_magnifier/text_magnifier.0.dart **
  /// {@end-tool}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Controls the input text.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that is typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// myFocusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it is not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field. The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@template flutter.widgets.TextField.inputAction}
  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  /// {@endtemplate}
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The text style of the input text.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to 'titleMedium' text style from the current [Theme].
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  /// If [hasFloatingLabel] is true and [label] is not null, this value is set
  /// to [TextAlignVertical.bottom].
  final TextAlignVertical? textAlignVertical;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The maximum number of characters (unicode grapheme clusters) to allow in the text field.
  ///
  /// If set, a character counter will be displayed below the
  /// field showing how many characters have been entered. If set to a number
  /// greater than 0, it will also display the maximum number allowed. If set
  /// to [MoonInput.noMaxLength] then only the current character count is displayed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to [MaxLengthEnforcement.none].
  ///
  /// The text field enforces the length with a [LengthLimitingTextInputFormatter],
  /// which is evaluated after the supplied [inputFormatters], if any.
  ///
  /// This value must be either null, [MoonInput.noMaxLength], or greater than 0.
  /// If null (the default) then there is no limit to the number of characters
  /// that can be entered. If set to [MoonInput.noMaxLength], then no limit will
  /// be enforced, but the number of characters entered will still be displayed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the character count.
  ///
  /// If [maxLengthEnforcement] is [MaxLengthEnforcement.none], then more than
  /// [maxLength] characters may be entered, but the error counter and divider
  /// will switch to the [decoration]'s [InputDecoration.errorStyle] when the limit is exceeded.
  ///
  /// {@macro flutter.services.lengthLimitingTextInputFormatter.maxLength}
  final int? maxLength;

  /// Determines how the [maxLength] limit should be enforced.
  ///
  /// {@macro flutter.services.textFormatter.effectiveMaxLengthEnforcement}
  ///
  /// {@macro flutter.services.textFormatter.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// {@macro flutter.widgets.editableText.cursorOpacityAnimates}
  final bool? cursorOpacityAnimates;

  /// The color of the cursor.
  ///
  /// The cursor indicates the current location of text insertion point in
  /// the field.
  final Color? cursorColor;

  /// The color of the cursor when the [MoonInput] is showing an error.
  final Color? cursorErrorColor;

  /// Controls how tall the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxHeightStyle] for details on available styles.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available styles.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@template flutter.material.textfield.onTap}
  /// Called for the first tap in a series of taps.
  ///
  /// The text field builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the text field with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the text field's
  /// internal gesture detector, provide this callback.
  ///
  /// If the text field is created with [enabled] false, taps will not be
  /// recognized.
  ///
  /// To be notified when the text field gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// text field's internal gesture detector, use a [Listener].
  /// {@endtemplate}
  ///
  /// If [onTapAlwaysCalled] is enabled, this will also be called for consecutive
  /// taps.
  final GestureTapCallback? onTap;

  /// Whether [onTap] should be called for every tap.
  ///
  /// Defaults to false, so [onTap] is only called for each distinct tap. When
  /// enabled, [onTap] is called for every tap including consecutive taps.
  final bool onTapAlwaysCalled;

  /// {@macro flutter.widgets.editableText.onTapOutside}
  ///
  /// {@tool dartpad}
  /// This example shows how to use a 'TextFieldTapRegion' to wrap a set of
  /// "spinner" buttons that increment and decrement a value in the [MoonInput]
  /// without causing the text field to lose keyboard focus.
  ///
  /// This example includes a generic 'SpinnerField' class, parameterized by
  /// type T, that you can copy into your own project and customize.
  ///
  /// ** See code in examples/api/lib/widgets/tap_region/text_field_tap_region.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [TapRegion] for how the region group is determined.
  final TapRegionCallback? onTapOutside;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  final MouseCursor? mouseCursor;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@template flutter.material.textfield.restorationId}
  /// Restoration ID to save and restore the state of the text field.
  ///
  /// If non-null, the text field will persist and restore its current scroll
  /// offset and - if no [controller] has been provided - the content of the
  /// text field. If a [controller] has been provided, it is the responsibility
  /// of the owner of that controller to persist and restore it, e.g. by using
  /// a [RestorableTextEditingController].
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  /// {@endtemplate}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.contentInsertionConfiguration}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@macro flutter.widgets.EditableText.contextMenuBuilder}
  ///
  /// If not provided, will build a default menu based on the platform.
  ///
  /// See also:
  ///
  ///  * [AdaptiveTextSelectionToolbar], which is built by default.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Determines whether this text field can request the primary focus.
  ///
  /// Defaults to true. If false, the text field will not request focus
  /// when tapped, or when its context menu is displayed. If false it will not
  /// be possible to move the focus to the text field with tab key.
  final bool canRequestFocus;

  /// {@macro flutter.widgets.undoHistory.controller}
  final UndoHistoryController? undoController;

  /// {@macro flutter.widgets.EditableText.spellCheckConfiguration}
  ///
  /// If [SpellCheckConfiguration.misspelledTextStyle] is not specified in this
  /// configuration, then [materialMisspelledTextStyle] is used by default.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Used to enable/disable this form field auto validation and update its
  /// error text.
  ///
  /// {@template flutter.widgets.FormField.autovalidateMode}
  /// If [AutovalidateMode.onUserInteraction], this FormField will only
  /// auto-validate after its content changes. If [AutovalidateMode.always], it
  /// will auto-validate even without user interaction. If
  /// [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.disabled].
  /// {@endtemplate}
  final AutovalidateMode? autovalidateMode;

  final MoonFormTextInputValidationStatusCallback? validationStatusCallback;

  /// Signature for being notified when a form field changes value.
  ///
  /// Used by [FormField.onSaved].
  final FormFieldSetter<String>? onSaved;

  /// Signature for validating a form field.
  ///
  /// Returns an error string to display if the input is invalid, or null
  /// otherwise.
  ///
  /// Used by [FormField.validator].
  final FormFieldValidator<String>? validator;

  /// Creates a Moon Design input.
  ///
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. By default, it is one, meaning this is a single-line
  /// text field. [maxLines] must not be zero.
  ///
  /// The [maxLength] property is set to null by default, which means the
  /// number of characters allowed in the text field is not restricted. If
  /// [maxLength] is set a character counter will be displayed below the
  /// field showing how many characters have been entered. If the value is
  /// set to a positive integer it will also display the maximum allowed
  /// number of characters to be entered. If the value is set to
  /// [MoonInput.noMaxLength] then only the current length is displayed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  /// The text field enforces the length with a [LengthLimitingTextInputFormatter],
  /// which is evaluated after the supplied [inputFormatters], if any.
  /// The [maxLength] value must be either null or greater than zero.
  ///
  /// If [maxLengthEnforcement] is set to [MaxLengthEnforcement.none], then more
  /// than [maxLength] characters may be entered, and the error counter and
  /// divider will switch to the [decoration].errorStyle when the limit is
  /// exceeded.
  ///
  /// The text cursor is not shown if [showCursor] is false or if [showCursor]
  /// is null (the default) and [readOnly] is true.
  ///
  /// The [selectionHeightStyle] and [selectionWidthStyle] properties allow
  /// changing the shape of the selection highlighting. These properties default
  /// to [ui.BoxHeightStyle.tight] and [ui.BoxWidthStyle.tight] respectively and
  /// must not be null.
  ///
  /// The [textAlign], [autofocus], [obscureText], [readOnly], [autocorrect],
  /// [scrollPadding], [maxLines], [maxLength], [selectionHeightStyle],
  /// [selectionWidthStyle], [enableSuggestions], and
  /// [enableIMEPersonalizedLearning] arguments must not be null.
  ///
  /// See also:
  ///
  ///  * [maxLength], which discusses the precise meaning of "number of
  ///    characters" and how it may differ from the intuitive meaning.
  const MoonInput({
    // Moon Design System properties.
    this.activeBorderColor,
    this.backgroundColor,
    this.borderRadius,
    this.decoration,
    this.errorBorderColor,
    this.errorBuilder,
    this.errorColor,
    this.errorText,
    this.gap,
    this.hasFloatingLabel = false,
    this.height,
    this.helper,
    this.helperErrorPadding,
    this.helperText,
    this.helperErrorTextStyle,
    this.hoverColor,
    this.inactiveBorderColor,
    this.initialValue,
    this.inputSize,
    this.label,
    this.labelPadding,
    this.leading,
    this.padding,
    this.hintText,
    this.hintTextColor,
    this.textColor,
    this.trailing,
    this.transitionCurve,
    this.transitionDuration,
    this.width,

    // Flutter properties.
    super.key,
    this.autocorrect = true,
    this.autofillHints = const <String>[],
    this.autofocus = false,
    this.canRequestFocus = true,
    this.clipBehavior = Clip.hardEdge,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.controller,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.enabled = true,
    this.expands = false,
    this.focusNode,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.magnifierConfiguration,
    this.maxLength,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.mouseCursor,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.onAppPrivateCommand,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.readOnly = false,
    this.restorationId,
    this.scribbleEnabled = true,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.selectionControls,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.spellCheckConfiguration,
    this.strutStyle,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.undoController,
  })  : assert(
          helperText == null || helper == null,
          'Either helperText or helper can be provided, but not both.',
        ),
        validator = null,
        autovalidateMode = null,
        validationStatusCallback = null,
        onSaved = null,
        _isFormInput = false;

  const MoonInput.form({
    // Moon Design System properties.
    this.activeBorderColor,
    this.backgroundColor,
    this.borderRadius,
    this.decoration,
    this.errorBorderColor,
    this.errorBuilder,
    this.errorColor,
    this.errorText,
    this.gap,
    this.hasFloatingLabel = false,
    this.height,
    this.helper,
    this.helperErrorPadding,
    this.helperText,
    this.helperErrorTextStyle,
    this.hoverColor,
    this.inactiveBorderColor,
    this.initialValue,
    this.inputSize,
    this.label,
    this.labelPadding,
    this.leading,
    this.padding,
    this.hintText,
    this.hintTextColor,
    this.textColor,
    this.trailing,
    this.transitionCurve,
    this.transitionDuration,
    this.width,

    // Flutter properties.
    super.key,
    this.autocorrect = true,
    this.autofillHints = const <String>[],
    this.autofocus = false,
    this.autovalidateMode,
    this.canRequestFocus = true,
    this.clipBehavior = Clip.hardEdge,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.controller,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.cursorOpacityAnimates,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection,
    this.enableSuggestions = true,
    this.enabled = true,
    this.expands = false,
    this.focusNode,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.magnifierConfiguration,
    this.maxLength,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.mouseCursor,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.onAppPrivateCommand,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.readOnly = false,
    this.restorationId,
    this.scribbleEnabled = true,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.selectionControls,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.spellCheckConfiguration,
    this.strutStyle,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.undoController,
    this.validationStatusCallback,
    this.validator,
  })  : assert(
          helperText == null || helper == null,
          'Either helperText or helper can be provided, but not both.',
        ),
        _isFormInput = true;

  MoonInputSizeProperties _getMoonInputSize(MoonInputSize? moonTextInputSize) =>
      switch (moonTextInputSize) {
        MoonInputSize.sm => MoonInputSizes(tokens: MoonTokens.light).sm,
        MoonInputSize.md => MoonInputSizes(tokens: MoonTokens.light).md,
        MoonInputSize.lg => MoonInputSizes(tokens: MoonTokens.light).lg,
        MoonInputSize.xl => MoonInputSizes(tokens: MoonTokens.light).xl,
        _ => MoonInputSizes(tokens: MoonTokens.light).md,
      };

  MoonBorder _getBorder(Color borderColor, {double? width}) {
    final MoonInputSizeProperties effectiveMoonInputSize =
        _getMoonInputSize(inputSize);

    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? effectiveMoonInputSize.borderRadius;

    return MoonBorder(
      borderRadius: effectiveBorderRadius,
      side: BorderSide(
        color: borderColor,
        width: width ?? MoonBorders.borders.defaultBorderWidth,
      ),
    );
  }

  MoonTextInputErrorBuilder? _buildErrorWidget() {
    final Color effectiveErrorColor = errorColor ?? MoonColors.light.chichi;

    return errorBuilder ??
        (BuildContext context, String? error) => MoonMessage(
              text: error ?? "",
              horizontalGap: MoonSizes.sizes.x5s,
              icon: Icon(
                HugeIcons.strokeRoundedAlertCircle,
                size: 16,
                color: effectiveErrorColor,
              ),
            );
  }

  Widget? _buildHelperWidget() {
    final Color effectiveHelperTextColor =
        helperErrorTextStyle?.color ?? MoonColors.light.trunks;

    return helperText != null
        ? MoonMessage(
            text: helperText!,
            horizontalGap: MoonSizes.sizes.x5s,
            icon: Icon(
              HugeIcons.strokeRoundedInformationCircle,
              size: 16,
              color: effectiveHelperTextColor,
            ),
          )
        : helper;
  }

  Widget? _buildHintWidget(TextStyle hintTextStyle) => hintText != null
      ? Text(
          hintText!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: hintTextStyle,
        )
      : null;

  Widget? _buildLabelWidget(TextStyle labelTextStyle) => label != null
      ? SpecBuilder(
          style: Style(
            $with.defaultTextStyle.style.as(labelTextStyle),
            $with.iconTheme.data.color(labelTextStyle.color!),
          ),
          builder: (BuildContext context) => label!,
        )
      : null;

  @override
  Widget build(BuildContext context) {
    final MoonInputSizeProperties effectiveMoonInputSize =
        _getMoonInputSize(inputSize);

    final Color effectiveActiveBorderColor =
        activeBorderColor ?? MoonColors.light.piccolo;

    final Color effectiveInactiveBorderColor =
        inactiveBorderColor ?? MoonColors.light.beerus;

    final Color effectiveBackgroundColor =
        backgroundColor ?? MoonColors.light.goku;

    final Color effectiveErrorColor = errorColor ?? MoonColors.light.chichi;

    final Color effectiveHoverColor =
        hoverColor ?? context.moonColors?.heles ?? MoonColors.light.heles;

    final Color effectiveCursorErrorColor =
        cursorErrorColor ?? effectiveErrorColor;

    final Color effectiveTextColor = textColor ?? MoonColors.light.textPrimary;

    final Color effectiveHintTextColor =
        hintTextColor ?? MoonColors.light.trunks;

    final Color effectiveHelperTextColor =
        helperErrorTextStyle?.color ?? MoonColors.light.trunks;

    final double effectiveGap = gap ?? effectiveMoonInputSize.gap;

    final double effectiveHeight = height ?? effectiveMoonInputSize.height;

    final double effectiveDisabledOpacityValue =
        context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    final double resolvedMaxHeight =
        expands ? double.infinity : effectiveHeight;

    final double resolvedMaxWidth =
        expands ? double.infinity : width ?? double.infinity;

    final Duration effectiveTransitionDuration =
        transitionDuration ?? const Duration(milliseconds: 167);

    final Curve effectiveTransitionCurve =
        transitionCurve ?? Curves.fastOutSlowIn;

    final EdgeInsetsGeometry effectivePadding =
        padding ?? effectiveMoonInputSize.padding;

    final EdgeInsetsGeometry effectiveHelperErrorPadding =
        helperErrorPadding ?? EdgeInsets.only(top: MoonSizes.sizes.x4s);

    final EdgeInsetsGeometry effectiveLabelPadding =
        labelPadding ?? EdgeInsets.only(bottom: MoonSizes.sizes.x4s);

    final TextStyle effectiveTextStyle = effectiveMoonInputSize.textStyle
        .copyWith(color: effectiveTextColor)
        .merge(style);

    final TextStyle effectiveHelperTextStyle = MoonTypography
        .typography.body.text12
        .copyWith(color: effectiveHelperTextColor)
        .merge(helperErrorTextStyle);

    final TextStyle effectiveErrorTextStyle =
        effectiveHelperTextStyle.copyWith(color: effectiveErrorColor);

    final TextStyle effectiveHintTextStyle =
        effectiveTextStyle.copyWith(color: effectiveHintTextColor);

    final TextStyle resolvedLabelTextStyle =
        hasFloatingLabel ? effectiveHintTextStyle : effectiveTextStyle;

    final Widget? hint = _buildHintWidget(effectiveHintTextStyle);

    final Widget? label = _buildLabelWidget(resolvedLabelTextStyle);

    final Widget? helper = _buildHelperWidget();

    final Style inputStyle = Style(
      $box.chain
        ..padding.directional.as(effectivePadding)
        ..clipBehavior(decoration != null ? clipBehavior : Clip.none)
        ..constraints.minHeight(effectiveHeight)
        ..constraints.minWidth(width ?? 0)
        ..constraints.maxHeight(resolvedMaxHeight)
        ..constraints.maxWidth(resolvedMaxWidth),
      $flex.chain
        ..gap(effectiveGap)
        ..crossAxisAlignment(
          expands ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
        ),
      decoration != null
          ? decorationToAttribute(decoration!)
          : $with.animatedShapeDecoration(
              bgColor: effectiveBackgroundColor,
              border: _getBorder(effectiveInactiveBorderColor),
              duration: effectiveTransitionDuration,
              curve: effectiveTransitionCurve,
            ),
      $with.animatedOpacity(
        opacity: enabled ? 1.0 : effectiveDisabledOpacityValue,
        duration: effectiveTransitionDuration,
        curve: effectiveTransitionCurve,
      ),
      $on.hover(
        decoration == null
            ? $with.animatedShapeDecoration(
                hoverColor: effectiveHoverColor,
                border: _getBorder(effectiveInactiveBorderColor),
              )
            : null,
      ),
      $on.focus(
        decoration == null
            ? $with.animatedShapeDecoration(
                hoverColor: Colors.transparent,
                border: _getBorder(
                  effectiveActiveBorderColor,
                  width: MoonBorders.borders.activeBorderWidth,
                ),
              )
            : null,
      ),
      $on.error(
        decoration == null
            ? $with.animatedShapeDecoration(
                border: _getBorder(
                  errorBorderColor ?? effectiveErrorColor,
                  width: MoonBorders.borders.activeBorderWidth,
                ),
              )
            : null,
      ),
    );

    final Style helperErrorStyle = Style(
      $box.padding.as(effectiveHelperErrorPadding),
      $with.align(alignment: Alignment.centerLeft),
      $with.iconTheme.data.color(effectiveHelperTextColor),
      $with.defaultTextStyle.style.as(effectiveHelperTextStyle),
      $on.error(
        $with.iconTheme.data.color(effectiveErrorColor),
        $with.defaultTextStyle.style.as(effectiveErrorTextStyle),
      ),
      $with.animatedOpacity(
        opacity: enabled ? 1.0 : effectiveDisabledOpacityValue,
        duration: effectiveTransitionDuration,
        curve: effectiveTransitionCurve,
      ),
    );

    final MoonTextInputConfiguration config = MoonTextInputConfiguration(
      autocorrect: autocorrect,
      autofillHints: autofillHints,
      autofocus: autofocus,
      canRequestFocus: canRequestFocus,
      clipBehavior: clipBehavior,
      contentInsertionConfiguration: contentInsertionConfiguration,
      contextMenuBuilder: contextMenuBuilder,
      controller: controller,
      cursorColor: cursorColor,
      cursorErrorColor: effectiveCursorErrorColor,
      cursorHeight: cursorHeight,
      cursorOpacityAnimates: cursorOpacityAnimates,
      cursorRadius: cursorRadius,
      cursorWidth: cursorWidth,
      dragStartBehavior: dragStartBehavior,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSuggestions: enableSuggestions,
      enabled: enabled,
      errorBuilder: _buildErrorWidget(),
      expands: expands,
      focusNode: focusNode,
      hasFloatingLabel: label != null && hasFloatingLabel,
      helper: helper,
      helperErrorStyle: helperErrorStyle,
      hint: hint,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      inputStyle: inputStyle,
      keyboardAppearance: keyboardAppearance,
      keyboardType: keyboardType,
      label: hasFloatingLabel ? label : null,
      labelTextAlignVertical: hasFloatingLabel && label != null
          ? TextAlignVertical.center
          : textAlignVertical,
      leading: leading,
      magnifierConfiguration: magnifierConfiguration,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      mouseCursor: mouseCursor,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      onAppPrivateCommand: onAppPrivateCommand,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onTapAlwaysCalled: onTapAlwaysCalled,
      onTapOutside: onTapOutside,
      readOnly: readOnly,
      restorationId: restorationId,
      scribbleEnabled: scribbleEnabled,
      scrollController: scrollController,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      selectionControls: selectionControls,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      showCursor: showCursor,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      spellCheckConfiguration: spellCheckConfiguration,
      strutStyle: strutStyle,
      style: effectiveTextStyle,
      textAlign: textAlign,
      textAlignVertical: hasFloatingLabel && label != null
          ? TextAlignVertical.bottom
          : textAlignVertical,
      textCapitalization: textCapitalization,
      textDirection: textDirection,
      textInputAction: textInputAction,
      trailing: trailing,
      transitionCurve: transitionCurve,
      transitionDuration: transitionDuration,
      undoController: undoController,
    );

    final Widget child = _isFormInput
        ? MoonRawFormTextInput(
            restorationId: restorationId,
            autovalidateMode: autovalidateMode,
            onSaved: onSaved,
            validator: validator,
            validationStatusCallback: validationStatusCallback,
            textInputConfiguration: config,
          )
        : MoonRawTextInput(textInputConfiguration: config);

    return (label != null && !hasFloatingLabel)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: enabled ? 1.0 : effectiveDisabledOpacityValue,
                duration: effectiveTransitionDuration,
                curve: effectiveTransitionCurve,
                child: Padding(
                  padding: effectiveLabelPadding,
                  child: label,
                ),
              ),
              child,
            ],
          )
        : child;
  }
}
