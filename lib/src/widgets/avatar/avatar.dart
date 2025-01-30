import 'package:flutter/material.dart';

import 'package:mix/mix.dart';
import 'package:moon_core/moon_core.dart';

import 'package:moon_design/src/theme/avatar/avatar_size_properties.dart';
import 'package:moon_design/src/theme/avatar/avatar_sizes.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

import 'package:moon_tokens/moon_tokens.dart';

enum MoonAvatarSize {
  xs,
  sm,
  md,
  lg,
  xl,
  x2l,
}

class MoonAvatar extends StatelessWidget {
  /// Whether to show the avatar badge.
  final bool showBadge;

  /// The border radius of the avatar.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the avatar.
  final Color? backgroundColor;

  /// The color of the avatar badge.
  final Color? badgeColor;

  /// The margin value of the avatar badge.
  final double? badgeMarginValue;

  /// The size of the avatar badge.
  final double? badgeSize;

  /// The height of the avatar.
  final double? height;

  /// The width of the avatar.
  final double? width;

  /// The background image of the avatar.
  final ImageProvider<Object>? backgroundImage;

  /// The size of the avatar.
  final MoonAvatarSize? avatarSize;

  /// The alignment of the avatar badge.
  final MoonBadgeAlignment badgeAlignment;

  /// The semantic label for the avatar.
  final String? semanticLabel;

  /// The widget to display within the badge.
  final Widget? badgeContent;

  /// The widget to display within the avatar.
  final Widget? content;

  /// Creates a Moon Design avatar.
  const MoonAvatar({
    super.key,
    this.showBadge = false,
    this.borderRadius,
    this.backgroundColor,
    this.badgeColor,
    this.badgeMarginValue,
    this.badgeSize,
    this.height,
    this.width,
    this.backgroundImage,
    this.avatarSize,
    this.badgeAlignment = MoonBadgeAlignment.bottomRight,
    this.semanticLabel,
    this.badgeContent,
    this.content,
  });

  MoonAvatarSizeProperties _getMoonAvatarSize(
    BuildContext context,
    MoonAvatarSize? moonAvatarSize,
  ) {
    return switch (moonAvatarSize) {
      MoonAvatarSize.xs => MoonAvatarSizes(tokens: MoonTokens.light).xs,
      MoonAvatarSize.sm => MoonAvatarSizes(tokens: MoonTokens.light).sm,
      MoonAvatarSize.md => MoonAvatarSizes(tokens: MoonTokens.light).md,
      MoonAvatarSize.lg => MoonAvatarSizes(tokens: MoonTokens.light).lg,
      MoonAvatarSize.xl => MoonAvatarSizes(tokens: MoonTokens.light).xl,
      MoonAvatarSize.x2l => MoonAvatarSizes(tokens: MoonTokens.light).x2l,
      _ => MoonAvatarSizes(tokens: MoonTokens.light).md,
    };
  }

  @override
  Widget build(BuildContext context) {
    final MoonAvatarSizeProperties effectiveMoonAvatarSize =
        _getMoonAvatarSize(context, avatarSize);

    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? effectiveMoonAvatarSize.borderRadius;

    final resolvedBorderRadius =
        effectiveBorderRadius.resolve(Directionality.of(context));

    final Color effectiveBackgroundColor =
        backgroundColor ?? MoonColors.light.goku;

    final Color effectiveBadgeColor = badgeColor ?? MoonColors.light.roshi;

    final Color effectiveTextColor = MoonColors.light.textPrimary;

    final Color effectiveIconColor = MoonColors.light.iconPrimary;

    final double effectiveAvatarHeight =
        height ?? effectiveMoonAvatarSize.avatarSizeValue;

    final double effectiveAvatarWidth =
        width ?? effectiveMoonAvatarSize.avatarSizeValue;

    final double effectiveBadgeMarginValue =
        badgeMarginValue ?? effectiveMoonAvatarSize.badgeMarginValue;

    final double effectiveBadgeSize =
        badgeSize ?? effectiveMoonAvatarSize.badgeSizeValue;

    final TextStyle resolvedTextStyle =
        effectiveMoonAvatarSize.textStyle.copyWith(color: effectiveTextColor);

    final Style baseStyle = Style(
      $box.alignment.center(),
      $with.defaultTextStyle.style.as(resolvedTextStyle),
      $with.iconTheme.data.color(effectiveIconColor),
    );

    final Style badgeStyle = baseStyle.add(
      $box.shapeDecoration.as(
        ShapeDecorationWithPremultipliedAlpha(
          color: effectiveBadgeColor,
          shape: MoonBorder(
            borderRadius: BorderRadius.circular(effectiveBadgeSize / 2),
          ),
        ),
      ),
    );

    final Style contentStyle = baseStyle.add(
      $box.shapeDecoration.as(
        ShapeDecorationWithPremultipliedAlpha(
          color: effectiveBackgroundColor,
          shape: MoonBorder(borderRadius: resolvedBorderRadius),
          image: backgroundImage != null
              ? DecorationImage(image: backgroundImage!, fit: BoxFit.cover)
              : null,
        ),
      ),
    );

    return MoonRawAvatar(
      showBadge: showBadge,
      semanticLabel: semanticLabel,
      badgeSizeValue: effectiveBadgeSize,
      badgeMarginValue: effectiveBadgeMarginValue,
      badgeAlignment: badgeAlignment,
      avatarSize: Size(effectiveAvatarWidth, effectiveAvatarHeight),
      badge: Box(
        style: badgeStyle,
        child: badgeContent,
      ),
      content: Box(
        style: contentStyle,
        child: content,
      ),
    );
  }
}
