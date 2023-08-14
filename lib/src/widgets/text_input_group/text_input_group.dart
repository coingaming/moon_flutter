import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/colors.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_design/src/widgets/text_input/form_text_input.dart';
import 'package:moon_design/src/widgets/text_input/text_input.dart';

typedef MoonTextInputGroupErrorBuilder = Widget Function(BuildContext context, String? errorText);

class MoonTextInputGroup extends StatefulWidget {
  /// If false the widget is "disabled": it ignores taps and has a reduced opacity.
  final bool enabled;

  /// The border radius of the text input group.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the text input group.
  final Color? backgroundColor;

  /// The border color of the inactive text input group.
  final Color? inactiveBorderColor;

  /// The border color of the error text input group.
  final Color? errorColor;

  /// The border color of the hovered text input group.
  final Color? hoverBorderColor;

  /// The text color of the text input group.
  final Color? textColor;

  /// The transition duration for disable animation.
  final Duration? transitionDuration;

  /// The transition curve for disable animation.
  final Curve? transitionCurve;

  /// The padding around helper widget or error builder.
  final EdgeInsetsGeometry? helperPadding;

  /// The padding around the text content.
  final EdgeInsetsGeometry? textPadding;

  /// Custom decoration for the text input group.
  final Decoration? decoration;

  /// The semantic label for the widget.
  final String? semanticLabel;

  /// The text style to use for the helper or error state text.
  final TextStyle? helperTextStyle;

  /// The children of the text input group.
  final List<MoonFormTextInput> children;

  /// Builder for the error widget.
  final MoonTextInputGroupErrorBuilder? errorBuilder;

  /// MDS TextArea widget
  const MoonTextInputGroup({
    super.key,
    this.enabled = true,
    this.borderRadius,
    this.clipBehavior,
    this.backgroundColor,
    this.inactiveBorderColor,
    this.errorColor,
    this.hoverBorderColor,
    this.textColor,
    this.transitionDuration,
    this.transitionCurve,
    this.helperPadding,
    this.textPadding,
    this.decoration,
    this.semanticLabel,
    this.helperTextStyle,
    required this.children,
    this.errorBuilder,
  });

  @override
  State<MoonTextInputGroup> createState() => _MoonTextInputGroupState();
}

