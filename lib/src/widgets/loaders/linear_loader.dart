import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_size_properties.dart';
import 'package:moon_design/src/theme/loaders/linear_loader/linear_loader_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';
import 'package:moon_design/src/widgets/common/progress_indicators/linear_progress_indicator.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonLinearLoaderSize {
  x6s,
  x5s,
  x4s,
  x3s,
  x2s,
}

class MoonLinearLoader extends StatelessWidget {
  /// The border radius of the linear loader.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the linear loader.
  final Color? color;

  /// The background color of the linear loader.
  final Color? backgroundColor;

  /// The height of the linear loader.
  final double? height;

  /// The size of the linear loader.
  final MoonLinearLoaderSize? linearLoaderSize;

  /// Creates a Moon Design linear loader.
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
        return context.moonTheme?.linearLoaderTheme.sizes.x6s ?? MoonLinearLoaderSizes(tokens: MoonTokens.light).x6s;
      case MoonLinearLoaderSize.x5s:
        return context.moonTheme?.linearLoaderTheme.sizes.x5s ?? MoonLinearLoaderSizes(tokens: MoonTokens.light).x5s;
      case MoonLinearLoaderSize.x4s:
        return context.moonTheme?.linearLoaderTheme.sizes.x4s ?? MoonLinearLoaderSizes(tokens: MoonTokens.light).x4s;
      case MoonLinearLoaderSize.x3s:
        return context.moonTheme?.linearLoaderTheme.sizes.x3s ?? MoonLinearLoaderSizes(tokens: MoonTokens.light).x3s;
      case MoonLinearLoaderSize.x2s:
        return context.moonTheme?.linearLoaderTheme.sizes.x2s ?? MoonLinearLoaderSizes(tokens: MoonTokens.light).x2s;
      default:
        return context.moonTheme?.linearLoaderTheme.sizes.x4s ?? MoonLinearLoaderSizes(tokens: MoonTokens.light).x4s;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonLinearLoaderSizeProperties effectiveLoaderSize = _getMoonLoaderSize(context, linearLoaderSize);

    final BorderRadiusGeometry effectiveBorderRadius = borderRadius ?? effectiveLoaderSize.borderRadius;

    final Color effectiveColor = color ?? context.moonTheme?.linearLoaderTheme.colors.color ?? MoonColors.light.piccolo;

    final Color effectiveBackgroundColor =
        backgroundColor ?? context.moonTheme?.linearLoaderTheme.colors.backgroundColor ?? Colors.transparent;

    final double effectiveHeight = height ?? effectiveLoaderSize.loaderHeight;

    return MoonLinearProgressIndicator(
      color: effectiveColor,
      backgroundColor: effectiveBackgroundColor,
      containerRadius: effectiveBorderRadius,
      progressRadius: effectiveBorderRadius,
      minHeight: effectiveHeight,
    );
  }
}
