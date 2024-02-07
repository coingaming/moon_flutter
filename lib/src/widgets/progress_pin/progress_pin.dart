import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/widgets/progress_pin/pin_style.dart';
import 'package:moon_design/src/widgets/progress_pin/progress_pin_painter.dart';
import 'package:moon_tokens/moon_tokens.dart';

class MoonProgressPin extends StatelessWidget {
  final double progressValue;
  final PinStyle? pinStyle;
  final String pinText;
  final Widget child;

  /// Creates a Moon Design progress pin.
  const MoonProgressPin({
    super.key,
    required this.progressValue,
    this.pinStyle,
    required this.pinText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectivePinColor =
        pinStyle?.pinColor ?? context.moonTheme?.progressPinTheme.colors.pinColor ?? MoonColors.light.popo;

    final Color effectivePinBorderColor =
        pinStyle?.pinBorderColor ?? context.moonTheme?.progressPinTheme.colors.pinBorderColor ?? MoonColors.light.goten;

    final Color effectiveThumbColor =
        pinStyle?.thumbColor ?? context.moonTheme?.progressPinTheme.colors.thumbColor ?? MoonColors.light.goten;

    final Color effectiveShadowColor =
        pinStyle?.shadowColor ?? context.moonTheme?.progressPinTheme.colors.shadowColor ?? MoonColors.light.popo;

    final Color effectiveTextColor =
        pinStyle?.textStyle?.color ?? context.moonTheme?.progressPinTheme.colors.textColor ?? MoonColors.light.goten;

    final TextStyle effectiveTextStyle = pinStyle?.textStyle ??
        context.moonTheme?.progressPinTheme.properties.textStyle ??
        MoonTypography.typography.caption.text10;

    final double effectivePinWidth =
        pinStyle?.pinWidth ?? context.moonTheme?.progressPinTheme.properties.pinWidth ?? 36;

    final double effectivePinBorderWidth = pinStyle?.pinBorderWidth ??
        context.moonTheme?.progressPinTheme.properties.pinBorderWidth ??
        MoonSizes.sizes.x6s;

    final double effectivePinDistance =
        pinStyle?.pinDistance ?? context.moonTheme?.progressPinTheme.properties.pinDistance ?? MoonSizes.sizes.x5s;

    final double effectiveArrowHeight =
        pinStyle?.arrowHeight ?? context.moonTheme?.progressPinTheme.properties.arrowHeight ?? 6;

    final double effectiveArrowWidth =
        pinStyle?.arrowWidth ?? context.moonTheme?.progressPinTheme.properties.arrowWidth ?? MoonSizes.sizes.x4s;

    final double effectiveShadowElevation =
        pinStyle?.shadowElevation ?? context.moonTheme?.progressPinTheme.properties.shadowElevation ?? 6;

    final TextDirection effectiveTextDirection = Directionality.of(context);

    return CustomPaint(
      foregroundPainter: ProgressPinPainter(
        showShadow: pinStyle?.showShadow ?? true,
        pinColor: effectivePinColor,
        thumbColor: effectiveThumbColor,
        shadowColor: effectiveShadowColor,
        pinBorderColor: effectivePinBorderColor,
        pinBorderWidth: effectivePinBorderWidth,
        arrowHeight: effectiveArrowHeight,
        arrowWidth: effectiveArrowWidth,
        pinDistance: effectivePinDistance,
        pinWidth: effectivePinWidth,
        // ignore: deprecated_member_use_from_same_package
        thumbSizeValue: pinStyle?.thumbSizeValue ?? pinStyle?.thumbWidth,
        progressValue: progressValue,
        shadowElevation: effectiveShadowElevation,
        pinText: pinText,
        textDirection: effectiveTextDirection,
        textStyle: effectiveTextStyle.copyWith(color: effectiveTextColor),
      ),
      child: child,
    );
  }
}
