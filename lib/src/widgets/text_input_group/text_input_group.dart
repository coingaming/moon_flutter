import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_design/src/widgets/common/border_container.dart';
import 'package:moon_design/src/widgets/common/error_message_widgets.dart';
import 'package:moon_design/src/widgets/text_input/form_text_input.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonTextInputGroupOrientation {
  vertical,
  horizontal,
}

typedef MoonTextInputGroupErrorBuilder = Widget Function(
  BuildContext context,
  List<String> errorText,
);

class MoonTextInputGroup extends StatefulWidget {
  /// Whether the text input group is enabled. When false, taps are ignored and
  /// the opacity reduced.
  final bool enabled;

  /// The border radius of the text input group.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the text input group.
  final Color? backgroundColor;

  /// The default border color of the text input group.
  final Color? borderColor;

  /// The color of the text input group in error state.
  final Color? errorColor;

  /// The text color of the text input group hint.
  final Color? hintTextColor;

  /// The border color of the text input group on hover.
  final Color? hoverBorderColor;

  /// The duration of the text input group transition animation
  /// (enable and disable).
  final Duration? transitionDuration;

  /// The curve of the text input group transition animation
  /// (enable and disable).
  final Curve? transitionCurve;

  /// The padding of the [helper] and [errorBuilder] widgets.
  final EdgeInsetsGeometry? helperPadding;

  /// The padding of the text content.
  final EdgeInsetsGeometry? textPadding;

  /// The custom decoration of the text input group.
  final Decoration? decoration;

  /// The semantic label for the text input group widget.
  final String? semanticLabel;

  /// The text style of the [helper] or error state text.
  final TextStyle? helperTextStyle;

  /// The orientation of the text input group.
  final MoonTextInputGroupOrientation orientation;

  /// The list of text inputs to display as the children of the text input group.
  final List<MoonFormTextInput> children;

  /// A builder to build the text input group error widget.
  final MoonTextInputGroupErrorBuilder? errorBuilder;

  /// The widget to display below the text input group. Not displayed in error
  /// state.
  final Widget? helper;

  /// Creates a Moon Design text input group.
  const MoonTextInputGroup({
    super.key,
    this.enabled = true,
    this.borderRadius,
    this.clipBehavior,
    this.backgroundColor,
    this.borderColor,
    this.errorColor,
    this.hintTextColor,
    this.hoverBorderColor,
    this.transitionDuration,
    this.transitionCurve,
    this.helperPadding,
    this.textPadding,
    this.decoration,
    this.semanticLabel,
    this.helperTextStyle,
    this.orientation = MoonTextInputGroupOrientation.vertical,
    required this.children,
    this.errorBuilder,
    this.helper,
  });

  @override
  State<MoonTextInputGroup> createState() => _MoonTextInputGroupState();
}

class _MoonTextInputGroupState extends State<MoonTextInputGroup> {
  late final List<String?> _validatorErrors =
      List.filled(widget.children.length, null);

  late List<String?> _previousValidatorErrors;

  bool get _groupHasValidationError =>
      _validatorErrors.nonNulls.toList().isNotEmpty;

  bool get _groupHasErrorText => widget.children
      .any((MoonFormTextInput child) => child.configuration.errorText != null);

  bool get _groupHasError => _groupHasValidationError || _groupHasErrorText;

  bool get _groupHasAllValidationErrors =>
      _validatorErrors.nonNulls.length == widget.children.length;

  bool get _groupHasAllErrorTexts => widget.children.every(
        (MoonFormTextInput child) => child.configuration.errorText != null,
      );

  bool get _groupIsInErrorState =>
      _groupHasAllValidationErrors || _groupHasAllErrorTexts;

  bool get _shouldShowError => _groupHasError || _groupIsInErrorState;

