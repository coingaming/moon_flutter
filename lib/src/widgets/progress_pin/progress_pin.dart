import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/widgets/progress_pin/pin_style.dart';
import 'package:moon_design/src/widgets/progress_pin/progress_pin_painter.dart';
import 'package:moon_tokens/moon_tokens.dart';

class MoonProgressPin extends StatelessWidget {
  final double progressValue;
  final PinStyle? pinStyle;
  final String progressLabel;
  final Widget child;

  const MoonProgressPin({
    super.key,
    required this.progressValue,
    required this.child,
    this.pinStyle,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectivePinColor =
        pinStyle?.pinColor ?? context.moonTheme?.progressPinTheme.colors.pinColor ?? MoonColors.light.popo;

    final Color effectivePinBorderColor =
        pinStyle?.pinBorderColor ?? context.moonTheme?.progressPinTheme.colors.pinBorderColor ?? MoonColors.light.goten;

    final Color effectiveKnobColor =
        pinStyle?.thumbColor ?? context.moonTheme?.progressPinTheme.colors.thumbColor ?? MoonColors.light.goten;

    final Color effectiveShadowColor =
        pinStyle?.shadowColor ?? context.moonTheme?.progressPinTheme.colors.shadowColor ?? MoonColors.light.popo;

    final Color effectiveTextColor =
        pinStyle?.textStyle?.color ?? context.moonTheme?.progressPinTheme.colors.textColor ?? MoonColors.light.goten;

    final TextStyle effectiveTextStyle = pinStyle?.textStyle ??
        context.moonTheme?.progressPinTheme.properties.textStyle ??
        MoonTypography.typography.caption.text10.copyWith(letterSpacing: 0.5);

    final double effectiveKnobWidthMultiplier =
        context.moonTheme?.progressPinTheme.properties.thumbWidthMultiplier ?? 1.5;

    final double effectivePinWidth =
        pinStyle?.pinWidth ?? context.moonTheme?.progressPinTheme.properties.pinWidth ?? 36;

    final double effectivePinBorderWidth =
        pinStyle?.pinBorderWidth ?? context.moonTheme?.progressPinTheme.properties.pinBorderWidth ?? 2;

    final double effectivePinDistance =
        pinStyle?.pinDistance ?? context.moonTheme?.progressPinTheme.properties.pinDistance ?? 6;

    final double effectiveShadowElevation =
        pinStyle?.shadowElevation ?? context.moonTheme?.progressPinTheme.properties.shadowElevation ?? 6;

    final TextDirection effectiveTextDirection = Directionality.of(context);

    return CustomPaint(
      foregroundPainter: ProgressPinPainter(
        showShadow: pinStyle?.showShadow ?? true,
        pinColor: effectivePinColor,
        thumbColor: effectiveKnobColor,
        shadowColor: effectiveShadowColor,
        pinBorderColor: effectivePinBorderColor,
        pinBorderWidth: effectivePinBorderWidth,
        pinDistance: effectivePinDistance,
        pinWidth: effectivePinWidth,
        thumbWidth: pinStyle?.thumbWidth,
        thumbWidthMultiplier: effectiveKnobWidthMultiplier,
        progressValue: progressValue,
        shadowElevation: effectiveShadowElevation,
        labelText: progressLabel,
        textDirection: effectiveTextDirection,
        textStyle: effectiveTextStyle.copyWith(color: effectiveTextColor),
      ),
      child: child,
    );
  }
}
