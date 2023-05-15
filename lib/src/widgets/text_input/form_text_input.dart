import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'
    hide FloatingLabelAlignment, FloatingLabelBehavior, InputDecoration, InputDecorator;
import 'package:flutter/services.dart';

import 'package:moon_design/src/widgets/text_input/input_decorator.dart';
import 'package:moon_design/src/widgets/text_input/text_input.dart';

export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType;

/// A [FormField] that contains a [MoonTextInput].
///
/// This is a convenience widget that wraps a [MoonTextInput] widget in a
/// [FormField].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a `GlobalKey<FormFieldState>` (see [GlobalKey]) to the constructor and use
/// [GlobalKey.currentState] to save or reset the form field.
///
/// When a [controller] is specified, its [TextEditingController.text]
/// defines the [initialValue]. If this [FormField] is part of a scrolling
/// container that lazily constructs its children, like a [ListView] or a
/// [CustomScrollView], then a [controller] should be specified.
/// The controller's lifetime should be managed by a stateful widget ancestor
/// of the scrolling container.
///
/// If a [controller] is not specified, [initialValue] can be used to give
/// the automatically generated controller an initial value.
///
/// {@macro flutter.material.textfield.wantKeepAlive}
///
/// Remember to call [TextEditingController.dispose] of the [TextEditingController]
/// when it is no longer needed. This will ensure any resources used by the object
/// are discarded.
///
/// For a documentation about the various parameters, see [MoonTextInput].
///
/// {@tool snippet}
///
/// Creates a [MoonFormTextInput] with an [InputDecoration] and validator function.
///
/// ![If the user enters valid text, the MoonTextInput appears normally without any warnings to the user](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field.png)
///
/// ![If the user enters invalid text, the error message returned from the validator function is displayed in dark red underneath the input](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field_error.png)
///
/// ```dart
/// MoonFormTextInput(
///   leading: Icon(Icons.person),
///   hintText: 'What do people call you?',
///   labelText: 'Name *',
///   onSaved: (String? value) {
///     // This optional block of code can be used to run
///     // code when the user saves the form.
///   },
///   validator: (String? value) {
///     return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
///   },
/// )
/// ```
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to move the focus to the next field when the user
/// presses the SPACE key.
///
/// ** See code in examples/api/lib/material/text_form_field/text_form_field.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * <https://material.io/design/components/text-fields.html>
///  * [MoonTextInput], which is the underlying text field without the [Form]
///    integration.
class MoonFormTextInput extends FormField<String> {
  /// Creates a [FormField] that contains a [MoonTextInput].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [MoonTextInput] class.
  MoonFormTextInput({
    super.key,
    super.onSaved,
    super.restorationId,
    super.validator,
    this.controller,
    AppPrivateCommandCallback? onAppPrivateCommand,
    AutovalidateMode? autovalidateMode,
    bool autocorrect = true,
    bool autofocus = false,
    bool enableIMEPersonalizedLearning = true,
    bool enableSuggestions = true,
    bool expands = false,
    bool hasFloatingLabel = false,
    bool hasFocusEffect = true,
    bool isDense = true,
    bool obscureText = false,
    bool readOnly = false,
    bool scribbleEnabled = true,
    bool? enabled,
    bool? enableInteractiveSelection,
    bool? showCursor,
    BorderRadiusGeometry? borderRadius,
    Brightness? keyboardAppearance,
    Clip clipBehavior = Clip.hardEdge,
    Color? activeBorderColor,
    Color? backgroundColor,
    Color? cursorColor,
    Color? errorBorderColor,
    Color? hintTextColor,
    Color? hoverBorderColor,
    Color? inactiveBorderColor,
    Color? textColor,
    Curve? transitionCurve,
    double cursorWidth = 2.0,
    double? cursorHeight,
    double? gap,
    double? height,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Duration? transitionDuration,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? helperPadding,
    EditableTextContextMenuBuilder? contextMenuBuilder = _defaultContextMenuBuilder,
    FocusNode? focusNode,
    GestureTapCallback? onTap,
    int? maxLength,
    int? maxLines = 1,
    int? minLines,
    Iterable<String>? autofillHints,
    List<TextInputFormatter>? inputFormatters,
    MaxLengthEnforcement? maxLengthEnforcement,
    MoonTextInputErrorBuilder? errorBuilder,
    MoonTextInputSize? textInputSize,
    MouseCursor? mouseCursor,
    Radius? cursorRadius,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    SpellCheckConfiguration? spellCheckConfiguration,
    String obscuringCharacter = '•',
    String? hintText,
    String? initialValue,
    StrutStyle? strutStyle,
    TapRegionCallback? onTapOutside,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical = TextAlignVertical.center,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextDirection? textDirection,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    TextMagnifierConfiguration? magnifierConfiguration,
    TextSelectionControls? selectionControls,
    TextStyle? style,
    TextStyle? helperTextStyle,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    VoidCallback? onEditingComplete,
    Widget? leading,
    Widget? trailing,
    Widget? helper,
  })  : assert(initialValue == null || controller == null),
        assert(obscuringCharacter.length == 1),
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
        super(
          initialValue: controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _TextFormFieldState state = field as _TextFormFieldState;

            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: MoonTextInput(
                activeBorderColor: activeBorderColor,
                autocorrect: autocorrect,
                autofillHints: autofillHints,
                autofocus: autofocus,
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                clipBehavior: clipBehavior,
                contextMenuBuilder: contextMenuBuilder,
                controller: state._effectiveController,
                cursorColor: cursorColor,
                cursorHeight: cursorHeight,
                cursorRadius: cursorRadius,
                cursorWidth: cursorWidth,
                dragStartBehavior: dragStartBehavior,
                enabled: enabled ?? true,
                enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
                enableInteractiveSelection: enableInteractiveSelection ?? (!obscureText || !readOnly),
                enableSuggestions: enableSuggestions,
                errorBorderColor: errorBorderColor,
                errorBuilder: errorBuilder,
                errorText: field.errorText,
                expands: expands,
                focusNode: focusNode,
                gap: gap,
                hasFloatingLabel: hasFloatingLabel,
                hasFocusEffect: hasFocusEffect,
                height: height,
                hintText: hintText,
                hintTextColor: hintTextColor,
                hoverBorderColor: hoverBorderColor,
                inactiveBorderColor: inactiveBorderColor,
                initialValue: initialValue,
                inputFormatters: inputFormatters,
                isDense: isDense,
                keyboardAppearance: keyboardAppearance,
                keyboardType: keyboardType,
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
                onChanged: onChangedHandler,
                onEditingComplete: onEditingComplete,
                onSubmitted: onFieldSubmitted,
                onTap: onTap,
                onTapOutside: onTapOutside,
                padding: padding,
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
                smartDashesType: smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
                smartQuotesType: smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
                spellCheckConfiguration: spellCheckConfiguration,
                strutStyle: strutStyle,
                helperPadding: helperPadding,
                helper: helper,
                helperTextStyle: helperTextStyle,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                textCapitalization: textCapitalization,
                textColor: textColor,
                textDirection: textDirection,
                textInputAction: textInputAction,
                textInputSize: textInputSize,
                textStyle: style,
                trailing: trailing,
                transitionCurve: transitionCurve,
                transitionDuration: transitionDuration,
              ),
            );
          },
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  FormFieldState<String> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController => _textFormField.controller ?? _controller!.value;

  MoonFormTextInput get _textFormField => super.widget as MoonFormTextInput;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

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

  @override
  void initState() {
    super.initState();
    if (_textFormField.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(MoonFormTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // setState will be called in the superclass, so even though state is being
    // manipulated, no setState call is needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
