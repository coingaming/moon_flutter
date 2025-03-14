import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/widgets/common/error_message_widgets.dart';

enum MoonInputGroupOrientation {
  vertical,
  horizontal,
}

typedef MoonInputGroupErrorBuilder = Widget Function(
  BuildContext context,
  List<String> errorText,
);

class MoonInputGroup extends StatefulWidget {
  /// Whether the input group is enabled. When false, taps are ignored and the
  /// opacity is reduced.
  final bool enabled;

  /// The border radius of the input group and its children.
  /// If not provided, both the input group and its children have a default
  /// border radius of 8.
  /// If custom [decoration] is used, border radius needs to be defined for the
  /// input group children to have the same rounded corners.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the input group.
  /// If [MoonInput.backgroundColor] is set, it takes precedence over this.
  final Color? backgroundColor;

  /// The default border color of the input group.
  final Color? borderColor;

  /// The color of the input group in error state.
  /// If [MoonInput.errorColor] is set, it takes precedence over this.
  final Color? errorColor;

  /// The text color of the input group's children hint.
  /// If [MoonInput.hintTextColor] is set, it takes precedence over this.
  final Color? hintColor;

  /// The hover effect color of the input group's children.
  /// If [MoonInput.hoverColor] is set, it takes precedence over this.
  final Color? hoverColor;

  /// The height of the input group. Only applied when [orientation] is
  /// [MoonInputGroupOrientation.horizontal].
  /// If null, default height of 56 is used.
  final double? height;

  /// The duration of the input group transition animation (enable and disable).
  final Duration? transitionDuration;

  /// The curve of the input group transition animation (enable and disable).
  final Curve? transitionCurve;

  /// The padding of the [helper] and [errorBuilder] widgets.
  final EdgeInsetsGeometry? helperPadding;

  /// The padding of the [label].
  final EdgeInsetsGeometry? labelPadding;

  /// The custom decoration of the input group.
  final Decoration? decoration;

  /// The list of [MoonInput]'s to display as the children of the input group.
  final List<MoonInput> children;

  /// The orientation of the input group.
  final MoonInputGroupOrientation orientation;

  /// A builder to build the input group error widget.
  final MoonInputGroupErrorBuilder? errorBuilder;

  /// The semantic label for the input group widget.
  final String? semanticLabel;

  /// The helper text to display below the input group area. Not displayed in error state.
  /// To customize the helper, use [helper].
  /// Mutually exclusive with [helper].
  final String? helperText;

  /// The text style of the [helper] or error state text of the input group.
  final TextStyle? helperErrorTextStyle;

  /// The widget to display below the input group. Not displayed in error state.
  final Widget? helper;

  /// The widget to display above the input group.
  /// If provided, the label is always displayed regardless of the input group state.
  /// If [MoonInput.label] is specified, it is displayed only when
  /// [MoonInput.hasFloatingLabel] is true.
  final Widget? label;

  /// The divider widget to display between the input group children.
  /// If not provided, default divider is used.
  final Widget? divider;

  /// Creates a Moon Design input group.
  const MoonInputGroup({
    super.key,
    required this.children,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.clipBehavior,
    this.decoration,
    this.divider,
    this.enabled = true,
    this.errorBuilder,
    this.errorColor,
    this.height,
    this.helper,
    this.helperPadding,
    this.helperText,
    this.helperErrorTextStyle,
    this.hoverColor,
    this.label,
    this.labelPadding,
    this.orientation = MoonInputGroupOrientation.vertical,
    this.hintColor,
    this.semanticLabel,
    this.transitionCurve,
    this.transitionDuration,
  }) : assert(
          helperText == null || helper == null,
          'Either helperText or helper can be provided, but not both.',
        );

  @override
  State<MoonInputGroup> createState() => _MoonInputGroupState();
}

class _MoonInputGroupState extends State<MoonInputGroup> {
  late final List<String?> _validatorErrors =
      List.filled(widget.children.length, null);

  late List<String?> _previousValidatorErrors;

  bool get _isVertical =>
      widget.orientation == MoonInputGroupOrientation.vertical;

  bool get _groupHasValidationError =>
      _validatorErrors.nonNulls.toList().isNotEmpty;

  bool get _groupHasErrorText =>
      widget.children.any((MoonInput child) => child.errorText != null);

  bool get _groupHasError => _groupHasValidationError || _groupHasErrorText;

  bool get _groupHasAllValidationErrors =>
      _validatorErrors.nonNulls.length == widget.children.length;

  bool get _groupHasAllErrorTexts =>
      widget.children.every((MoonInput child) => child.errorText != null);

  bool get _groupIsInErrorState =>
      _groupHasAllValidationErrors || _groupHasAllErrorTexts;

