import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/sizes.dart';
import 'package:moon_design/src/theme/theme.dart';

class MoonAlert extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;
  final double? gap;
  final EdgeInsets? padding;
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final Widget? content;

  const MoonAlert({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
    this.gap,
    this.padding,
    this.leading,
    required this.title,
    this.trailing,
    this.content,
  });

  Color _getTextColor(BuildContext context, {required Color effectiveBackgroundColor}) {
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
    final EdgeInsets effectivePadding =
        padding ?? context.moonTheme?.alertTheme.properties.padding ?? EdgeInsets.all(MoonSizes.sizes.x2s);

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.alertTheme.colors.backgroundColor ?? MoonColors.light.gohan;

    return Semantics(
      child: Container(padding: effectivePadding, color: effectiveBackgroundColor, height: 150, width: 150),
    );
  }
}
