import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:moon_design/src/theme/text_input/text_input_size_properties.dart';
import 'package:moon_design/src/theme/text_input/text_input_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/borders.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/opacities.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/border_container.dart';

export 'package:flutter/services.dart'
    show SmartDashesType, SmartQuotesType, TextCapitalization, TextInputAction, TextInputType;

enum MoonTextInputSize {
  sm,
  md,
  lg,
  xl,
}

typedef MoonTextInputErrorBuilder = Widget Function(BuildContext context, String? errorText);

/// A MDS text input.
class MoonTextInput extends StatefulWidget {
  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = -1;

  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  // MDS props

  /// Whether the text input has floating label.
  final bool hasFloatingLabel;

  /// The border radius of the text input.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the text input.
  final Color? backgroundColor;

  /// The border color of the active or focused text input.
  final Color? activeBorderColor;

  /// The border color of the inactive text input.
  final Color? inactiveBorderColor;

  /// The color used for text input error state.
  final Color? errorColor;

  /// The border color of the hovered text input.
  final Color? hoverBorderColor;

  /// The text color of the text input.
  final Color? textColor;

  /// The text color of the hint in text input.
  final Color? hintTextColor;

  /// Custom decoration for the text input.
  final Decoration? decoration;

  /// The gap between the leading, trailing widgets and the text input area.
  final double? gap;

  /// The height of the text input (this does not include the space taken by [MoonTextInput.errorBuilder]).
  final double? height;

  /// The transition duration for disable animation.
  final Duration? transitionDuration;

  /// The transition curve for disable animation.
  final Curve? transitionCurve;

  /// The padding of the text input.
  final EdgeInsetsGeometry? padding;

  /// The padding around helper widget or error builder.
  final EdgeInsetsGeometry? helperPadding;

  /// The size of the text input.
  final MoonTextInputSize? textInputSize;

  /// The text for the error.
  final String? errorText;

  /// The text for the hint.
  final String? hintText;

  /// The initial value of the text input.
  final String? initialValue;

  /// The text style to use for the error state text.
  final TextStyle? helperTextStyle;

  /// Builder for the error widget.
  final MoonTextInputErrorBuilder? errorBuilder;

  /// The widget in the leading slot of the text input.
  final Widget? leading;

  /// The widget in the trailing slot of the text input.
  final Widget? trailing;

  /// The widget in the helper slot of the text input.
  final Widget? helper;

  ///////
  // Flutter props

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

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
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
  /// if it's not showing already.
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
  final TextInputType keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `titleMedium` text style from the current [Theme].
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
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
  final SmartDashesType smartDashesType;

  /// {@macro flutter.services.TextInputConfiguration.smartQuotesType}
  final SmartQuotesType smartQuotesType;

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

