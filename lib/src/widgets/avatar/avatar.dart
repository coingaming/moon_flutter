import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_size_properties.dart';
import 'package:moon_design/src/theme/avatar/avatar_sizes.dart';
import 'package:moon_design/src/theme/colors/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/shape_decoration_premul.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/avatar/avatar_clipper.dart';

enum MoonAvatarSize {
  xs,
  sm,
  md,
  lg,
  xl,
  x2l,
}

enum MoonBadgeAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class MoonAvatar extends StatelessWidget {
  /// Whether to show the avatar badge or not.
  final bool showBadge;

  /// The border radius of the avatar.
  final BorderRadiusGeometry? borderRadius;

  /// The background color of the avatar.
  final Color? backgroundColor;

  /// The color of the avatar badge.
  final Color? badgeColor;

  /// The margin value of the avatars badge.
  final double? badgeMarginValue;

  /// The size of the avatars badge.
  final double? badgeSize;

  /// The width of the avatar.
  final double? height;

  /// The height of the avatar.
  final double? width;

  /// The background image of the avatar.
  final ImageProvider<Object>? backgroundImage;

  /// The size of the avatar.
  final MoonAvatarSize? avatarSize;

  /// The alignment of the avatar badge.
  final MoonBadgeAlignment badgeAlignment;

  /// The semantic label for the avatar.
  final String? semanticLabel;

  /// The content of the avatar.
  final Widget? content;

  /// MDS avatar widget.
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
    this.content,
  });

  Alignment _avatarAlignmentMapper(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    if (isRTL) {
      switch (badgeAlignment) {
        case MoonBadgeAlignment.topLeft:
          return Alignment.topRight;
        case MoonBadgeAlignment.topRight:
          return Alignment.topLeft;
        case MoonBadgeAlignment.bottomLeft:
          return Alignment.bottomRight;
        case MoonBadgeAlignment.bottomRight:
          return Alignment.bottomLeft;
        default:
          return Alignment.bottomRight;
      }
    } else {
      switch (badgeAlignment) {
        case MoonBadgeAlignment.topLeft:
          return Alignment.topLeft;
        case MoonBadgeAlignment.topRight:
          return Alignment.topRight;
        case MoonBadgeAlignment.bottomLeft:
          return Alignment.bottomLeft;
        case MoonBadgeAlignment.bottomRight:
          return Alignment.bottomRight;
        default:
          return Alignment.bottomRight;
      }
    }
  }

  MoonAvatarSizeProperties _getMoonAvatarSize(
      BuildContext context, MoonAvatarSize? moonAvatarSize) {
    switch (moonAvatarSize) {
      case MoonAvatarSize.xs:
        return context.moonTheme?.avatarTheme.sizes.xs ??
            MoonAvatarSizes(tokens: MoonTokens.light).xs;
      case MoonAvatarSize.sm:
        return context.moonTheme?.avatarTheme.sizes.sm ??
            MoonAvatarSizes(tokens: MoonTokens.light).sm;
      case MoonAvatarSize.md:
        return context.moonTheme?.avatarTheme.sizes.md ??
            MoonAvatarSizes(tokens: MoonTokens.light).md;
      case MoonAvatarSize.lg:
        return context.moonTheme?.avatarTheme.sizes.lg ??
            MoonAvatarSizes(tokens: MoonTokens.light).lg;
      case MoonAvatarSize.xl:
        return context.moonTheme?.avatarTheme.sizes.xl ??
            MoonAvatarSizes(tokens: MoonTokens.light).xl;
      case MoonAvatarSize.x2l:
        return context.moonTheme?.avatarTheme.sizes.x2l ??
            MoonAvatarSizes(tokens: MoonTokens.light).x2l;
      default:
        return context.moonTheme?.avatarTheme.sizes.md ??
            MoonAvatarSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonAvatarSizeProperties effectiveMoonAvatarSize =
        _getMoonAvatarSize(context, avatarSize);

    final BorderRadiusGeometry effectiveBorderRadius =
        borderRadius ?? effectiveMoonAvatarSize.borderRadius;

    final resolvedBorderRadius =
        effectiveBorderRadius.resolve(Directionality.of(context));

    final Color effectiveBackgroundColor = backgroundColor ??
        context.moonTheme?.avatarTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveBadgeColor = badgeColor ??
        context.moonTheme?.avatarTheme.colors.badgeColor ??
        MoonColors.light.roshi;

    final Color effectiveTextColor =
        context.moonTheme?.avatarTheme.colors.textColor ??
            MoonColors.light.textPrimary;

    final Color effectiveIconColor =
        context.moonTheme?.avatarTheme.colors.iconColor ??
            MoonColors.light.iconPrimary;

    final double effectiveAvatarHeight =
        height ?? effectiveMoonAvatarSize.avatarSizeValue;

    final double effectiveAvatarWidth =
        width ?? effectiveMoonAvatarSize.avatarSizeValue;

    final double effectiveBadgeMarginValue =
        badgeMarginValue ?? effectiveMoonAvatarSize.badgeMarginValue;

    final double effectiveBadgeSize =
        badgeSize ?? effectiveMoonAvatarSize.badgeSizeValue;

    return Semantics(
      label: semanticLabel,
      button: false,
      focusable: false,
      image: backgroundImage != null,
      child: SizedBox(
        width: effectiveAvatarWidth,
        height: effectiveAvatarHeight,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipPath(
                // TODO: Since clipper does not work properly on mobile web/PWA, we are disabling it. Remove this check
                // when it has been fixed from Flutter side.
                clipper: kIsWeb &&
                        MediaQueryData.fromView(View.of(context)).size.width <
                            500
                    ? null
                    : AvatarClipper(
                        showBadge: showBadge,
                        width: effectiveAvatarWidth,
                        height: effectiveAvatarHeight,
                        borderRadius: resolvedBorderRadius,
                        badgeSize: effectiveBadgeSize,
                        badgeMarginValue: effectiveBadgeMarginValue,
                        badgeAlignment: badgeAlignment,
                        textDirection: Directionality.of(context),
                      ),
                child: DefaultTextStyle(
                  style: effectiveMoonAvatarSize.textStyle
                      .copyWith(color: effectiveTextColor),
                  child: IconTheme(
                    data: IconThemeData(
                      color: effectiveIconColor,
                    ),
                    child: DecoratedBox(
                      decoration: ShapeDecorationWithPremultipliedAlpha(
                        color: effectiveBackgroundColor,
                        image: backgroundImage != null
                            ? DecorationImage(
                                image: backgroundImage!,
                                fit: BoxFit.cover,
                              )
                            : null,
                        shape: MoonSquircleBorder(
                          borderRadius: resolvedBorderRadius
                              .squircleBorderRadius(context),
                        ),
                      ),
                      child: Center(child: content),
                    ),
                  ),
                ),
              ),
            ),
            if (showBadge)
              Align(
                alignment: _avatarAlignmentMapper(context),
                child: Container(
                  height: effectiveBadgeSize,
                  width: effectiveBadgeSize,
                  decoration: BoxDecoration(
                    color: effectiveBadgeColor,
                    borderRadius: BorderRadius.circular(effectiveBadgeSize / 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
