import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextStyles extends ThemeExtension<MoonTextStyles> with DiagnosticableTreeMixin {
  static const _semiBold = FontWeight.w500;
  static const _semiBoldVariation = [FontVariation('wght', 500)];

  static const body = MoonTextStyles(
    textDefault: TextStyle(
      fontSize: 14,
    ),
    text6: TextStyle(
      fontSize: 6,
    ),
    text8: TextStyle(
      fontSize: 8,
    ),
    text9: TextStyle(
      fontSize: 9,
    ),
    text10: TextStyle(
      fontSize: 10,
    ),
    text12: TextStyle(
      fontSize: 12,
    ),
    text14: TextStyle(
      fontSize: 14,
    ),
    text16: TextStyle(
      fontSize: 16,
    ),
    text18: TextStyle(
      fontSize: 18,
    ),
    text20: TextStyle(
      fontSize: 20,
    ),
    text24: TextStyle(
      fontSize: 24,
    ),
    text32: TextStyle(
      fontSize: 32,
    ),
    text40: TextStyle(
      fontSize: 40,
    ),
    text48: TextStyle(
      fontSize: 48,
    ),
    text56: TextStyle(
      fontSize: 56,
    ),
    text64: TextStyle(
      fontSize: 64,
    ),
    text72: TextStyle(
      fontSize: 72,
    ),
  );

  static const heading = MoonTextStyles(
    textDefault: TextStyle(
      fontSize: 14,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text6: TextStyle(
      fontSize: 6,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text8: TextStyle(
      fontSize: 8,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text9: TextStyle(
      fontSize: 9,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text10: TextStyle(
      fontSize: 10,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text12: TextStyle(
      fontSize: 12,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text14: TextStyle(
      fontSize: 14,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text16: TextStyle(
      fontSize: 16,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text18: TextStyle(
      fontSize: 18,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text20: TextStyle(
      fontSize: 20,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text24: TextStyle(
      fontSize: 24,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text32: TextStyle(
      fontSize: 32,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text40: TextStyle(
      fontSize: 40,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text48: TextStyle(
      fontSize: 48,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text56: TextStyle(
      fontSize: 56,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text64: TextStyle(
      fontSize: 64,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text72: TextStyle(
      fontSize: 72,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
  );

  static const caption = MoonTextStyles(
    textDefault: TextStyle(
      fontSize: 14,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text6: TextStyle(
      fontSize: 6,
      height: 1.1,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text8: TextStyle(
      fontSize: 8,
      height: 1.1,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text9: TextStyle(
      fontSize: 9,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text10: TextStyle(
      fontSize: 10,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text12: TextStyle(
      fontSize: 12,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text14: TextStyle(
      fontSize: 14,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text16: TextStyle(
      fontSize: 16,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text18: TextStyle(
      fontSize: 18,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text20: TextStyle(
      fontSize: 20,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text24: TextStyle(
      fontSize: 24,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text32: TextStyle(
      fontSize: 32,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text40: TextStyle(
      fontSize: 40,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text48: TextStyle(
      fontSize: 48,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text56: TextStyle(
      fontSize: 56,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text64: TextStyle(
      fontSize: 64,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
    text72: TextStyle(
      fontSize: 72,
      height: 1.2,
      letterSpacing: 1,
      fontVariations: _semiBoldVariation,
      fontWeight: _semiBold,
    ),
  );

  /// Default text size.
  final TextStyle textDefault;

  /// Text size 6.
  final TextStyle text6;

  /// Text size 8.
  final TextStyle text8;

  /// Text size 9.
  final TextStyle text9;

  /// Text size 10.
  final TextStyle text10;

  /// Text size 12.
  final TextStyle text12;

  /// Text size 14.
  final TextStyle text14;

  /// Text size 16.
  final TextStyle text16;

  /// Text size 18.
  final TextStyle text18;

  /// Text size 20.
  final TextStyle text20;

  /// Text size 24.
  final TextStyle text24;

  /// Text size 32.
  final TextStyle text32;

  /// Text size 40.
  final TextStyle text40;

  /// Text size 48.
  final TextStyle text48;

  /// Text size 56.
  final TextStyle text56;

  /// Text size 64.
  final TextStyle text64;

  /// Text size 72.
  final TextStyle text72;

  const MoonTextStyles({
    required this.textDefault,
    required this.text6,
    required this.text8,
    required this.text9,
    required this.text10,
    required this.text12,
    required this.text14,
    required this.text16,
    required this.text18,
    required this.text20,
    required this.text24,
    required this.text32,
    required this.text40,
    required this.text48,
    required this.text56,
    required this.text64,
    required this.text72,
  });

  /// Creates a copy of this text theme but with the given field replaced in each of the individual text styles.
  MoonTextStyles apply({
    Color? backgroundColor,
    Color? color,
    Color? decorationColor,
    double decorationThicknessDelta = 0.0,
    double decorationThicknessFactor = 1.0,
    double fontSizeDelta = 0.0,
    double fontSizeFactor = 1.0,
    double heightDelta = 0.0,
    double heightFactor = 1.0,
    double letterSpacingDelta = 0.0,
    double letterSpacingFactor = 1.0,
    FontStyle? fontStyle,
    int fontWeightDelta = 0,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    List<Shadow>? shadows,
    List<String>? fontFamilyFallback,
    Locale? locale,
    String? fontFamily,
    String? package,
    TextBaseline? textBaseline,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    TextLeadingDistribution? leadingDistribution,
    TextOverflow? overflow,
  }) {
    TextStyle applyProps(TextStyle style) => style.apply(
          backgroundColor: backgroundColor,
          decorationThicknessDelta: decorationThicknessDelta,
          decorationThicknessFactor: decorationThicknessFactor,
          color: color,
          decorationColor: decorationColor,
          fontSizeDelta: fontSizeDelta,
          fontSizeFactor: fontSizeFactor,
          heightDelta: heightDelta,
          heightFactor: heightFactor,
          letterSpacingDelta: letterSpacingDelta,
          letterSpacingFactor: letterSpacingFactor,
          fontFeatures: fontFeatures,
          fontStyle: fontStyle,
          fontWeightDelta: fontWeightDelta,
          fontVariations: fontVariations,
          shadows: shadows,
          fontFamilyFallback: fontFamilyFallback,
          locale: locale,
          fontFamily: fontFamily,
          package: package,
          textBaseline: textBaseline,
          decoration: decoration,
          decorationStyle: decorationStyle,
          leadingDistribution: leadingDistribution,
          overflow: overflow,
        );

    return MoonTextStyles(
      textDefault: applyProps(textDefault),
      text6: applyProps(text6),
      text8: applyProps(text8),
      text9: applyProps(text9),
      text10: applyProps(text10),
      text12: applyProps(text12),
      text14: applyProps(text14),
      text16: applyProps(text16),
      text18: applyProps(text18),
      text20: applyProps(text20),
      text24: applyProps(text24),
      text32: applyProps(text32),
      text40: applyProps(text40),
      text48: applyProps(text48),
      text56: applyProps(text56),
      text64: applyProps(text64),
      text72: applyProps(text72),
    );
  }

  @override
  MoonTextStyles copyWith({
    TextStyle? textDefault,
    TextStyle? text6,
    TextStyle? text8,
    TextStyle? text9,
    TextStyle? text10,
    TextStyle? text12,
    TextStyle? text14,
    TextStyle? text16,
    TextStyle? text18,
    TextStyle? text20,
    TextStyle? text24,
    TextStyle? text32,
    TextStyle? text40,
    TextStyle? text48,
    TextStyle? text56,
    TextStyle? text64,
    TextStyle? text72,
  }) {
    return MoonTextStyles(
      textDefault: textDefault ?? this.textDefault,
      text6: text6 ?? this.text6,
      text8: text8 ?? this.text8,
      text9: text9 ?? this.text9,
      text10: text10 ?? this.text10,
      text12: text12 ?? this.text12,
      text14: text14 ?? this.text14,
      text16: text16 ?? this.text16,
      text18: text18 ?? this.text18,
      text20: text20 ?? this.text20,
      text24: text24 ?? this.text24,
      text32: text32 ?? this.text32,
      text40: text40 ?? this.text40,
      text48: text48 ?? this.text48,
      text56: text56 ?? this.text56,
      text64: text64 ?? this.text64,
      text72: text72 ?? this.text72,
    );
  }

  @override
  MoonTextStyles lerp(ThemeExtension<MoonTextStyles>? other, double t) {
    if (other is! MoonTextStyles) return this;

    return MoonTextStyles(
      textDefault: TextStyle.lerp(textDefault, other.textDefault, t)!,
      text6: TextStyle.lerp(text6, other.text6, t)!,
      text8: TextStyle.lerp(text8, other.text8, t)!,
      text9: TextStyle.lerp(text9, other.text9, t)!,
      text10: TextStyle.lerp(text10, other.text10, t)!,
      text12: TextStyle.lerp(text12, other.text12, t)!,
      text14: TextStyle.lerp(text14, other.text14, t)!,
      text16: TextStyle.lerp(text16, other.text16, t)!,
      text18: TextStyle.lerp(text18, other.text18, t)!,
      text20: TextStyle.lerp(text20, other.text20, t)!,
      text24: TextStyle.lerp(text24, other.text24, t)!,
      text32: TextStyle.lerp(text32, other.text32, t)!,
      text40: TextStyle.lerp(text40, other.text40, t)!,
      text48: TextStyle.lerp(text48, other.text48, t)!,
      text56: TextStyle.lerp(text56, other.text56, t)!,
      text64: TextStyle.lerp(text64, other.text64, t)!,
      text72: TextStyle.lerp(text72, other.text72, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonTextStyles"))
      ..add(DiagnosticsProperty<TextStyle>("textDefault", textDefault))
      ..add(DiagnosticsProperty<TextStyle>("text6", text6))
      ..add(DiagnosticsProperty<TextStyle>("text8", text8))
      ..add(DiagnosticsProperty<TextStyle>("text9", text9))
      ..add(DiagnosticsProperty<TextStyle>("text10", text10))
      ..add(DiagnosticsProperty<TextStyle>("text12", text12))
      ..add(DiagnosticsProperty<TextStyle>("text14", text14))
      ..add(DiagnosticsProperty<TextStyle>("text16", text16))
      ..add(DiagnosticsProperty<TextStyle>("text18", text18))
      ..add(DiagnosticsProperty<TextStyle>("text20", text20))
      ..add(DiagnosticsProperty<TextStyle>("text24", text24))
      ..add(DiagnosticsProperty<TextStyle>("text32", text32))
      ..add(DiagnosticsProperty<TextStyle>("text40", text40))
      ..add(DiagnosticsProperty<TextStyle>("text48", text48))
      ..add(DiagnosticsProperty<TextStyle>("text56", text56))
      ..add(DiagnosticsProperty<TextStyle>("text64", text64))
      ..add(DiagnosticsProperty<TextStyle>("text72", text72));
  }
}
