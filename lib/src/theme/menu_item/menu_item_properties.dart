import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonMenuItemProperties extends ThemeExtension<MoonMenuItemProperties>
    with DiagnosticableTreeMixin {
  /// The border radius of the MoonMenuItem.
  final BorderRadiusGeometry borderRadius;

  /// The vertical gap between the label and content widgets of the MoonMenuItem.
  final double verticalGap;

  /// The minimum height of the MoonMenuItem.
  final double minimumHeight;

  /// The padding of the MoonMenuItem.
  final EdgeInsetsGeometry padding;

  /// The text style of the MoonMenuItem label.
  final TextStyle labelTextStyle;

  /// The text style of the MoonMenuItem content.
  final TextStyle contentTextStyle;

  const MoonMenuItemProperties({
    required this.borderRadius,
    required this.verticalGap,
    required this.minimumHeight,
    required this.padding,
    required this.labelTextStyle,
    required this.contentTextStyle,
  });

  @override
  MoonMenuItemProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? verticalGap,
    double? minimumHeight,
    EdgeInsetsGeometry? padding,
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return MoonMenuItemProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      verticalGap: verticalGap ?? this.verticalGap,
      minimumHeight: minimumHeight ?? this.minimumHeight,
      padding: padding ?? this.padding,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    );
  }

  @override
  MoonMenuItemProperties lerp(
    ThemeExtension<MoonMenuItemProperties>? other,
    double t,
  ) {
    if (other is! MoonMenuItemProperties) return this;

    return MoonMenuItemProperties(
      borderRadius:
          BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      minimumHeight: lerpDouble(minimumHeight, other.minimumHeight, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      contentTextStyle:
          TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty("type", "MoonMenuItemProperties"),
      )
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius),
      )
      ..add(
        DoubleProperty("verticalGap", verticalGap),
      )
      ..add(
        DoubleProperty("minimumHeight", minimumHeight),
      )
      ..add(
        DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding),
      )
      ..add(
        DiagnosticsProperty<TextStyle>("labelTextStyle", labelTextStyle),
      )
      ..add(
        DiagnosticsProperty<TextStyle>("contentTextStyle", contentTextStyle),
      );
  }
}
