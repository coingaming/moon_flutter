import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    hide FloatingLabelAlignment, FloatingLabelBehavior, InputDecoration, InputDecorator;
import 'package:flutter/rendering.dart';
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
import 'package:moon_design/src/widgets/text_input/input_decorator.dart';

export 'package:flutter/services.dart'
    show SmartDashesType, SmartQuotesType, TextCapitalization, TextInputAction, TextInputType;

enum MoonTextInputSize {
  sm,
  md,
  lg,
  xl,
}

typedef MoonTextInputErrorBuilder = Widget Function(BuildContext context, String? errorText);

/// A Moon Design text input.
///
/// A text input lets the user enter text, either with hardware keyboard or with
/// an onscreen keyboard.
///
/// The text input calls the [onChanged] callback whenever the user changes the
/// text in the field. If the user indicates that they are done typing in the
/// field (e.g., by pressing a button on the soft keyboard), the text input
/// calls the [onSubmitted] callback.
///
/// To control the text that is displayed in the text input, use the
/// [controller]. For example, to set the initial value of the text input, use
/// a [controller] that already contains some text. The [controller] can also
/// control the selection and composing region (and to observe changes to the
/// text, selection, and composing region).
///
/// By default, a text input has a [decoration] that draws a divider below the
/// text input. You can use the [decoration] property to control the decoration,
/// for example by adding a label or an icon. If you set the [decoration]
/// property to null, the decoration will be removed entirely, including the
/// extra padding introduced by the decoration to save space for the labels.
///
/// If [decoration] is non-null (which is the default), the text input requires
/// one of its ancestors to be a [Material] widget.
///
/// To integrate the [MoonTextInput] into a [Form] with other [FormField] widgets,
/// consider using [MoonFormTextInput].
///
/// {@template flutter.material.textfield.wantKeepAlive}
/// When the widget has focus, it will prevent itself from disposing via its
/// underlying [EditableText]'s [AutomaticKeepAliveClientMixin.wantKeepAlive] in
/// order to avoid losing the selection. Removing the focus will allow it to be
/// disposed.
/// {@endtemplate}
///
/// Remember to call [TextEditingController.dispose] of the [TextEditingController]
/// when it is no longer needed. This will ensure we discard any resources used
/// by the object.
///
/// ## Reading values
///
/// A common way to read a value from a MoonTextInput is to use the [onSubmitted]
/// callback. This callback is applied to the text input's current value when
/// the user finishes editing.
///
/// {@macro flutter.widgets.EditableText.lifeCycle}
///
/// For most applications the [onSubmitted] callback will be sufficient for
/// reacting to user input.
///
/// The [onEditingComplete] callback also runs when the user finishes editing.
/// It's different from [onSubmitted] because it has a default value which
/// updates the text controller and yields the keyboard focus. Applications that
/// require different behavior can override the default [onEditingComplete]
/// callback.
///
/// Keep in mind you can also always read the current string from a MoonTextInput's
/// [TextEditingController] using [TextEditingController.text].
///
/// ## Handling emojis and other complex characters
/// {@macro flutter.widgets.EditableText.onChanged}
///
/// In the live Dartpad example above, try typing the emoji 👨‍👩‍👦
/// into the field and submitting. Because the example code measures the length
/// with `value.characters.length`, the emoji is correctly counted as a single
/// character.
///
/// {@macro flutter.widgets.editableText.showCaretOnScreen}
///
/// {@macro flutter.widgets.editableText.accessibility}
class MoonTextInput extends StatefulWidget {
  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = -1;

  // Moon Design props

  /// Whether the text input has floating label.
  final bool hasFloatingLabel;

  /// Whether the focus effect is enabled.
  final bool showFocusEffect;

  /// Whether the input is dense ie takes less space.
  ///
  /// This property is true by default.
  final bool isDense;

  /// The border radius of the input.
  final BorderRadiusGeometry? borderRadius;

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

  /// The padding of the text input.
  final EdgeInsetsGeometry? padding;

  /// The padding around helper widget or error builder.
  final EdgeInsetsGeometry? helperPadding;

  /// The size of the text input.
  final MoonTextInputSize? textInputSize;

  /// Custom shape decoration for the text input.
  final ShapeDecoration? shapeDecoration;

  /// The text for the error
  final String? errorText;

  /// The text for the hint.
  final String? hintText;

