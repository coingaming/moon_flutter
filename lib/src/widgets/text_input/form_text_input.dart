import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moon_design/src/widgets/text_input/text_input.dart';

export 'package:flutter/services.dart' show SmartDashesType, SmartQuotesType;

typedef MoonFormTextInputValidationStatusCallback = void Function(
  String? validationErrorText,
);

class MoonFormTextInput extends FormField<String> {
  final MoonFormTextInputConfiguration configuration;

  /// Creates a Moon Design [MoonFormTextInput] with a [MoonTextInput].
  ///
  /// If a [controller] is specified, [initialValue] must be null.
  /// If [controller] is null, a [TextEditingController] is automatically
  /// created with its `text` initialized to [initialValue] or an empty string.
  ///
  /// See [MoonTextInput] documentation for details on various parameters.
  ///
  /// Validator errors take precedence over the provided [errorText].
  MoonFormTextInput({
    super.key,
    // Moon Design system properties.
    bool hasFloatingLabel = false,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
    Color? errorColor,
    Color? errorBorderColor,
    Color? hoverBorderColor,
    Color? textColor,
    Color? hintTextColor,
    Decoration? decoration,
    double? gap,
    double? height,
    double? width,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? helperPadding,
    MoonFormTextInputValidationStatusCallback? validationStatusCallback,
    MoonTextInputSize? textInputSize,
    String? errorText,
    String? hintText,
    String? initialValue,
    TextStyle? helperTextStyle,
    MoonTextInputErrorBuilder? errorBuilder,
    Widget? leading,
    Widget? trailing,
    Widget? helper,

    // Flutter properties.
    this.controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    bool onTapAlwaysCalled = false,
    TapRegionCallback? onTapOutside,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    super.onSaved,
    super.validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    MouseCursor? mouseCursor,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        defaultContextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,

    // Flutter missing properties.
    AppPrivateCommandCallback? onAppPrivateCommand,
    bool canRequestFocus = true,
    bool scribbleEnabled = true,
    bool? cursorOpacityAnimates,
    Clip clipBehavior = Clip.hardEdge,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    UndoHistoryController? undoController,
  })  : assert(obscuringCharacter.length == 1),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "MinLines can not be greater than maxLines",
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          "MinLines and maxLines must be null when 'expands' is true.",
        ),
        assert(
          !obscureText || maxLines == 1,
          "Obscured fields cannot be multiline.",
        ),
        assert(
          maxLength == null ||
              maxLength == MoonTextInput.noMaxLength ||
              maxLength > 0,
        ),
        configuration = MoonFormTextInputConfiguration(
          activeBorderColor: activeBorderColor,
          autocorrect: autocorrect,
          autofillHints: autofillHints,
          autofocus: autofocus,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          canRequestFocus: canRequestFocus,
          clipBehavior: clipBehavior,
          contentInsertionConfiguration: contentInsertionConfiguration,
          contextMenuBuilder: contextMenuBuilder,
          controller: controller,
          cursorColor: cursorColor,
          cursorErrorColor: cursorErrorColor,
          cursorHeight: cursorHeight,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorRadius: cursorRadius,
          cursorWidth: cursorWidth,
          decoration: decoration,
          dragStartBehavior: dragStartBehavior,
          enabled: enabled ?? true,
          enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
          enableInteractiveSelection:
              enableInteractiveSelection ?? (!obscureText || !readOnly),
          enableSuggestions: enableSuggestions,
          errorBorderColor: errorBorderColor,
          errorBuilder: errorBuilder,
          errorColor: errorColor,
          errorText: errorText,
          expands: expands,
          focusNode: focusNode,
          gap: gap,
          hasFloatingLabel: hasFloatingLabel,
          height: height,
          helper: helper,
          helperPadding: helperPadding,
          helperTextStyle: helperTextStyle,
          hintText: hintText,
          hintTextColor: hintTextColor,
          hoverBorderColor: hoverBorderColor,
          inactiveBorderColor: inactiveBorderColor,
          initialValue: initialValue,
          inputFormatters: inputFormatters,
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
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validationStatusCallback: validationStatusCallback,
          onSaved: onSaved,
          onSubmitted: onSubmitted,
          onTap: onTap,
          onTapAlwaysCalled: onTapAlwaysCalled,
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
          smartDashesType: smartDashesType ??
              (obscureText
                  ? SmartDashesType.disabled
                  : SmartDashesType.enabled),
          smartQuotesType: smartQuotesType ??
              (obscureText
                  ? SmartQuotesType.disabled
                  : SmartQuotesType.enabled),
          spellCheckConfiguration: spellCheckConfiguration,
          strutStyle: strutStyle,
          style: style,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          textCapitalization: textCapitalization,
          textColor: textColor,
          textDirection: textDirection,
          textInputAction: textInputAction,
          textInputSize: textInputSize,
          trailing: trailing,
          transitionCurve: transitionCurve,
          transitionDuration: transitionDuration,
          undoController: undoController,
          validator: validator,
          width: width,
        ),
        super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ""),
          enabled: enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<String> field) {
            final _MoonFormTextInputState state =
                field as _MoonFormTextInputState;

            validationStatusCallback?.call(field.errorText);

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
                canRequestFocus: canRequestFocus,
                clipBehavior: clipBehavior,
                contentInsertionConfiguration: contentInsertionConfiguration,
                contextMenuBuilder: contextMenuBuilder,
                controller: state._effectiveController,
                cursorColor: cursorColor,
                cursorErrorColor: cursorErrorColor,
                cursorHeight: cursorHeight,
                cursorOpacityAnimates: cursorOpacityAnimates,
                cursorRadius: cursorRadius,
                cursorWidth: cursorWidth,
                decoration: decoration,
                dragStartBehavior: dragStartBehavior,
                enabled: enabled ?? true,
                enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
                enableInteractiveSelection:
                    enableInteractiveSelection ?? (!obscureText || !readOnly),
                enableSuggestions: enableSuggestions,
                errorBorderColor: errorBorderColor,
                errorBuilder: errorBuilder,
                errorColor: errorColor,
                errorText: field.errorText ?? errorText,
                expands: expands,
                focusNode: focusNode,
                gap: gap,
                hasFloatingLabel: hasFloatingLabel,
                height: height,
                helper: helper,
                helperPadding: helperPadding,
                helperTextStyle: helperTextStyle,
                hintText: hintText,
                hintTextColor: hintTextColor,
                hoverBorderColor: hoverBorderColor,
                inactiveBorderColor: inactiveBorderColor,
                initialValue: initialValue,
                inputFormatters: inputFormatters,
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
                onSubmitted: onSubmitted,
                onTap: onTap,
                onTapAlwaysCalled: onTapAlwaysCalled,
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
                smartDashesType: smartDashesType ??
                    (obscureText
                        ? SmartDashesType.disabled
                        : SmartDashesType.enabled),
                smartQuotesType: smartQuotesType ??
                    (obscureText
                        ? SmartQuotesType.disabled
                        : SmartQuotesType.enabled),
                spellCheckConfiguration: spellCheckConfiguration,
                strutStyle: strutStyle,
                style: style,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                textCapitalization: textCapitalization,
                textColor: textColor,
                textDirection: textDirection,
                textInputAction: textInputAction,
                textInputSize: textInputSize,
                trailing: trailing,
                transitionCurve: transitionCurve,
                transitionDuration: transitionDuration,
                undoController: undoController,
                width: width,
              ),
            );
          },
        );

  /// Controls the input text.
  ///
  /// If null, this widget will create its own [TextEditingController] and initialize its [TextEditingController.text]
  /// with [initialValue].
  final TextEditingController? controller;

  static Widget defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  FormFieldState<String> createState() => _MoonFormTextInputState();
}