  /// Configuration of toolbar options.
  ///
  /// If not set, select all and paste will default to be enabled. Copy and cut
  /// will be disabled if [obscureText] is true. If [readOnly] is true,
  /// paste and cut will be disabled regardless.

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The maximum number of characters (Unicode grapheme clusters) to allow in
  /// the text field.
  ///
  /// If set, a character counter will be displayed below the
  /// field showing how many characters have been entered. If set to a number
  /// greater than 0, it will also display the maximum number allowed. If set
  /// to [MoonTextInput.noMaxLength] then only the current character count is displayed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  ///
  /// The text field enforces the length with a [LengthLimitingTextInputFormatter],
  /// which is evaluated after the supplied [inputFormatters], if any.
  ///
  /// This value must be either null, [MoonTextInput.noMaxLength], or greater than 0.
  /// If null (the default) then there is no limit to the number of characters
  /// that can be entered. If set to [MoonTextInput.noMaxLength], then no limit will
  /// be enforced, but the number of characters entered will still be displayed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the
  /// character count.
  ///
  /// If [maxLengthEnforcement] is [MaxLengthEnforcement.none], then more than
  /// [maxLength] characters may be entered, but the error counter and divider
  /// will switch to the [decoration]'s [InputDecoration.errorStyle] when the
  /// limit is exceeded.
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
  ///
  /// If this is null it will default to the ambient
  /// [DefaultSelectionStyle.cursorColor]. If that is null, and the
  /// [ThemeData.platform] is [TargetPlatform.iOS] or [TargetPlatform.macOS]
  /// it will use [CupertinoThemeData.primaryColor]. Otherwise it will use
  /// the value of [ColorScheme.primary] of [ThemeData.colorScheme].
  final Color? cursorColor;

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
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@template flutter.material.textfield.onTap}
  /// Called for each distinct tap except for every second tap of a double tap.
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
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.editableText.onTapOutside}
  ///
  /// {@tool dartpad}
  /// This example shows how to use a `TextFieldTapRegion` to wrap a set of
  /// "spinner" buttons that increment and decrement a value in the [MoonTextInput]
  /// without causing the text field to lose keyboard focus.
  ///
  /// This example includes a generic `SpinnerField<T>` class that you can copy
  /// into your own project and customize.
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
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.error].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.textable] will be used.
  ///
  /// The [mouseCursor] is the only property of [MoonTextInput] that controls the
  /// appearance of the mouse pointer. All other properties related to "cursor"
  /// stand for the text cursor, which is usually a blinking vertical line at
  /// the editing position.
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

  /// Determine whether this text field can request the primary focus.
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

  /// Creates a MDS text input.
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
  /// [MoonTextInput.noMaxLength] then only the current length is displayed.
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
  const MoonTextInput({
    //MDS props
    this.hasFloatingLabel = false,
    this.borderRadius,
    this.backgroundColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.hintTextColor,
    this.decoration,
    this.gap,
    this.height,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.helperPadding,
    this.textInputSize,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.helperTextStyle,
    this.errorBuilder,
    this.leading,
    this.trailing,
    this.helper,
    /////////////////
    // Flutter props
    super.key,
    this.controller,
    this.focusNode,
    this.undoController,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
  })  : assert(obscuringCharacter.length == 1),
        smartDashesType = smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength == MoonTextInput.noMaxLength || maxLength > 0),
        // Assert the following instead of setting it directly to avoid surprising the user by silently changing the value they set.
        assert(
          !identical(textInputAction, TextInputAction.newline) ||
              maxLines == 1 ||
              !identical(keyboardType, TextInputType.text),
          'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline MoonTextInput.',
        ),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection = enableInteractiveSelection ?? (!readOnly || !obscureText);

  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  @override
  State<MoonTextInput> createState() => _MoonTextInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(DiagnosticsProperty<UndoHistoryController>('undoController', undoController, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties.add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType, defaultValue: TextInputType.text));
    properties.add(DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(DiagnosticsProperty<String>('obscuringCharacter', obscuringCharacter, defaultValue: '•'));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect, defaultValue: true));
    properties.add(
      EnumProperty<SmartDashesType>(
        'smartDashesType',
        smartDashesType,
        defaultValue: obscureText ? SmartDashesType.disabled : SmartDashesType.enabled,
      ),
    );
    properties.add(
      EnumProperty<SmartQuotesType>(
        'smartQuotesType',
        smartQuotesType,
        defaultValue: obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled,
      ),
    );
    properties.add(DiagnosticsProperty<bool>('enableSuggestions', enableSuggestions, defaultValue: true));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
    properties.add(
      EnumProperty<MaxLengthEnforcement>('maxLengthEnforcement', maxLengthEnforcement, defaultValue: null),
    );
    properties.add(EnumProperty<TextInputAction>('textInputAction', textInputAction, defaultValue: null));
    properties.add(
      EnumProperty<TextCapitalization>('textCapitalization', textCapitalization, defaultValue: TextCapitalization.none),
    );
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start));
    properties.add(DiagnosticsProperty<TextAlignVertical>('textAlignVertical', textAlignVertical, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
    properties.add(DoubleProperty('cursorHeight', cursorHeight, defaultValue: null));
    properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('cursorOpacityAnimates', cursorOpacityAnimates, defaultValue: null));
    properties.add(ColorProperty('cursorColor', cursorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Brightness>('keyboardAppearance', keyboardAppearance, defaultValue: null));
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>('scrollPadding', scrollPadding, defaultValue: const EdgeInsets.all(20.0)),
    );
    properties.add(
      FlagProperty('selectionEnabled', value: selectionEnabled, defaultValue: true, ifFalse: 'selection disabled'),
    );
    properties.add(
      DiagnosticsProperty<TextSelectionControls>('selectionControls', selectionControls, defaultValue: null),
    );
    properties.add(DiagnosticsProperty<ScrollController>('scrollController', scrollController, defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>('scrollPhysics', scrollPhysics, defaultValue: null));
    properties.add(DiagnosticsProperty<Clip>('clipBehavior', clipBehavior, defaultValue: Clip.hardEdge));
    properties.add(DiagnosticsProperty<bool>('scribbleEnabled', scribbleEnabled, defaultValue: true));
    properties.add(
      DiagnosticsProperty<bool>('enableIMEPersonalizedLearning', enableIMEPersonalizedLearning, defaultValue: true),
    );
    properties.add(
      DiagnosticsProperty<SpellCheckConfiguration>(
        'spellCheckConfiguration',
        spellCheckConfiguration,
        defaultValue: null,
      ),
    );
    properties.add(
      DiagnosticsProperty<List<String>>(
        'contentCommitMimeTypes',
        contentInsertionConfiguration?.allowedMimeTypes ?? const <String>[],
        defaultValue: contentInsertionConfiguration == null ? const <String>[] : kDefaultContentInsertionMimeTypes,
      ),
    );
  }
}