  /// The initial value of the input.
  final String? initialValue;

  /// The textStyle to use for the text being edited.
  final TextStyle? textStyle;

  /// The textStyle to use for the error state text.
  final TextStyle? helperTextStyle;

  /// Builder for the error widget.
  final MoonTextInputErrorBuilder? errorBuilder;

  /// The widget in the leading slot of the text input.
  final Widget? leading;

  /// The widget in the trailing slot of the text input.
  final Widget? trailing;

  /// The widget in the helper slot of the text area.
  final Widget? helper;

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
  /// This sample demonstrates how to customize the magnifier that this text input uses.
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
  /// by tapping on a text input. The user might hide the keyboard and
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

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  final TextAlignVertical textAlignVertical;

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

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// The maximum number of characters (Unicode grapheme clusters) to allow in
  /// the text input.
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
  /// The text input enforces the length with a [LengthLimitingTextInputFormatter],
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

  /// If false the text input is "disabled": it ignores taps and its
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
  /// See [ui.BoxHeightStyle] for details on available textStyles.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available textStyles.
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

  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// {@template flutter.material.textfield.onTap}
  /// Called for each distinct tap except for every second tap of a double tap.
  ///
  /// The text input builds a [GestureDetector] to handle input events like tap,
  /// to trigger focus requests, to move the caret, adjust the selection, etc.
  /// Handling some of those events by wrapping the text input with a competing
  /// GestureDetector is problematic.
  ///
  /// To unconditionally handle taps, without interfering with the text input's
  /// internal gesture detector, provide this callback.
  ///
  /// If the text input is created with [enabled] false, taps will not be
  /// recognized.
  ///
  /// To be notified when the text input gains or loses the focus, provide a
  /// [focusNode] and add a listener to that.
  ///
  /// To listen to arbitrary pointer events without competing with the
  /// text input's internal gesture detector, use a [Listener].
  /// {@endtemplate}
  final GestureTapCallback? onTap;

  /// {@macro flutter.widgets.editableText.onTapOutside}
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
  /// Restoration ID to save and restore the state of the text input.
  ///
  /// If non-null, the text input will persist and restore its current scroll
  /// offset and - if no [controller] has been provided - the content of the
  /// text input. If a [controller] has been provided, it is the responsibility
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

  /// {@macro flutter.widgets.EditableText.contextMenuBuilder}
  ///
  /// If not provided, will build a default menu based on the platform.
  ///
  /// See also:
  ///
  ///  * [AdaptiveTextSelectionToolbar], which is built by default.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  /// {@macro flutter.widgets.EditableText.spellCheckConfiguration}
  ///
  /// If [SpellCheckConfiguration.misspelledTextStyle] is not specified in this
  /// configuration, then [materialMisspelledTextStyle] is used by default.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Creates a Moon Design text input.
  ///
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. By default, it is one, meaning this is a single-line
  /// text input. [maxLines] must not be zero.
  ///
  /// The [maxLength] property is set to null by default, which means the
  /// number of characters allowed in the text input is not restricted. If
  /// [maxLength] is set a character counter will be displayed below the
  /// field showing how many characters have been entered. If the value is
  /// set to a positive integer it will also display the maximum allowed
  /// number of characters to be entered. If the value is set to
  /// [MoonTextInput.noMaxLength] then only the current length is displayed.
  ///
  /// After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforcement] is set to
  /// [MaxLengthEnforcement.none].
  /// The text input enforces the length with a [LengthLimitingTextInputFormatter],
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
    super.key,

    // Moon Design props
    this.hasFloatingLabel = false,
    this.showFocusEffect = true,
    this.isDense = true,
    this.borderRadius,
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
    this.padding,
    this.helperPadding,
    this.textInputSize,
    this.shapeDecoration,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.textStyle,
    this.helperTextStyle,
    this.errorBuilder,
    this.leading,
    this.trailing,
    this.helper,

    // Flutter props
    this.controller,
    this.focusNode,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
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
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scribbleEnabled = true,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
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

