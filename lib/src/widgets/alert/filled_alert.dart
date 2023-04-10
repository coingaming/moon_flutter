import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/alert/alert.dart';
import 'package:moon_design/src/widgets/buttons/button.dart';
import 'package:moon_design/src/widgets/common/icons/icons.dart';

class MoonFilledAlert extends StatelessWidget {
  /// Controls whether the alert is shown.
  final bool show;

  /// The border radius of the alert.
  final BorderRadius? borderRadius;

  /// The color of the alert.
  final Color? color;

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

  /// MDS filled alert variant.
  ///
  /// See also:
  ///
  ///   * [MoonOutlinedAlert], MDS outlined button.
  const MoonFilledAlert({
    super.key,
    this.show = false,
    this.borderRadius,
    this.color,
    this.semanticLabel,
    this.onTrailingTap,
    this.leading,
    required this.title,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedBackgroundColor = color != null ? color!.withOpacity(0.1) : null;

    final effectiveTrailing = MoonButton.icon(
      onTap: onTrailingTap,
      semanticLabel: semanticLabel,
      buttonSize: MoonButtonSize.xs,
      borderRadius: borderRadius,
      disabledOpacityValue: 1,
      icon: Icon(
        MoonIcons.close_small_24,
        color: color,
        size: 24,
      ),
      gap: 0,
    );

    return MoonAlert(
      show: show,
      borderRadius: borderRadius,
      semanticLabel: semanticLabel,
      leading: leading,
      title: title,
      trailing: effectiveTrailing,
      body: body,
      backgroundColor: resolvedBackgroundColor,
      leadingColor: color,
      textColor: color,
    );
  }
}