class _MoonTextInputGroupState extends State<MoonTextInputGroup> {
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _textControllers = widget.children.map((child) => child.controller ?? TextEditingController()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.textInputGroupTheme.properties.borderRadius ??
        BorderRadius.circular(8);

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.textInputGroupTheme.colors.backgroundColor ??
        MoonColors.light.gohan;

    final Color effectiveInactiveBorderColor = widget.inactiveBorderColor ??
        context.moonTheme?.textInputGroupTheme.colors.inactiveBorderColor ??
        MoonColors.light.beerus;

    final Color effectiveErrorColor =
        widget.errorColor ?? context.moonTheme?.textInputGroupTheme.colors.errorColor ?? MoonColors.light.chiChi100;

    final Color effectiveTextColor =
        widget.textColor ?? context.moonColors?.textPrimary ?? MoonColors.light.textPrimary;

    final EdgeInsetsGeometry effectiveHelperPadding = widget.helperPadding ??
        context.moonTheme?.textInputGroupTheme.properties.helperPadding ??
        EdgeInsets.symmetric(horizontal: MoonSizes.sizes.x3s, vertical: MoonSizes.sizes.x4s);

    final TextStyle effectiveHelperTextStyle = widget.helperTextStyle ??
        context.moonTheme?.textInputGroupTheme.properties.helperTextStyle ??
        MoonTypography.typography.body.text12;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.textInputGroupTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.textInputGroupTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    List<Widget> childrenWithDivider({required bool shouldHideDivider}) => List.generate(
          widget.children.length * 2 - 1,
          (int index) {
            final int derivedIndex = index ~/ 2;

            final MoonFormTextInput child = MoonFormTextInput(
              activeBorderColor: widget.children[derivedIndex].activeBorderColor,
              autocorrect: widget.children[derivedIndex].autocorrect,
              autofillHints: widget.children[derivedIndex].autofillHints,
              autofocus: widget.children[derivedIndex].autofocus,
              backgroundColor: Colors.transparent,
              borderRadius: widget.children[derivedIndex].borderRadius,
              canRequestFocus: widget.children[derivedIndex].canRequestFocus,
              clipBehavior: widget.children[derivedIndex].clipBehavior,
              contentInsertionConfiguration: widget.children[derivedIndex].contentInsertionConfiguration,
              contextMenuBuilder: widget.children[derivedIndex].contextMenuBuilder,
              controller: _textControllers[derivedIndex],
              cursorColor: widget.children[derivedIndex].cursorColor,
              cursorHeight: widget.children[derivedIndex].cursorHeight,
              cursorOpacityAnimates: widget.children[derivedIndex].cursorOpacityAnimates,
              cursorRadius: widget.children[derivedIndex].cursorRadius,
              cursorWidth: widget.children[derivedIndex].cursorWidth,
              decoration: widget.children[derivedIndex].decoration,
              dragStartBehavior: widget.children[derivedIndex].dragStartBehavior,
              enabled: widget.children[derivedIndex].enabled,
              enableIMEPersonalizedLearning: widget.children[derivedIndex].enableIMEPersonalizedLearning,
              enableInteractiveSelection: widget.children[derivedIndex].enableInteractiveSelection,
              enableSuggestions: widget.children[derivedIndex].enableSuggestions,
              errorBuilder: widget.children[derivedIndex].errorBuilder,
              errorColor: widget.children[derivedIndex].errorColor,
              expands: widget.children[derivedIndex].expands,
              focusNode: widget.children[derivedIndex].focusNode,
              gap: widget.children[derivedIndex].gap,
              hasFloatingLabel: widget.children[derivedIndex].hasFloatingLabel,
              height: widget.children[derivedIndex].height,
              helper: widget.children[derivedIndex].helper,
              helperPadding: widget.children[derivedIndex].helperPadding,
              helperTextStyle: widget.children[derivedIndex].helperTextStyle,
              hintText: widget.children[derivedIndex].hintText,
              hintTextColor: widget.children[derivedIndex].hintTextColor,
              hoverBorderColor: widget.children[derivedIndex].hoverBorderColor,
              inactiveBorderColor: Colors.transparent,
              initialValue: widget.children[derivedIndex].initialValue,
              inputFormatters: widget.children[derivedIndex].inputFormatters,
              keyboardAppearance: widget.children[derivedIndex].keyboardAppearance,
              keyboardType: widget.children[derivedIndex].keyboardType,
              leading: widget.children[derivedIndex].leading,
              magnifierConfiguration: widget.children[derivedIndex].magnifierConfiguration,
              maxLength: widget.children[derivedIndex].maxLength,
              maxLengthEnforcement: widget.children[derivedIndex].maxLengthEnforcement,
              maxLines: widget.children[derivedIndex].maxLines,
              minLines: widget.children[derivedIndex].minLines,
              mouseCursor: widget.children[derivedIndex].mouseCursor,
              obscureText: widget.children[derivedIndex].obscureText,
              obscuringCharacter: widget.children[derivedIndex].obscuringCharacter,
              onAppPrivateCommand: widget.children[derivedIndex].onAppPrivateCommand,
              onChanged: widget.children[derivedIndex].onChanged,
              onEditingComplete: widget.children[derivedIndex].onEditingComplete,
              onSubmitted: widget.children[derivedIndex].onSubmitted,
              onTap: widget.children[derivedIndex].onTap,
              onTapOutside: widget.children[derivedIndex].onTapOutside,
              padding: widget.children[derivedIndex].padding,
              readOnly: widget.children[derivedIndex].readOnly,
              restorationId: widget.children[derivedIndex].restorationId,
              scribbleEnabled: widget.children[derivedIndex].scribbleEnabled,
              scrollController: widget.children[derivedIndex].scrollController,
              scrollPadding: widget.children[derivedIndex].scrollPadding,
              scrollPhysics: widget.children[derivedIndex].scrollPhysics,
              selectionControls: widget.children[derivedIndex].selectionControls,
              selectionHeightStyle: widget.children[derivedIndex].selectionHeightStyle,
              selectionWidthStyle: widget.children[derivedIndex].selectionWidthStyle,
              showCursor: widget.children[derivedIndex].showCursor,
              smartDashesType: widget.children[derivedIndex].smartDashesType,
              smartQuotesType: widget.children[derivedIndex].smartQuotesType,
              spellCheckConfiguration: widget.children[derivedIndex].spellCheckConfiguration,
              strutStyle: widget.children[derivedIndex].strutStyle,
              style: widget.children[derivedIndex].style,
              textAlign: widget.children[derivedIndex].textAlign,
              textAlignVertical: widget.children[derivedIndex].textAlignVertical,
              textCapitalization: widget.children[derivedIndex].textCapitalization,
              textColor: widget.children[derivedIndex].textColor,
              textDirection: widget.children[derivedIndex].textDirection,
              textInputAction: widget.children[derivedIndex].textInputAction,
              textInputSize: widget.children[derivedIndex].textInputSize,
              trailing: widget.children[derivedIndex].trailing,
              transitionCurve: widget.children[derivedIndex].transitionCurve,
              transitionDuration: widget.children[derivedIndex].transitionDuration,
              undoController: widget.children[derivedIndex].undoController,
            );

            return index.isEven
                ? child
                : Divider(
                    height: 1,
                    color: shouldHideDivider ? Colors.transparent : effectiveInactiveBorderColor,
                  );
          },
        );

    return MoonBaseControl(
      semanticLabel: widget.semanticLabel,
      isFocusable: false,
      showFocusEffect: false,
      showScaleEffect: false,
      onTap: widget.enabled ? () {} : null,
      builder: (BuildContext context, bool isEnabled, bool isHovered, bool isFocused, bool isPressed) {
        return Container(
          clipBehavior: widget.clipBehavior ?? Clip.none,
          decoration: widget.decoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: effectiveBackgroundColor,
                shape: MoonSquircleBorder(
                  borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                  side: BorderSide(color: effectiveInactiveBorderColor),
                ),
              ),
          child: Column(
            children: childrenWithDivider(shouldHideDivider: isHovered || isFocused),
          ),
        );
      },
    );
  }
}