  /// The [TextStyle] used to indicate misspelled words in the Material textStyle.
  ///
  /// See also:
  ///  * [SpellCheckConfiguration.misspelledTextStyle], the textStyle configured to
  ///    mark misspelled words with.
  ///  * [CupertinoTextField.cupertinoMisspelledTextStyle], the textStyle configured
  ///    to mark misspelled words with in the Cupertino textStyle.
  static const TextStyle materialMisspelledTextStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Colors.red,
    decorationStyle: TextDecorationStyle.wavy,
  );

  @override
  State<MoonTextInput> createState() => _MoonTextInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled, defaultValue: null));
    properties.add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType, defaultValue: TextInputType.text));
    properties.add(DiagnosticsProperty<TextStyle>('textStyle', textStyle, defaultValue: null));
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
    properties
        .add(EnumProperty<MaxLengthEnforcement>('maxLengthEnforcement', maxLengthEnforcement, defaultValue: null));
    properties.add(EnumProperty<TextInputAction>('textInputAction', textInputAction, defaultValue: null));
    properties.add(
      EnumProperty<TextCapitalization>(
        'textCapitalization',
        textCapitalization,
        defaultValue: TextCapitalization.none,
      ),
    );
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start));
    properties.add(DiagnosticsProperty<TextAlignVertical>('textAlignVertical', textAlignVertical, defaultValue: null));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(DoubleProperty('cursorWidth', cursorWidth, defaultValue: 2.0));
    properties.add(DoubleProperty('cursorHeight', cursorHeight, defaultValue: null));
    properties.add(DiagnosticsProperty<Radius>('cursorRadius', cursorRadius, defaultValue: null));
    properties.add(ColorProperty('cursorColor', cursorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Brightness>('keyboardAppearance', keyboardAppearance, defaultValue: null));
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>(
        'scrollPadding',
        scrollPadding,
        defaultValue: const EdgeInsets.all(20.0),
      ),
    );
    properties.add(
      FlagProperty('selectionEnabled', value: selectionEnabled, defaultValue: true, ifFalse: 'selection disabled'),
    );
    properties
        .add(DiagnosticsProperty<TextSelectionControls>('selectionControls', selectionControls, defaultValue: null));
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
  }
}