  bool get _hasAllInError =>
      (!_groupHasValidationError && _groupHasAllErrorTexts) ||
      _groupHasAllValidationErrors;

  bool get _shouldShowError => _groupHasError || _groupIsInErrorState;

  bool get _shouldShowHelper =>
      widget.helper != null || widget.helperText != null;

  void _handleValidationError(int index, String? errorText) {
    _previousValidatorErrors = _validatorErrors;

    if (_previousValidatorErrors[index] == errorText) return;

    _validatorErrors[index] = errorText;

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      // Rebuild the widget to show the error.
      if (mounted) setState(() {});
    });
  }

  MoonBorder _getBorder({required Color borderColor, double borderWidth = 1}) {
    final BorderRadiusGeometry effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(8);

    return MoonBorder(
      borderRadius: effectiveBorderRadius,
      side: BorderSide(color: borderColor, width: borderWidth),
    );
  }

  BorderRadius _getChildResolvedBorderRadius(
    BorderRadiusGeometry borderRadius,
    bool isFirstItem,
    bool isLastItem,
  ) {
    final TextDirection textDirection = Directionality.of(context);

    final bool isLTR = textDirection == TextDirection.ltr;

    final resolvedBorderRadius = borderRadius.resolve(textDirection);

    final double effectiveBorderWidth =
        widget.decoration == null ? MoonBorders.borders.defaultBorderWidth : 0;

    Radius getRadius(Radius radius) => Radius.circular(
          (radius.x - effectiveBorderWidth).clamp(0, double.infinity),
        );

    return BorderRadius.only(
      topLeft: getRadius(
        _isVertical || isLTR
            ? (isFirstItem ? resolvedBorderRadius.topLeft : Radius.zero)
            : (isLastItem ? resolvedBorderRadius.topLeft : Radius.zero),
      ),
      topRight: getRadius(
        _isVertical || isLTR
            ? ((isFirstItem && _isVertical) || (isLastItem && !_isVertical)
                ? resolvedBorderRadius.topRight
                : Radius.zero)
            : ((isFirstItem && !_isVertical) || (isLastItem && _isVertical)
                ? resolvedBorderRadius.topRight
                : Radius.zero),
      ),
      bottomLeft: getRadius(
        _isVertical || isLTR
            ? ((isFirstItem && !_isVertical) || (isLastItem && _isVertical)
                ? resolvedBorderRadius.bottomLeft
                : Radius.zero)
            : ((isLastItem && !_isVertical) || (isFirstItem && _isVertical)
                ? resolvedBorderRadius.bottomLeft
                : Radius.zero),
      ),
      bottomRight: getRadius(
        _isVertical || isLTR
            ? (isLastItem ? resolvedBorderRadius.bottomRight : Radius.zero)
            : (isFirstItem ? resolvedBorderRadius.bottomRight : Radius.zero),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius =
        widget.borderRadius ?? BorderRadiusDirectional.circular(8);

    final Color effectiveBackgroundColor =
        widget.backgroundColor ?? MoonColors.light.goku;

    final Color effectiveBorderColor =
        widget.borderColor ?? MoonColors.light.beerus;

    final Color effectiveErrorColor =
        widget.errorColor ?? MoonColors.light.chichi;

    final Color effectiveHelperTextColor =
        widget.helperErrorTextStyle?.color ?? MoonColors.light.trunks;

    final Color resolvedHelperErrorTextColor =
        _shouldShowError ? effectiveErrorColor : effectiveHelperTextColor;

    final Color effectiveTextColor = MoonColors.light.bulma;

    final double effectiveOpacity =
        widget.enabled ? 1 : MoonOpacities.opacities.disabled;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final EdgeInsetsGeometry effectiveHelperErrorPadding =
        widget.helperPadding ?? EdgeInsets.only(top: MoonSizes.sizes.x4s);

    final EdgeInsetsGeometry effectiveLabelPadding =
        widget.labelPadding ?? EdgeInsets.only(bottom: MoonSizes.sizes.x4s);

    final TextStyle effectiveHelperTextStyle = MoonTypography
        .typography.body.text12
        .merge(widget.helperErrorTextStyle);

    final TextStyle effectiveLabelTextStyle = MoonTypography
        .typography.body.text14
        .copyWith(color: effectiveTextColor);

    final TextStyle resolvedHelperErrorTextStyle =
        effectiveHelperTextStyle.copyWith(color: resolvedHelperErrorTextColor);

    List<Widget> childrenWithDivider() => List.generate(
          widget.children.length * 2 - 1,
          (int index) {
            final int derivedIndex = index ~/ 2;

            final MoonInput config = widget.children[derivedIndex];

            final bool selfShowError = ((config.errorText != null &&
                        _validatorErrors[derivedIndex] == null) &&
                    !_groupHasValidationError &&
                    !_groupHasAllErrorTexts) ||
                (_validatorErrors[derivedIndex] != null &&
                    !_groupHasAllValidationErrors);

            final bool isLastItem = derivedIndex == widget.children.length - 1;
            final bool isFirstItem = derivedIndex == 0;

            final BorderRadius resolvedBorderRadius =
                _getChildResolvedBorderRadius(
              effectiveBorderRadius,
              isFirstItem,
              isLastItem,
            );

            Widget child = MoonInput.form(
              activeBorderColor: config.activeBorderColor,
              autocorrect: config.autocorrect,
              autofillHints: config.autofillHints,
              autofocus: config.autofocus,
              autovalidateMode: config.autovalidateMode,
              backgroundColor: config.backgroundColor ?? Colors.transparent,
              borderRadius: config.borderRadius ?? resolvedBorderRadius,
              canRequestFocus: config.canRequestFocus,
              clipBehavior: config.clipBehavior,
              contentInsertionConfiguration:
                  config.contentInsertionConfiguration,
              contextMenuBuilder: config.contextMenuBuilder,
              controller: config.controller,
              cursorColor: config.cursorColor,
              cursorErrorColor: config.cursorErrorColor,
              cursorHeight: config.cursorHeight,
              cursorOpacityAnimates: config.cursorOpacityAnimates,
              cursorRadius: config.cursorRadius,
              cursorWidth: config.cursorWidth,
              decoration: config.decoration,
              dragStartBehavior: config.dragStartBehavior,
              enableIMEPersonalizedLearning:
                  config.enableIMEPersonalizedLearning,
              enableInteractiveSelection: config.enableInteractiveSelection,
              enableSuggestions: config.enableSuggestions,
              enabled: widget.enabled && config.enabled,
              errorBorderColor: selfShowError
                  ? config.errorBorderColor ?? effectiveErrorColor
                  : Colors.transparent,
              errorBuilder: (BuildContext _, String? __) =>
                  const SizedBox.shrink(),
              errorColor: config.errorColor ?? widget.errorColor,
              errorText: config.errorText,
              expands: config.expands,
              focusNode: config.focusNode,
              gap: config.gap,
              hasFloatingLabel: config.hasFloatingLabel,
              height: _isVertical ? config.height : widget.height,
              helper: config.helper,
              helperErrorPadding: config.helperErrorPadding ?? EdgeInsets.zero,
              helperErrorTextStyle:
                  config.helperErrorTextStyle ?? widget.helperErrorTextStyle,
              helperText: config.helperText,
              hintText: config.hintText,
              hintTextColor: config.hintTextColor ?? widget.hintColor,
              hoverColor: config.hoverColor ?? widget.hoverColor,
              inactiveBorderColor: Colors.transparent,
              initialValue: config.initialValue,
              textInputAction: config.textInputAction,
              inputFormatters: config.inputFormatters,
              inputSize: config.inputSize,
              keyboardAppearance: config.keyboardAppearance,
              keyboardType: config.keyboardType,
              label: config.hasFloatingLabel ? config.label : null,
              labelPadding: config.labelPadding,
              leading: config.leading,
              magnifierConfiguration: config.magnifierConfiguration,
              maxLength: config.maxLength,
              maxLengthEnforcement: config.maxLengthEnforcement,
              maxLines: config.maxLines,
              minLines: config.minLines,
              mouseCursor: config.mouseCursor,
              obscureText: config.obscureText,
              obscuringCharacter: config.obscuringCharacter,
              onAppPrivateCommand: config.onAppPrivateCommand,
              onChanged: config.onChanged,
              onEditingComplete: config.onEditingComplete,
              onSaved: config.onSaved,
              onSubmitted: config.onSubmitted,
              onTap: config.onTap,
              onTapAlwaysCalled: config.onTapAlwaysCalled,
              onTapOutside: config.onTapOutside,
              padding: config.padding,
              readOnly: config.readOnly,
              restorationId: config.restorationId,
              scribbleEnabled: config.scribbleEnabled,
              scrollController: config.scrollController,
              scrollPadding: config.scrollPadding,
              scrollPhysics: config.scrollPhysics,
              selectionControls: config.selectionControls,
              selectionHeightStyle: config.selectionHeightStyle,
              selectionWidthStyle: config.selectionWidthStyle,
              showCursor: config.showCursor,
              smartDashesType: config.smartDashesType,
              smartQuotesType: config.smartQuotesType,
              spellCheckConfiguration: config.spellCheckConfiguration,
              strutStyle: config.strutStyle,
              style: config.style,
              textAlign: config.textAlign,
              textAlignVertical: config.textAlignVertical,
              textCapitalization: config.textCapitalization,
              textColor: config.textColor,
              textDirection: config.textDirection,
              trailing: config.trailing,
              transitionCurve:
                  config.transitionCurve ?? effectiveTransitionCurve,
              transitionDuration:
                  config.transitionDuration ?? effectiveTransitionDuration,
              undoController: config.undoController,
              validationStatusCallback: (String? errorText) =>
                  _handleValidationError(derivedIndex, errorText),
              validator: config.validator,
              width: config.width,
            );

            child = config.width != null
                ? SizedBox(width: config.width, child: child)
                : Flexible(child: child);

            return index.isEven
                ? child
                : widget.divider ??
                    Box(
                      style: Style(
                        $box.chain
                          ..height(_isVertical ? 1 : double.infinity)
                          ..width(_isVertical ? double.infinity : 1),
                        $with.animatedShapeDecoration(
                          border: _getBorder(
                            borderColor: _hasAllInError
                                ? effectiveErrorColor
                                : effectiveBorderColor,
                          ),
                          duration: effectiveTransitionDuration,
                          curve: effectiveTransitionCurve,
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
        if (widget.label != null)
          SpecBuilder(
            style: Style(
              $with.defaultTextStyle.style.as(effectiveLabelTextStyle),
              $with.iconTheme.data.color(effectiveTextColor),
              $with.animatedOpacity(
                opacity: effectiveOpacity,
                duration: effectiveTransitionDuration,
                curve: effectiveTransitionCurve,
              ),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: effectiveLabelPadding,
                child: widget.label,
              );
            },
          ),
        MoonBaseInteractiveWidget(
          enabled: widget.enabled,
          semanticLabel: widget.semanticLabel,
          focusNode: FocusNode(skipTraversal: true),
          onTap: widget.enabled ? () {} : null,
          style: Style(
            widget.decoration != null ? null : $box.padding.all(1),
            widget.decoration != null && widget.clipBehavior != null
                ? $box.clipBehavior(widget.clipBehavior!)
                : null,
            widget.decoration != null
                ? decorationToAttribute(widget.decoration!)
                : $with.animatedShapeDecoration(
                    bgColor: effectiveBackgroundColor,
                    border: _getBorder(
                      borderColor: _hasAllInError
                          ? effectiveErrorColor
                          : effectiveBorderColor,
                    ),
                    duration: effectiveTransitionDuration,
                    curve: effectiveTransitionCurve,
                  ),
            $with.animatedOpacity(
              opacity: effectiveOpacity,
              duration: effectiveTransitionDuration,
              curve: effectiveTransitionCurve,
            ),
          ),
          child: _InputGroupOrientation(
            orientation: widget.orientation,
            height: widget.height,
            children: childrenWithDivider(),
          ),
        ),
        if (_shouldShowHelper || _shouldShowError)
          SpecBuilder(
            style: Style(
              $with.defaultTextStyle.style.as(resolvedHelperErrorTextStyle),
              $with.iconTheme.data.color(resolvedHelperErrorTextColor),
              $with.animatedOpacity(
                opacity: effectiveOpacity,
                duration: effectiveTransitionDuration,
                curve: effectiveTransitionCurve,
              ),
            ),
            builder: (BuildContext context) {
              final List<String> effectiveErrorMessages =
                  _validatorErrors.nonNulls.toList().isNotEmpty
                      ? _validatorErrors.nonNulls.toList()
                      : widget.children
                          .map((MoonInput child) => child.errorText)
                          .nonNulls
                          .toList();

              return Padding(
                padding: effectiveHelperErrorPadding,
                child: _shouldShowError
                    ? (widget.errorBuilder
                            ?.call(context, effectiveErrorMessages) ??
                        MoonErrorMessages(
                          errors: effectiveErrorMessages,
                          errorColor: effectiveErrorColor,
                        ))
                    : widget.helperText != null
                        ? MoonMessage(
                            text: widget.helperText!,
                            horizontalGap: MoonSizes.sizes.x5s,
                            icon: Icon(
                              HugeIcons.strokeRoundedInformationCircle,
                              size: 16,
                              color: effectiveHelperTextColor,
                            ),
                          )
                        : widget.helper,
              );
            },
          ),
      ],
    );
  }
}

class _InputGroupOrientation extends StatelessWidget {
  final double? height;
  final MoonInputGroupOrientation orientation;
  final List<Widget> children;

  const _InputGroupOrientation({
    this.height,
    required this.orientation,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return switch (orientation) {
      MoonInputGroupOrientation.vertical => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      MoonInputGroupOrientation.horizontal => SizedBox(
          height: height ?? 56,
          width: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
    };
  }
}
