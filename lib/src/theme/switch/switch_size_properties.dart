import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/typography/text_styles.dart';

@immutable
class MoonSwitchSizeProperties extends ThemeExtension<MoonSwitchSizeProperties> with DiagnosticableTreeMixin {
  static final x2s = MoonSwitchSizeProperties(
    height: MoonSizes.sizes.x2s,
    width: 2 * MoonSizes.sizes.x3s + 2 * MoonSizes.sizes.x5s,
    thumbSizeValue: MoonSizes.sizes.x3s,
    iconSizeValue: MoonSizes.sizes.x3s,
    padding: EdgeInsets.all(MoonSizes.sizes.x6s),
    textStyle: MoonTextStyles.caption.text6.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
  );

  static final xs = MoonSwitchSizeProperties(
    height: MoonSizes.sizes.xs,
    width: 2 * MoonSizes.sizes.x2s + 3 * MoonSizes.sizes.x5s,
    thumbSizeValue: MoonSizes.sizes.x2s,
    iconSizeValue: MoonSizes.sizes.x2s,
    padding: EdgeInsets.all(MoonSizes.sizes.x5s),
    textStyle: MoonTextStyles.caption.text8.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
  );

  static final sm = MoonSwitchSizeProperties(
    height: MoonSizes.sizes.sm,
    width: 2 * MoonSizes.sizes.xs + 3 * MoonSizes.sizes.x5s,
    thumbSizeValue: MoonSizes.sizes.xs,
    iconSizeValue: MoonSizes.sizes.xs,
    padding: EdgeInsets.all(MoonSizes.sizes.x5s),
    textStyle: MoonTextStyles.caption.text10.copyWith(letterSpacing: kIsWeb ? 0.5 : 0.1),
  );

  /// Switch height.
  final double height;

  /// Switch width.
  final double width;

  /// Switch thumb size.
  final double thumbSizeValue;

  /// Switch icon size.
  final double iconSizeValue;

  /// Switch track padding.
  final EdgeInsetsGeometry padding;

  /// Switch track text style.
  final TextStyle textStyle;

  const MoonSwitchSizeProperties({
    required this.height,
    required this.width,
    required this.thumbSizeValue,
    required this.iconSizeValue,
    required this.padding,
    required this.textStyle,
  });

  @override
  MoonSwitchSizeProperties copyWith({
    double? height,
    double? width,
    double? thumbSizeValue,
    double? iconSizeValue,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return MoonSwitchSizeProperties(
      height: height ?? this.height,
      width: width ?? this.width,
      thumbSizeValue: thumbSizeValue ?? this.thumbSizeValue,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  MoonSwitchSizeProperties lerp(ThemeExtension<MoonSwitchSizeProperties>? other, double t) {
    if (other is! MoonSwitchSizeProperties) return this;

    return MoonSwitchSizeProperties(
      height: lerpDouble(height, other.height, t)!,
      width: lerpDouble(width, other.width, t)!,
      thumbSizeValue: lerpDouble(thumbSizeValue, other.thumbSizeValue, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSwitchSizeProperties"))
      ..add(DoubleProperty("height", height))
      ..add(DoubleProperty("width", width))
      ..add(DoubleProperty("thumbSizeValue", thumbSizeValue))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("textStyle", textStyle));
  }
}