class _MoonTextInputState extends State<MoonTextInput>
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  late _TextFieldSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  bool _isHovering = false;
  bool _showSelectionHandles = false;

  RestorableTextEditingController? _controller;
  TextEditingController get _effectiveController => widget.controller ?? _controller!.value;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  EditableTextState? get _editableText => editableTextKey.currentState;

  int get _currentLength => _effectiveController.value.text.characters.length;

  bool get _isEnabled => widget.enabled;

  bool get _hasError => _hasIntrinsicError;

  bool get _hasIntrinsicError =>
      widget.maxLength != null &&
      widget.maxLength! > 0 &&
      _effectiveController.value.text.characters.length > widget.maxLength!;

  bool get _canRequestFocus {
    final NavigationMode mode = MediaQuery.maybeOf(context)?.navigationMode ?? NavigationMode.traditional;
    switch (mode) {
      case NavigationMode.traditional:
        return _isEnabled;
      case NavigationMode.directional:
        return true;
    }
  }

  MaxLengthEnforcement get _effectiveMaxLengthEnforcement =>
      widget.maxLengthEnforcement ??
      LengthLimitingTextInputFormatter.getDefaultMaxLengthEnforcement(Theme.of(context).platform);

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text input is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && _effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!_isEnabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (_effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change to show/hide the text selection
      // highlight.
    });
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.drag) {
          _editableText?.bringIntoView(selection.extent);
        }
        break;
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
        break;
    }
  }

  /// Toggle the toolbar when a selection handle is tapped.
  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _handleHover(bool hovering) {
    if (hovering != _isHovering) {
      setState(() {
        _isHovering = hovering;
      });
    }
  }

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

  // AutofillClient implementation start.
  @override
  String get autofillId => _editableText!.autofillId;

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            hintText: widget.hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(autofillConfiguration: autofillConfiguration);
  }
  // AutofillClient implementation end.

  @override
  String? get restorationId => widget.restorationId;

  // API for TextSelectionGestureDetectorBuilderDelegate.
  @override
  late bool forcePressEnabled;

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.selectionEnabled;
  // End of API for TextSelectionGestureDetectorBuilderDelegate.

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _TextFieldSelectionGestureDetectorBuilder(state: this);
    if (widget.controller == null) {
      _createLocalController();
    }
    _effectiveFocusNode.canRequestFocus = _isEnabled;
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

    if (_effectiveFocusNode.hasFocus && widget.readOnly != oldWidget.readOnly && _isEnabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }
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
      !(widget.textStyle != null &&
          widget.textStyle!.inherit == false &&
          (widget.textStyle!.fontSize == null || widget.textStyle!.textBaseline == null)),
      'inherit false textStyle must supply fontSize and textBaseline',
    );

    Color? autocorrectionTextRectColor;
    Offset? cursorOffset;
    Radius? cursorRadius = widget.cursorRadius;
    TextSelectionControls? textSelectionControls = widget.selectionControls;
    VoidCallback? handleDidGainAccessibilityFocus;

    final ThemeData theme = Theme.of(context);

    final bool cursorOpacityAnimates;

    final bool paintCursorAboveText;

    final Brightness keyboardAppearance = widget.keyboardAppearance ?? theme.brightness;

    final Color cursorColor;

    final Color selectionColor;

    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);

    final FocusNode focusNode = _effectiveFocusNode;

    final TextEditingController controller = _effectiveController;

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

    final EdgeInsetsGeometry effectiveHelperPadding = widget.helperPadding ??
        context.moonTheme?.textInputTheme.properties.helperPadding ??
        EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s, vertical: MoonSizes.sizes.x4s);

    final EdgeInsets resolvedDirectionalPadding = effectivePadding.resolve(Directionality.of(context));

    final EdgeInsets correctedPadding = resolvedDirectionalPadding.copyWith(
      left: widget.leading != null ? 0 : resolvedDirectionalPadding.left,
      right: widget.trailing != null ? 0 : resolvedDirectionalPadding.right,
    );

    final TextStyle effectiveTextStyle = widget.textStyle ?? effectiveMoonTextInputSize.textStyle;

    final TextStyle effectiveHelperTextStyle = widget.helperTextStyle ??
        context.moonTheme?.textInputTheme.properties.helperTextStyle ??
        const TextStyle(fontSize: 12);

    final SmoothRectangleBorder defaultBorder = SmoothRectangleBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      side: BorderSide(
        color: _isHovering ? effectiveHoverBorderColor : effectiveInactiveBorderColor,
        width: _isHovering ? MoonBorders.borders.activeBorderWidth : MoonBorders.borders.defaultBorderWidth,
      ),
    );

    final SmoothRectangleBorder focusBorder = SmoothRectangleBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      side: BorderSide(
        color: effectiveActiveBorderColor,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final SmoothRectangleBorder errorBorder = SmoothRectangleBorder(
      borderRadius: effectiveBorderRadius.smoothBorderRadius(context),
      side: BorderSide(
        color: effectiveErrorBorderColor,
        width: MoonBorders.borders.activeBorderWidth,
      ),
    );

    final SmoothRectangleBorder resolvedBorder = widget.errorText != null && !widget.readOnly
        ? errorBorder
        : _effectiveFocusNode.hasFocus && !widget.readOnly
            ? focusBorder
            : defaultBorder;

    final List<TextInputFormatter> formatters = <TextInputFormatter>[
      ...?widget.inputFormatters,
      if (widget.maxLength != null)
        LengthLimitingTextInputFormatter(
          widget.maxLength,
          maxLengthEnforcement: _effectiveMaxLengthEnforcement,
        ),
    ];

    // Set configuration as disabled if not otherwise specified. If specified,
    // ensure that configuration uses Material text textStyle for misspelled words
    // unless a custom textStyle is specified.
    final SpellCheckConfiguration spellCheckConfiguration = widget.spellCheckConfiguration != null &&
            widget.spellCheckConfiguration != const SpellCheckConfiguration.disabled()
        ? widget.spellCheckConfiguration!.copyWith(
            misspelledTextStyle:
                widget.spellCheckConfiguration!.misspelledTextStyle ?? MoonTextInput.materialMisspelledTextStyle,
          )
        : const SpellCheckConfiguration.disabled();

    switch (theme.platform) {
      case TargetPlatform.iOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = true;
        textSelectionControls ??= cupertinoTextSelectionControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = true;
        cursorColor = widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.of(context).devicePixelRatio, 0);
        autocorrectionTextRectColor = selectionColor;
        break;

      case TargetPlatform.macOS:
        final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
        forcePressEnabled = false;
        textSelectionControls ??= cupertinoDesktopTextSelectionControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? cupertinoTheme.primaryColor.withOpacity(0.40);
        cursorRadius ??= const Radius.circular(2.0);
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.of(context).devicePixelRatio, 0);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the MoonTextInput when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        break;

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        forcePressEnabled = false;
        textSelectionControls ??= materialTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        break;

      case TargetPlatform.linux:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        break;

      case TargetPlatform.windows:
        forcePressEnabled = false;
        textSelectionControls ??= desktopTextSelectionControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        cursorColor = widget.cursorColor ?? effectiveTextColor;
        selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withOpacity(0.40);
        handleDidGainAccessibilityFocus = () {
          // Automatically activate the MoonTextInput when it receives accessibility focus.
          if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
            _effectiveFocusNode.requestFocus();
          }
        };
        break;
    }

    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.textable,
      <MaterialState>{
        if (!_isEnabled) MaterialState.disabled,
        if (_isHovering) MaterialState.hovered,
        if (focusNode.hasFocus) MaterialState.focused,
        if (_hasError) MaterialState.error,
      },
    );

    final int? semanticsMaxValueLength;
    if (_effectiveMaxLengthEnforcement != MaxLengthEnforcement.none &&
        widget.maxLength != null &&
        widget.maxLength! > 0) {
      semanticsMaxValueLength = widget.maxLength;
    } else {
      semanticsMaxValueLength = null;
    }

    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          autocorrect: widget.autocorrect,
          autocorrectionTextRectColor: autocorrectionTextRectColor,
          autofillClient: this,
          autofillHints: widget.autofillHints,
          autofocus: widget.autofocus,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          clipBehavior: widget.clipBehavior,
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
          // Only show the selection highlight when the text input is focused.
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
        ),
      ),
    );

    child = AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[focusNode, controller]),
      builder: (BuildContext context, Widget? child) {
        return InputDecorator(
          baseStyle: widget.textStyle,
          expands: widget.expands,
          isEmpty: controller.value.text.isEmpty,
          isFocused: focusNode.hasFocus,
          isHovering: _isHovering,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: correctedPadding,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
            hintStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
            hintText: widget.hasFloatingLabel ? null : widget.hintText,
            isDense: widget.isDense,
            labelStyle: effectiveTextStyle.copyWith(color: effectiveHintTextColor),
            labelText: widget.hasFloatingLabel ? widget.hintText : null,
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
                    padding: EdgeInsetsDirectional.only(start: effectiveGap, end: resolvedDirectionalPadding.right),
                    child: widget.trailing,
                  )
                : SizedBox(height: effectiveHeight),
          ),
          child: child,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoonFocusEffect(
            show: widget.showFocusEffect && _effectiveFocusNode.hasFocus && !widget.readOnly,
            childBorderRadius: effectiveBorderRadius.smoothBorderRadius(context),
            effectColor: widget.errorText == null ? focusEffectColor : errorFocusEffectColor,
            effectExtent: effectiveFocusEffectExtent,
            effectDuration: effectiveTransitionDuration,
            effectCurve: effectiveTransitionCurve,
            // FIXME: Make the borders animate properly with theme animation fix ticket in near future
            child: Container(
              height: widget.keyboardType == TextInputType.multiline && widget.height == null ? null : effectiveHeight,
              decoration: widget.shapeDecoration ??
                  ShapeDecoration(
                    color: effectiveBackgroundColor,
                    shape: resolvedBorder.copyWith(side: BorderSide.none),
                  ),
              foregroundDecoration: widget.shapeDecoration ?? ShapeDecoration(shape: resolvedBorder),
              child: child,
            ),
          ),
          if (widget.helper != null || (widget.errorText != null && widget.errorBuilder != null))
            RepaintBoundary(
              child: AnimatedIconTheme(
                color: widget.errorText != null && widget.errorBuilder != null
                    ? effectiveErrorBorderColor
                    : effectiveHintTextColor,
                duration: effectiveTransitionDuration,
                child: AnimatedDefaultTextStyle(
                  style: effectiveHelperTextStyle.copyWith(
                    color: widget.errorText != null && widget.errorBuilder != null
                        ? effectiveErrorBorderColor
                        : effectiveHintTextColor,
                  ),
                  duration: effectiveTransitionDuration,
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

class _TextFieldSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({
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
  void onSingleTapUp(TapUpDetails details) {
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
          break;
      }
    }
  }
}
