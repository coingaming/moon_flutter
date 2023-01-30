import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonTextStyles extends ThemeExtension<MoonTextStyles> with DiagnosticableTreeMixin {
  //static const _prefferredFont = "Averta";
  //static const _preferredFontPackage = "moon_design";
  static const _semiBold = FontWeight.w600;

  static const text = MoonTextStyles(
    text9: TextStyle(
      fontSize: 9,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text10: TextStyle(
      fontSize: 10,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text12: TextStyle(
      fontSize: 12,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text14: TextStyle(
      fontSize: 14,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text16: TextStyle(
      fontSize: 16,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text18: TextStyle(
      fontSize: 18,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text20: TextStyle(
      fontSize: 20,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text24: TextStyle(
      fontSize: 24,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text32: TextStyle(
      fontSize: 32,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text48: TextStyle(
      fontSize: 48,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text56: TextStyle(
      fontSize: 56,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text64: TextStyle(
      fontSize: 64,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text72: TextStyle(
      fontSize: 72,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
  );

  static const heading = MoonTextStyles(
    text9: TextStyle(
      fontSize: 9,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text10: TextStyle(
      fontSize: 10,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text12: TextStyle(
      fontSize: 12,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text14: TextStyle(
      fontSize: 14,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text16: TextStyle(
      fontSize: 16,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text18: TextStyle(
      fontSize: 18,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text20: TextStyle(
      fontSize: 20,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text24: TextStyle(
      fontSize: 24,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text32: TextStyle(
      fontSize: 32,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text48: TextStyle(
      fontSize: 48,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text56: TextStyle(
      fontSize: 56,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text64: TextStyle(
      fontSize: 64,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
    text72: TextStyle(
      fontSize: 72,
      fontWeight: _semiBold,
      //fontFamily: _prefferredFont,
      //package: _preferredFontPackage,
    ),
  );

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

  /// Text size 48.
  final TextStyle text48;

  /// Text size 56.
  final TextStyle text56;

  /// Text size 64.
  final TextStyle text64;

  /// Text size 72.
  final TextStyle text72;

  const MoonTextStyles({
    required this.text9,
    required this.text10,
    required this.text12,
    required this.text14,
    required this.text16,
    required this.text18,
    required this.text20,
    required this.text24,
    required this.text32,
    required this.text48,
    required this.text56,
    required this.text64,
    required this.text72,
  });

  @override
  MoonTextStyles copyWith({
    TextStyle? text9,
    TextStyle? text10,
    TextStyle? text12,
    TextStyle? text14,
    TextStyle? text16,
    TextStyle? text18,
    TextStyle? text20,
    TextStyle? text24,
    TextStyle? text32,
    TextStyle? text48,
    TextStyle? text56,
    TextStyle? text64,
    TextStyle? text72,
  }) {
    return MoonTextStyles(
      text9: text9 ?? this.text9,
      text10: text10 ?? this.text10,
      text12: text12 ?? this.text12,
      text14: text14 ?? this.text14,
      text16: text16 ?? this.text16,
      text18: text18 ?? this.text18,
      text20: text20 ?? this.text20,
      text24: text24 ?? this.text24,
      text32: text32 ?? this.text32,
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
      text9: TextStyle.lerp(text9, other.text9, t)!,
      text10: TextStyle.lerp(text10, other.text10, t)!,
      text12: TextStyle.lerp(text12, other.text12, t)!,
      text14: TextStyle.lerp(text14, other.text14, t)!,
      text16: TextStyle.lerp(text16, other.text16, t)!,
      text18: TextStyle.lerp(text18, other.text18, t)!,
      text20: TextStyle.lerp(text20, other.text20, t)!,
      text24: TextStyle.lerp(text24, other.text24, t)!,
      text32: TextStyle.lerp(text32, other.text32, t)!,
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
      ..add(DiagnosticsProperty<TextStyle>("text9", text9))
      ..add(DiagnosticsProperty<TextStyle>("text10", text10))
      ..add(DiagnosticsProperty<TextStyle>("text12", text12))
      ..add(DiagnosticsProperty<TextStyle>("text14", text14))
      ..add(DiagnosticsProperty<TextStyle>("text16", text16))
      ..add(DiagnosticsProperty<TextStyle>("text18", text18))
      ..add(DiagnosticsProperty<TextStyle>("text20", text20))
      ..add(DiagnosticsProperty<TextStyle>("text24", text24))
      ..add(DiagnosticsProperty<TextStyle>("text32", text32))
      ..add(DiagnosticsProperty<TextStyle>("text48", text48))
      ..add(DiagnosticsProperty<TextStyle>("text56", text56))
      ..add(DiagnosticsProperty<TextStyle>("text64", text64))
      ..add(DiagnosticsProperty<TextStyle>("text72", text72));
  }
}