  void _handleValidationError(int index, String? errorText) {
    _previousValidatorErrors = _validatorErrors;

    if (_previousValidatorErrors[index] == errorText) return;

    _validatorErrors[index] = errorText;

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      // Rebuild the widget to show the error.
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.textInputGroupTheme.properties.borderRadius ??
        BorderRadius.circular(8);

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.textInputGroupTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveBorderColor = widget.borderColor ??
        context.moonTheme?.textInputGroupTheme.colors.borderColor ??
        MoonColors.light.beerus;

    final Color effectiveErrorColor = widget.errorColor ??
        context.moonTheme?.textInputGroupTheme.colors.errorColor ??
        MoonColors.light.chichi;

    final Color effectiveHelperTextColor = widget.hintTextColor ??
        context.moonTheme?.textInputGroupTheme.colors.helperTextColor ??
        MoonColors.light.trunks;

    final EdgeInsetsGeometry effectiveHelperPadding = widget.helperPadding ??
        context.moonTheme?.textInputGroupTheme.properties.helperPadding ??
        EdgeInsets.only(
          left: MoonSizes.sizes.x3s,
          top: MoonSizes.sizes.x4s,
          right: MoonSizes.sizes.x3s,
        );

    final TextStyle effectiveHelperTextStyle = widget.helperTextStyle ??
        context.moonTheme?.textInputGroupTheme.properties.helperTextStyle ??
        MoonTypography.typography.body.text12;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.textInputGroupTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.textInputGroupTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final List<String> effectiveErrorMessages =
        _validatorErrors.nonNulls.toList().isNotEmpty
            ? _validatorErrors.nonNulls.toList()
            : widget.children
                .map((MoonFormTextInput child) => child.configuration.errorText)
                .nonNulls
                .toList();

    List<Widget> childrenWithDivider({required bool shouldHideDivider}) =>
        List.generate(
          widget.children.length * 2 - 1,
          (int index) {
            final int derivedIndex = index ~/ 2;

            final MoonFormTextInputConfiguration configuration =
                widget.children[derivedIndex].configuration;

            final bool selfShowError = ((configuration.errorText != null &&
                        _validatorErrors[derivedIndex] == null) &&
                    !_groupHasValidationError &&
                    !_groupHasAllErrorTexts) ||
                (_validatorErrors[derivedIndex] != null &&
                    !_groupHasAllValidationErrors);

            Widget child = MoonFormTextInput(
              activeBorderColor: configuration.activeBorderColor,
              autocorrect: configuration.autocorrect,
              autofillHints: configuration.autofillHints,
              autofocus: configuration.autofocus,
              autovalidateMode: configuration.autovalidateMode,
              backgroundColor: Colors.transparent,
              borderRadius: configuration.borderRadius,
              canRequestFocus: configuration.canRequestFocus,
              clipBehavior: configuration.clipBehavior,
              contentInsertionConfiguration:
                  configuration.contentInsertionConfiguration,
              contextMenuBuilder: configuration.contextMenuBuilder,
              controller: configuration.controller,
              cursorColor: configuration.cursorColor,
              cursorHeight: configuration.cursorHeight,
              cursorOpacityAnimates: configuration.cursorOpacityAnimates,
              cursorRadius: configuration.cursorRadius,
              cursorWidth: configuration.cursorWidth,
              decoration: configuration.decoration,
              dragStartBehavior: configuration.dragStartBehavior,
              enabled: configuration.enabled,
              enableIMEPersonalizedLearning:
                  configuration.enableIMEPersonalizedLearning,
              enableInteractiveSelection:
                  configuration.enableInteractiveSelection,
              enableSuggestions: configuration.enableSuggestions,
              errorBorderColor:
                  selfShowError ? configuration.errorColor : Colors.transparent,
              errorBuilder: (BuildContext context, String? errorText) =>
                  const SizedBox.shrink(),
              errorColor: configuration.errorColor,
              errorText: configuration.errorText,
              expands: configuration.expands,
              focusNode: configuration.focusNode,
              gap: configuration.gap,
              hasFloatingLabel: configuration.hasFloatingLabel,
              height: configuration.height,
              helper: configuration.helper,
              helperPadding: configuration.helperPadding,
              helperTextStyle: configuration.helperTextStyle,
              hintText: configuration.hintText,
              hintTextColor: configuration.hintTextColor,
              hoverBorderColor: configuration.hoverBorderColor,
              inactiveBorderColor: Colors.transparent,
              initialValue: configuration.initialValue,
              inputFormatters: configuration.inputFormatters,
              keyboardAppearance: configuration.keyboardAppearance,
              keyboardType: configuration.keyboardType,
              leading: configuration.leading,
              magnifierConfiguration: configuration.magnifierConfiguration,
              maxLength: configuration.maxLength,
              maxLengthEnforcement: configuration.maxLengthEnforcement,
              maxLines: configuration.maxLines,
              minLines: configuration.minLines,
              mouseCursor: configuration.mouseCursor,
              obscureText: configuration.obscureText,
              obscuringCharacter: configuration.obscuringCharacter,
              onAppPrivateCommand: configuration.onAppPrivateCommand,
              onChanged: configuration.onChanged,
              onEditingComplete: configuration.onEditingComplete,
              onSubmitted: configuration.onSubmitted,
              onSaved: configuration.onSaved,
              onTap: configuration.onTap,
              onTapOutside: configuration.onTapOutside,
              padding: configuration.padding,
              readOnly: configuration.readOnly,
              restorationId: configuration.restorationId,
              scribbleEnabled: configuration.scribbleEnabled,
              scrollController: configuration.scrollController,
              scrollPadding: configuration.scrollPadding,
              scrollPhysics: configuration.scrollPhysics,
              selectionControls: configuration.selectionControls,
              selectionHeightStyle: configuration.selectionHeightStyle,
              selectionWidthStyle: configuration.selectionWidthStyle,
              showCursor: configuration.showCursor,
              smartDashesType: configuration.smartDashesType,
              smartQuotesType: configuration.smartQuotesType,
              spellCheckConfiguration: configuration.spellCheckConfiguration,
              strutStyle: configuration.strutStyle,
              style: configuration.style,
              textAlign: configuration.textAlign,
              textAlignVertical: configuration.textAlignVertical,
              textCapitalization: configuration.textCapitalization,
              textColor: configuration.textColor,
              textDirection: configuration.textDirection,
              textInputAction: configuration.textInputAction,
              textInputSize: configuration.textInputSize,
              trailing: configuration.trailing,
              transitionCurve: configuration.transitionCurve,
              transitionDuration: configuration.transitionDuration,
              undoController: configuration.undoController,
              validationStatusCallback: (errorText) =>
                  _handleValidationError(derivedIndex, errorText),
              validator: configuration.validator,
              width: configuration.width,
            );

            child = configuration.width != null
                ? SizedBox(
                    width: configuration.width,
                    child: child,
                  )
                : Flexible(child: child);

            return index.isEven
                ? child
                // Animated divider
                : BorderContainer(
                    height: widget.orientation ==
                            MoonTextInputGroupOrientation.horizontal
                        ? double.infinity
                        : 1,
                    width: widget.orientation ==
                            MoonTextInputGroupOrientation.vertical
                        ? double.infinity
                        : 1,
                    duration: effectiveTransitionDuration,
                    curve: effectiveTransitionCurve,
                    border: MoonSquircleBorder(
                      borderRadius:
                          effectiveBorderRadius.squircleBorderRadius(context),
                      side: BorderSide(
                        color: (!_groupHasValidationError &&
                                    _groupHasAllErrorTexts) ||
                                _groupHasAllValidationErrors
                            ? effectiveErrorColor
                            : shouldHideDivider ||
                                    (_groupHasError || _groupHasValidationError)
                                ? Colors.transparent
                                : effectiveBorderColor,
                      ),
                    ),
                    child: const SizedBox.shrink(),
                  );
          },
          growable: false,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MoonBaseControl(
          semanticLabel: widget.semanticLabel,
          isFocusable: false,
          showFocusEffect: false,
          onTap: widget.enabled ? () {} : null,
          propagateGesturesToChild: true,
          builder: (
            BuildContext context,
            bool isEnabled,
            bool isHovered,
            bool isFocused,
            bool isPressed,
          ) {
            return BorderContainer(
              clipBehavior: widget.clipBehavior ?? Clip.none,
              backgroundColor: effectiveBackgroundColor,
              decoration: widget.decoration,
              duration: effectiveTransitionDuration,
              curve: effectiveTransitionCurve,
              border: MoonSquircleBorder(
                borderRadius:
                    effectiveBorderRadius.squircleBorderRadius(context),
                side: BorderSide(
                  color:
                      (!_groupHasValidationError && _groupHasAllErrorTexts) ||
                              _groupHasAllValidationErrors
                          ? effectiveErrorColor
                          : effectiveBorderColor,
                ),
              ),
              child: _InputGroupOrientation(
                orientation: widget.orientation,
                children: childrenWithDivider(
                  shouldHideDivider: isHovered || isFocused,
                ),
              ),
            );
          },
        ),
        if (widget.helper != null || _shouldShowError)
          IconTheme(
            data: IconThemeData(
              color: _shouldShowError
                  ? effectiveErrorColor
                  : effectiveHelperTextColor,
            ),
            child: DefaultTextStyle(
              style: effectiveHelperTextStyle.copyWith(
                color: _shouldShowError
                    ? effectiveErrorColor
                    : effectiveHelperTextColor,
              ),
              child: Padding(
                padding: effectiveHelperPadding,
                child: _shouldShowError
                    ? (widget.errorBuilder
                            ?.call(context, effectiveErrorMessages) ??
                        MoonErrorMessages(errors: effectiveErrorMessages))
                    : widget.helper,
              ),
            ),
          ),
      ],
    );
  }
}

class _InputGroupOrientation extends StatelessWidget {
  final MoonTextInputGroupOrientation orientation;
  final List<Widget> children;

  const _InputGroupOrientation({
    required this.orientation,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return switch (orientation) {
      MoonTextInputGroupOrientation.vertical => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      MoonTextInputGroupOrientation.horizontal => SizedBox(
          height: 56,
          width: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
    };
  }
}