class _MoonFormTextInputState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      _moonFormTextInput.controller ?? _controller!.value;

  MoonFormTextInput get _moonFormTextInput => super.widget as MoonFormTextInput;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Update the internal [FormFieldState] value to synchronize with the text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_moonFormTextInput.controller == null) {
      _createLocalController(
        widget.initialValue != null
            ? TextEditingValue(text: widget.initialValue!)
            : null,
      );
    } else {
      _moonFormTextInput.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(MoonFormTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_moonFormTextInput.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _moonFormTextInput.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null &&
          _moonFormTextInput.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_moonFormTextInput.controller != null) {
        setValue(_moonFormTextInput.controller!.text);
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
    _moonFormTextInput.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? "";
    }
  }

  @override
  void reset() {
    // SetState is handled in the superclass, no additional call needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes originating from within this class.
    // When a controller is provided, this change listener is registered. In such cases, we may receive notifications
    // for changes within this class (e.g., the reset() method), but the FormField value will already be set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

class MoonFormTextInputConfiguration {
  // Moon Design System properties.
  final bool hasFloatingLabel;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? activeBorderColor;
  final Color? errorBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorColor;
  final Color? hoverBorderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Decoration? decoration;
  final double? gap;
  final double? height;
  final double? width;
  final Duration? transitionDuration;
  final Curve? transitionCurve;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? helperPadding;
  final MoonFormTextInputValidationStatusCallback? validationStatusCallback;
  final MoonTextInputSize? textInputSize;
  final String? errorText;
  final String? hintText;
  final String? initialValue;
  final TextStyle? helperTextStyle;
  final MoonTextInputErrorBuilder? errorBuilder;
  final Widget? leading;
  final Widget? trailing;
  final Widget? helper;

  // Flutter properties.
  final TextMagnifierConfiguration? magnifierConfiguration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final bool onTapAlwaysCalled;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool scribbleEnabled;
  final bool enableIMEPersonalizedLearning;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool canRequestFocus;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;

  const MoonFormTextInputConfiguration({
    // Moon Design System properties.
    this.hasFloatingLabel = false,
    this.borderRadius,
    this.backgroundColor,
    this.activeBorderColor,
    this.errorBorderColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.hintTextColor,
    this.decoration,
    this.gap,
    this.height,
    this.width,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.helperPadding,
    this.validationStatusCallback,
    this.textInputSize,
    this.errorText,
    this.hintText,
    this.initialValue,
    this.helperTextStyle,
    this.errorBuilder,
    this.leading,
    this.trailing,
    this.helper,

    // Flutter properties.
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
    this.cursorErrorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
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
    this.contextMenuBuilder = MoonFormTextInput.defaultContextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
  })  : smartDashesType = smartDashesType ??
            (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ??
            (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        enableInteractiveSelection =
            enableInteractiveSelection ?? (!readOnly || !obscureText);
}
