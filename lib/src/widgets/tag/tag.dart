import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/tag/tag_size_properties.dart';
import 'package:moon_design/src/theme/tag/tag_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

import 'package:moon_tokens/moon_tokens.dart';

enum MoonTagSize {
  x2s,
  xs,
  sm,
}

class MoonTag extends StatelessWidget {
  /// The border radius of the tag.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the tag.
  final Color? backgroundColor;

  /// The height of the tag.
  final double? height;

  /// The width of the tag.
  final double? width;

  /// The gap between the [leading], [label] and [trailing] widgets of the tag.
  final double? gap;

  /// The padding of the tag.
  final EdgeInsetsGeometry? padding;

  /// The size of the tag.
  final MoonTagSize? tagSize;

  /// The custom decoration of the tag.
  final Decoration? decoration;

  /// The semantic label for the tag.
  final String? semanticLabel;

  /// The callback that is called when the tag is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the tag is long-pressed.
  final VoidCallback? onLongPress;

  /// The widget to display before the [label] widget of the tag.
  final Widget? leading;

  /// The primary content of the tag widget.
  final Widget? label;

  /// The widget to display after the [label] widget of the tag.
  final Widget? trailing;

  /// Creates a Moon Design tag.
  const MoonTag({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.height,
    this.width,
    this.gap,
    this.padding,
    this.tagSize,
    this.decoration,
    this.semanticLabel,
    this.onTap,
    this.onLongPress,
    this.leading,
    this.label,
    this.trailing,
  });

  MoonTagSizeProperties _getMoonTagSize(
    BuildContext context,
    MoonTagSize? moonTagSize,
  ) =>
      switch (moonTagSize) {
        MoonTagSize.x2s => MoonTagSizes(tokens: MoonTokens.light).x2s,
        MoonTagSize.xs => MoonTagSizes(tokens: MoonTokens.light).xs,
        MoonTagSize.sm => MoonTagSizes(tokens: MoonTokens.light).sm,
        _ => MoonTagSizes(tokens: MoonTokens.light).xs,
      };

  @override
  Widget build(BuildContext context) {
    final MoonTagSizeProperties effectiveMoonTagSize =
        _getMoonTagSize(context, tagSize);

    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? effectiveMoonTagSize.borderRadius;

    final Color effectiveBackgroundColor =
        backgroundColor ?? MoonColors.light.goku;

    final Color effectiveTextColor = MoonColors.light.textPrimary;

    final Color effectiveIconColor = MoonColors.light.iconPrimary;

    final double effectiveHeight = height ?? effectiveMoonTagSize.height;

    final double effectiveGap = gap ?? effectiveMoonTagSize.gap;

    final EdgeInsetsGeometry effectivePadding =
        padding ?? effectiveMoonTagSize.padding;

    final TextStyle resolvedTextStyle =
        effectiveMoonTagSize.textStyle.copyWith(color: effectiveTextColor);

    final SystemMouseCursor effectiveMouseCursor =
        (onTap != null || onLongPress != null)
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic;

    final Style tagStyle = Style(
      $box.chain
        ..height(effectiveHeight)
        ..constraints(minWidth: effectiveHeight)
        ..padding.as(effectivePadding),
      width != null ? $box.width(width!) : null,
      decorationToAttribute(
        decoration ??
            ShapeDecorationWithPremultipliedAlpha(
              color: effectiveBackgroundColor,
              shape: MoonBorder(borderRadius: effectiveBorderRadius),
            ),
      ),
      $flex.chain
        ..gap(effectiveGap)
        ..mainAxisSize.min()
        ..mainAxisAlignment.center(),
      $with.defaultTextStyle.style.as(resolvedTextStyle),
      $with.iconTheme.data(
        color: effectiveIconColor,
        size: effectiveMoonTagSize.iconSizeValue,
      ),
    );

    return MoonBaseInteractiveWidget(
      semanticLabel: semanticLabel,
      mouseCursor: effectiveMouseCursor,
      focusNode: FocusNode(skipTraversal: true),
      onTap: onTap,
      onLongPress: onLongPress,
      child: HBox(
        style: tagStyle,
        children: [
          if (leading != null) leading!,
          if (label != null) label!,
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
