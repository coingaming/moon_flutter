import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/colors.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_size_properties.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/linear_progress_indicator.dart';

enum MoonLinearLoaderSize {
  x6s,
  x5s,
  x4s,
  x3s,
  x2s,
}

class MoonLinearLoader extends StatelessWidget {
  /// Border radius of the linear loader widget.
  final BorderRadius? borderRadius;

  /// Color of the linear loader widget.
  final Color? color;

  /// Background color of the linear loader widget.
  final Color? backgroundColor;

  /// Height of the linear loader widget.
  final double? height;

  /// Size of the linear loader widget.
  final MoonLinearLoaderSize? linearLoaderSize;

  /// MDS linear loader widget.
  const MoonLinearLoader({
    super.key,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.height,
    this.linearLoaderSize,
  });

  MoonLinearLoaderSizeProperties _getMoonLoaderSize(BuildContext context, MoonLinearLoaderSize? moonLoaderSize) {
    switch (moonLoaderSize) {
      case MoonLinearLoaderSize.x6s:
        return context.moonTheme?.linearLoaderTheme.sizes.x6s ?? MoonLinearLoaderSizeProperties.x6s;
      case MoonLinearLoaderSize.x5s:
        return context.moonTheme?.linearLoaderTheme.sizes.x5s ?? MoonLinearLoaderSizeProperties.x5s;
      case MoonLinearLoaderSize.x4s:
        return context.moonTheme?.linearLoaderTheme.sizes.x4s ?? MoonLinearLoaderSizeProperties.x4s;
      case MoonLinearLoaderSize.x3s:
        return context.moonTheme?.linearLoaderTheme.sizes.x3s ?? MoonLinearLoaderSizeProperties.x3s;
      case MoonLinearLoaderSize.x2s:
        return context.moonTheme?.linearLoaderTheme.sizes.x2s ?? MoonLinearLoaderSizeProperties.x2s;

      default:
        return context.moonTheme?.linearLoaderTheme.sizes.x4s ?? MoonLinearLoaderSizeProperties.x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonLinearLoaderSizeProperties effectiveLoaderSize = _getMoonLoaderSize(context, linearLoaderSize);

    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveLoaderSize.borderRadius;

    final Color effectiveColor = color ?? context.moonTheme?.linearLoaderTheme.colors.color ?? MoonColors.light.hit;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearLoaderTheme.colors.backgroundColor ?? MoonColors.light.trunks;

    final double effectiveHeight = height ?? effectiveLoaderSize.loaderHeight;

    return MoonLinearProgressIndicator(
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
      borderRadius: effectiveBorderRadius,
      minHeight: effectiveHeight,
    );
  }
}
