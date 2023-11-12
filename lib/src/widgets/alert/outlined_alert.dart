import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/alert/alert.dart';
import 'package:moon_design/src/widgets/buttons/button.dart';
import 'package:moon_icons/moon_icons.dart';

class MoonOutlinedAlert extends StatelessWidget {
  /// Controls whether the alert is shown.
  final bool show;

  /// The border radius of the alert.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the alert.
  final Color color;

  /// The border width of the alert.
  final double? borderWidth;

  /// The semantic label for the alert.
  final String? semanticLabel;

  /// The callback that is called when the trailing slot widget is tapped.
  final VoidCallback? onTrailingTap;

  /// The widget in the leading slot of the alert.
  final Widget? leading;

  /// The widget in the title slot of the alert.
  final Widget title;

  /// The widget in the body slot of the alert.
  final Widget? body;

  /// MDS outlined alert variant.
  ///
  /// See also:
  ///
  ///   * [MoonFilledAlert], MDS filled button.
  const MoonOutlinedAlert({
    super.key,
    this.show = false,
    this.borderRadius,
    required this.color,
    this.borderWidth,
    this.semanticLabel,
    this.onTrailingTap,
    this.leading,
    required this.title,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTrailing = MoonButton.icon(
      onTap: onTrailingTap,
      semanticLabel: semanticLabel,
      buttonSize: MoonButtonSize.xs,
      borderRadius: borderRadius,
      disabledOpacityValue: 1,
      icon: Icon(
        MoonIcons.controls_close_small_24_light,
        color: color,
        size: 24,
      ),
      gap: 0,
    );

    return MoonAlert(
      show: show,
      showBorder: true,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      semanticLabel: semanticLabel,
      leading: leading,
      title: title,
      trailing: effectiveTrailing,
      body: body,
      backgroundColor: Colors.transparent,
      borderColor: color,
      color: color,
    );
  }
}
