import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/avatar/avatar_size_properties.dart';
import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';
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
  final BorderRadius? borderRadius;

  /// The background color of the avatar.
  final Color? backgroundColor;

  /// The color of the avatar badge.
  final Color? badgeColor;

  /// The text color of the avatar.
  final Color? textColor;

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
    this.textColor,
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
    final isRTL = Directionality.of(context) == TextDirection.rtl;
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

  MoonAvatarSizeProperties _getMoonAvatarSize(BuildContext context, MoonAvatarSize? moonAvatarSize) {
    switch (moonAvatarSize) {
      case MoonAvatarSize.xs:
        return context.moonTheme?.avatarTheme.sizes.xs ?? MoonAvatarSizeProperties.xs;
      case MoonAvatarSize.sm:
        return context.moonTheme?.avatarTheme.sizes.sm ?? MoonAvatarSizeProperties.sm;
      case MoonAvatarSize.md:
        return context.moonTheme?.avatarTheme.sizes.md ?? MoonAvatarSizeProperties.md;
      case MoonAvatarSize.lg:
        return context.moonTheme?.avatarTheme.sizes.lg ?? MoonAvatarSizeProperties.lg;
      case MoonAvatarSize.xl:
        return context.moonTheme?.avatarTheme.sizes.xl ?? MoonAvatarSizeProperties.xl;
      case MoonAvatarSize.x2l:
        return context.moonTheme?.avatarTheme.sizes.x2l ?? MoonAvatarSizeProperties.x2l;
      default:
        return context.moonTheme?.avatarTheme.sizes.md ?? MoonAvatarSizeProperties.md;
    }
  }

  Color _getTextColor(BuildContext context, {required bool isDarkMode, required Color effectiveBackgroundColor}) {
    if (backgroundColor == null && context.moonTypography != null) {
      return context.moonTypography!.colors.bodyPrimary;
    }

    final backgroundLuminance = effectiveBackgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonAvatarSizeProperties effectiveMoonAvatarSize = _getMoonAvatarSize(context, avatarSize);

    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveMoonAvatarSize.borderRadius;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.avatarTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    final Color effectiveBadgeColor =
        badgeColor ?? context.moonTheme?.avatarTheme.colors.badgeColor ?? MoonColors.light.roshi100;

    final Color effectiveTextColor = textColor ??
        _getTextColor(context, isDarkMode: context.isDarkMode, effectiveBackgroundColor: effectiveBackgroundColor);

    final double effectiveAvatarHeight = height ?? effectiveMoonAvatarSize.avatarSizeValue;

    final double effectiveAvatarWidth = width ?? effectiveMoonAvatarSize.avatarSizeValue;

    final double effectiveBadgeMarginValue = badgeMarginValue ?? effectiveMoonAvatarSize.badgeMarginValue;

    final double effectiveBadgeSize = badgeSize ?? effectiveMoonAvatarSize.badgeSizeValue;

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
                clipper: kIsWeb && MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width < 500
                    ? null
                    : AvatarClipper(
                        showBadge: showBadge,
                        width: effectiveAvatarWidth,
                        height: effectiveAvatarHeight,
                        borderRadius: effectiveBorderRadius,
                        badgeSize: effectiveBadgeSize,
                        badgeMarginValue: effectiveBadgeMarginValue,
                        badgeAlignment: badgeAlignment,
                        textDirection: Directionality.of(context),
                      ),
                child: DefaultTextStyle.merge(
                  style: effectiveMoonAvatarSize.textStyle.copyWith(color: effectiveTextColor),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: effectiveBorderRadius,
                      color: effectiveBackgroundColor,
                      image: backgroundImage != null
                          ? DecorationImage(
                              image: backgroundImage!,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Center(child: content),
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
              )
          ],
        ),
      ),
    );
  }
}