class _MoonTextInputState extends State<MoonTextInput>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  late bool forcePressEnabled;

  late _MoonTextInputSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  RestorableTextEditingController? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;
  bool _showSelectionHandles = false;

  bool get _isEnabled => widget.enabled;

  bool get _hasError => _hasIntrinsicError || widget.errorText != null;

  bool get _hasFocus => _effectiveFocusNode.hasFocus;

  int get _currentLength => _effectiveController.value.text.characters.length;

  EditableTextState? get _editableText => editableTextKey.currentState;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeNavigationModeOf(context) ?? NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return widget.canRequestFocus && _isEnabled;
      case NavigationMode.directional:
        return true;
    }
  }

  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      _effectiveController.value.text.characters.length > widget.maxLength!;

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(Theme.of(context).platform);

  Set<MaterialState> get _materialState {
    return <MaterialState>{
      if (!_isEnabled) MaterialState.disabled,
      if (_isHovering) MaterialState.hovered,
      if (_hasFocus) MaterialState.focused,
      if (_hasError) MaterialState.error,
    };
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  String get autofillId => _editableText!.autofillId;

  @override
  bool get selectionEnabled => widget.selectionEnabled;

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            //hintText: (widget.decoration ?? const InputDecoration()).hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(autofillConfiguration: autofillConfiguration);
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);

    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);

    if (!restorePending) _registerController();
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection highlight.
    });
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);

    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() => _showSelectionHandles = willShowSelectionHandles);
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress) _editableText?.bringIntoView(selection.extent);
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) _editableText?.hideToolbar();
    }
  }

  void _handleHover(bool hovering) {
    if (!_isEnabled) return;

    if (hovering != _isHovering) {
      setState(() => _isHovering = hovering);
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _registerController() {
    assert(_controller != null);

    registerForRestoration(_controller!, 'controller');
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) return false;
    if (cause == SelectionChangedCause.keyboard) return false;
    if (widget.readOnly && _effectiveController.selection.isCollapsed) return false;
    if (!_isEnabled) return false;
    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.scribble) return true;
    if (_effectiveController.text.isNotEmpty) return true;

    return false;
  }

  MoonTextInputSizeProperties _getMoonTextInputSize(BuildContext context, MoonTextInputSize? moonTextInputSize) {
    switch (moonTextInputSize) {
      case MoonTextInputSize.sm:
        return context.moonTheme?.textInputTheme.sizes.sm ?? MoonTextInputSizes(tokens: MoonTokens.light).sm;
      case MoonTextInputSize.md:
        return context.moonTheme?.textInputTheme.sizes.md ?? MoonTextInputSizes(tokens: MoonTokens.light).md;
      case MoonTextInputSize.lg:
        return context.moonTheme?.textInputTheme.sizes.lg ?? MoonTextInputSizes(tokens: MoonTokens.light).lg;
      case MoonTextInputSize.xl:
        return context.moonTheme?.textInputTheme.sizes.xl ?? MoonTextInputSizes(tokens: MoonTokens.light).xl;
      default:
        return context.moonTheme?.textInputTheme.sizes.md ?? MoonTextInputSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  void initState() {
    super.initState();

    _selectionGestureDetectorBuilder = _MoonTextInputSelectionGestureDetectorBuilder(state: this);

    if (widget.controller == null) _createLocalController();

    _effectiveFocusNode.canRequestFocus = widget.canRequestFocus && _isEnabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveFocusNode.canRequestFocus = _canRequestFocus;
  }

  @override
  void didUpdateWidget(MoonTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null) {
      _createLocalController(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      unregisterFromRestoration(_controller!);
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    _effectiveFocusNode.canRequestFocus = _canRequestFocus;

    if (_hasFocus && widget.readOnly != oldWidget.readOnly && _isEnabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) _registerController();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasDirectionality(context));
    assert(
      !(widget.style != null &&
          widget.style!.inherit == false &&
          (widget.style!.fontSize == null || widget.style!.textBaseline == null)),
      'inherit false style must supply fontSize and textBaseline',
    );

    final ThemeData theme = Theme.of(context);
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);
    final Brightness keyboardAppearance = widget.keyboardAppearance ?? theme.brightness;
    final TextEditingController controller = _effectiveController;
    final FocusNode focusNode = _effectiveFocusNode;

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

    final Color effectiveErrorColor =
        widget.errorColor ?? context.moonTheme?.textInputTheme.colors.errorColor ?? MoonColors.light.chiChi100;

    final Color effectiveHoverBorderColor =
        widget.hoverBorderColor ?? context.moonTheme?.textInputTheme.colors.hoverBorderColor ?? MoonColors.light.beerus;

    final Color effectiveTextColor =
        widget.textColor ?? context.moonTheme?.textInputTheme.colors.textColor ?? MoonColors.light.textPrimary;

    final Color effectiveHintTextColor =
        widget.hintTextColor ?? context.moonTheme?.textInputTheme.colors.helperTextColor ?? MoonColors.light.trunks;

    final double effectiveGap = widget.gap ?? effectiveMoonTextInputSize.gap;

    final double effectiveHeight = widget.height ?? effectiveMoonTextInputSize.height;

    final double effectiveDisabledOpacityValue = context.moonOpacities?.disabled ?? MoonOpacities.opacities.disabled;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.textInputTheme.properties.transitionDuration ??
        const Duration(milliseconds: 167);

    final Curve effectiveTransitionCurve =
        widget.transitionCurve ?? context.moonTheme?.textInputTheme.properties.transitionCurve ?? Curves.fastOutSlowIn;

    final EdgeInsetsGeometry effectivePadding = widget.padding ?? effectiveMoonTextInputSize.padding;

    final EdgeInsets resolvedContentPadding = effectivePadding.resolve(Directionality.of(context));

    final EdgeInsetsGeometry effectiveHelperPadding = widget.helperPadding ??
        context.moonTheme?.textInputTheme.properties.helperPadding ??
        EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s, vertical: MoonSizes.sizes.x4s);

    final TextStyle effectiveTextStyle = widget.style ?? effectiveMoonTextInputSize.textStyle;

    final TextStyle effectiveHelperTextStyle = widget.helperTextStyle ??
        context.moonTheme?.textInputTheme.properties.helperTextStyle ??
        MoonTypography.typography.body.text12;

    final MoonSquircleBorder defaultBorder = MoonSquircleBorder(
      borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
      side: BorderSide(
        color: effectiveInactiveBorderColor,
        width: MoonBorders.borders.defaultBorderWidth,
      ),
    );

    final MoonSquircleBorder hoverBorder = MoonSquircleBorder(
      borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
      side: BorderSide(
        color: effectiveHoverBorderColor,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final MoonSquircleBorder focusBorder = MoonSquircleBorder(
      borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
      side: BorderSide(
        color: effectiveActiveBorderColor,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final MoonSquircleBorder errorBorder = MoonSquircleBorder(
      borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
      side: BorderSide(
        color: effectiveErrorColor,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final MoonSquircleBorder resolvedBorder = _hasError
        ? errorBorder
        : _hasFocus
            ? focusBorder
            : _isHovering
                ? hoverBorder
                : defaultBorder;

    bool? cursorOpacityAnimates = widget.cursorOpacityAnimates;
    Color? autocorrectionTextRectColor;
    Offset? cursorOffset;
    Radius? cursorRadius = widget.cursorRadius;
    VoidCallback? handleDidGainAccessibilityFocus;

    final bool paintCursorAboveText;
    final Color cursorColor;
    final Color selectionColor;
    final TextSelectionControls? textSelectionControls = widget.selectionControls;

    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.textable,
      _materialState,
    );

    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    // Set configuration as disabled if not otherwise specified. If specified,
    // ensure that configuration uses the correct style for misspelled words for
    // the current platform, unless a custom style is specified.
    final SpellCheckConfiguration spellCheckConfiguration;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        spellCheckConfiguration = CupertinoTextField.inferIOSSpellCheckConfiguration(widget.spellCheckConfiguration);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        spellCheckConfiguration = TextField.inferAndroidSpellCheckConfiguration(widget.spellCheckConfiguration);
    }

    final int? semanticsMaxValueLength;
    if (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
        widget.maxLength != null &&
        widget.maxLength! > 0) {
      semanticsMaxValueLength = widget.maxLength;
    } else {
      semanticsMaxValueLength = null;
    }

    switch (theme.platform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= true;
        cursorColor = _hasError ? effectiveErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        autocorrectionTextRectColor = selectionColor;

      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = false;
        paintCursorAboveText = true;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the MoonTextInput when it receives accessibility focus.
          if (!_hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);

      case TargetPlatform.linux:
        forcePressEnabled = false;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);

      case TargetPlatform.windows:
        forcePressEnabled = false;
        paintCursorAboveText = false;
        cursorOpacityAnimates ??= false;
        cursorColor = _hasError ? effectiveErrorColor : widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the MoonTextInput when it receives accessibility focus.
          if (!_hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
    }

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          autocorrect: widget.autocorrect,
          autocorrectionTextRectColor: autocorrectionTextRectColor,
          autofillClient: this,
          autofocus: widget.autofocus,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          clipBehavior: widget.clipBehavior,
          contentInsertionConfiguration: widget.contentInsertionConfiguration,
          contextMenuBuilder: widget.contextMenuBuilder,
          controller: controller,
          cursorColor: cursorColor,
          cursorHeight: widget.cursorHeight,
          cursorOffset: cursorOffset,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorRadius: cursorRadius,
          cursorWidth: widget.cursorWidth,
          dragStartBehavior: widget.dragStartBehavior,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          enableSuggestions: widget.enableSuggestions,
          expands: widget.expands,
          focusNode: focusNode,
          inputFormatters: formatters,
          keyboardAppearance: keyboardAppearance,
          keyboardType: widget.keyboardType,
          magnifierConfiguration: widget.magnifierConfiguration ?? TextMagnifier.adaptiveMagnifierConfiguration,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          mouseCursor: MouseCursor.defer, // MoonTextInput will handle the cursor
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          onAppPrivateCommand: widget.onAppPrivateCommand,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onSelectionChanged: _handleSelectionChanged,
          onSelectionHandleTapped: _handleSelectionHandleTapped,
          onSubmitted: widget.onSubmitted,
          onTapOutside: widget.onTapOutside,
          paintCursorAboveText: paintCursorAboveText,
          readOnly: widget.readOnly || !_isEnabled,
          rendererIgnoresPointer: true,
          restorationId: 'editable',
          scribbleEnabled: widget.scribbleEnabled,
          scrollController: widget.scrollController,
          scrollPadding: widget.scrollPadding,
          scrollPhysics: widget.scrollPhysics,
          selectionColor: focusNode.hasFocus ? selectionColor : null,
          selectionControls: widget.selectionEnabled ? textSelectionControls : null,
          selectionHeightStyle: widget.selectionHeightStyle,
          selectionWidthStyle: widget.selectionWidthStyle,
          showCursor: widget.showCursor,
          showSelectionHandles: _showSelectionHandles,
          smartDashesType: widget.smartDashesType,
          smartQuotesType: widget.smartQuotesType,
          spellCheckConfiguration: spellCheckConfiguration,
          strutStyle: widget.strutStyle,
          style: effectiveTextStyle.copyWith(color: effectiveTextColor),
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          textDirection: widget.textDirection,
          textInputAction: widget.textInputAction,
          undoController: widget.undoController,
        ),
      ),
    );

    child = AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[focusNode, controller]),
      builder: (BuildContext context, Widget? child) {
        return BorderContainer(
          backgroundColor: effectiveBackgroundColor,
          border: resolvedBorder,
          decoration: widget.decoration,
          height: widget.keyboardType == TextInputType.multiline && widget.height == null ? null : effectiveHeight,
          duration: effectiveTransitionDuration,
          curve: effectiveTransitionCurve,
          child: Row(
            children: [
              if (widget.leading != null)
                SizedBox(
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: resolvedContentPadding.left,
                      end: effectiveGap,
                    ),
                    child: widget.leading,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: widget.leading != null ? 0 : resolvedContentPadding.left,
                    right: widget.trailing != null ? 0 : resolvedContentPadding.right,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: widget.hasFloatingLabel
                            ? Alignment.bottomCenter
                            : widget.textAlignVertical == TextAlignVertical.top
                                ? Alignment.topCenter
                                : Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: resolvedContentPadding.bottom),
                          child: child,
                        ),
                      ),
                      if (widget.hintText != null)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: resolvedContentPadding.top),
                          child: AnimatedScale(
                            alignment: Directionality.of(context) == TextDirection.ltr
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            duration: effectiveTransitionDuration,
                            scale: widget.hasFloatingLabel && (focusNode.hasFocus || controller.value.text.isNotEmpty)
                                ? 0.75
                                : 1.0,
                            child: AnimatedAlign(
                              duration: effectiveTransitionDuration,
                              alignment: widget.textAlignVertical == TextAlignVertical.top ||
                                      (widget.hasFloatingLabel &&
                                          (focusNode.hasFocus || controller.value.text.isNotEmpty))
                                  ? AlignmentDirectional.topStart
                                  : AlignmentDirectional.centerStart,
                              child: AnimatedOpacity(
                                opacity: (controller.value.text.isEmpty || widget.hasFloatingLabel) ? 1.0 : 0.0,
                                duration: effectiveTransitionDuration,
                                curve: effectiveTransitionCurve,
                                child: Text(
                                  widget.hintText!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: widget.textAlign,
                                  style: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (widget.trailing != null)
                SizedBox(
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: effectiveGap,
                      end: resolvedContentPadding.right,
                    ),
                    child: widget.trailing,
                  ),
                ),
            ],
          ),
        );
      },
      child: child,
    );

    child = AnimatedOpacity(
      opacity: widget.enabled ? 1.0 : effectiveDisabledOpacityValue,
      curve: effectiveTransitionCurve,
      duration: effectiveTransitionDuration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          child,
          if (widget.helper != null || (widget.errorText != null && widget.errorBuilder != null))
            RepaintBoundary(
              child: IconTheme(
                data: IconThemeData(
                  color: widget.errorText != null && widget.errorBuilder != null
                      ? effectiveErrorColor
                      : effectiveHintTextColor,
                ),
                child: DefaultTextStyle(
                  style: effectiveHelperTextStyle.copyWith(
                    color: widget.errorText != null && widget.errorBuilder != null
                        ? effectiveErrorColor
                        : effectiveHintTextColor,
                  ),
                  child: Padding(
                    padding: effectiveHelperPadding,
                    child: widget.errorText != null && widget.errorBuilder != null
                        ? widget.errorBuilder!(context, widget.errorText)
                        : widget.helper,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return MouseRegion(
      cursor: effectiveMouseCursor,
      onEnter: (PointerEnterEvent event) => _handleHover(true),
      onExit: (PointerExitEvent event) => _handleHover(false),
      child: TextFieldTapRegion(
        child: IgnorePointer(
          ignoring: !_isEnabled,
          child: AnimatedBuilder(
            animation: controller, // changes the _currentLength
            builder: (BuildContext context, Widget? child) {
              return Semantics(
                maxValueLength: semanticsMaxValueLength,
                currentValueLength: _currentLength,
                onTap: widget.readOnly
                    ? null
                    : () {
                        if (!_effectiveController.selection.isValid) {
                          _effectiveController.selection =
                              TextSelection.collapsed(offset: _effectiveController.text.length);
                        }
                        _requestKeyboard();
                      },
                onDidGainAccessibilityFocus: handleDidGainAccessibilityFocus,
                child: child,
              );
            },
            child: _selectionGestureDetectorBuilder.buildGestureDetector(
              behavior: HitTestBehavior.translucent,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _MoonTextInputSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _MoonTextInputSelectionGestureDetectorBuilder({
    required _MoonTextInputState state,
  })  : _state = state,
        super(delegate: state);

  final _MoonTextInputState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    super.onSingleTapUp(details);
    _state._requestKeyboard();
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    super.onSingleLongTapStart(details);
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          Feedback.forLongPress(_state.context);
      }
    }
  }
}
