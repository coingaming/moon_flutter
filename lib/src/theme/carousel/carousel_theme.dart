import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/carousel/carousel_colors.dart';
import 'package:moon_design/src/theme/carousel/carousel_properties.dart';
import 'package:moon_design/src/theme/icon/icon_theme.dart';
import 'package:moon_design/src/theme/text/text_theme.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonCarouselTheme extends ThemeExtension<MoonCarouselTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Carousel colors.
  final MoonCarouselColors colors;

  /// Carousel properties.
  final MoonCarouselProperties properties;

  MoonCarouselTheme({
    required this.tokens,
    MoonCarouselColors? colors,
    MoonCarouselProperties? properties,
  })  : colors = colors ??
            MoonCarouselColors(
              textColor: MoonTextTheme(tokens: tokens).colors.bodyPrimary,
              iconColor: MoonIconTheme(tokens: tokens).colors.primaryColor,
            ),
        properties = properties ??
            MoonCarouselProperties(
              gap: tokens.sizes.x2s,
              textStyle: tokens.typography.body.textDefault,
              autoPlayDelay: const Duration(seconds: 3),
              transitionDuration: const Duration(milliseconds: 800),
              transitionCurve: Curves.fastOutSlowIn,
            );

  @override
  MoonCarouselTheme copyWith({
    MoonTokens? tokens,
    MoonCarouselColors? colors,
    MoonCarouselProperties? properties,
  }) {
    return MoonCarouselTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonCarouselTheme lerp(ThemeExtension<MoonCarouselTheme>? other, double t) {
    if (other is! MoonCarouselTheme) return this;

    return MoonCarouselTheme(
      tokens: tokens,
      properties: properties.lerp(other.properties, t),
      colors: colors.lerp(other.colors, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonCarouselTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonCarouselColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonCarouselProperties>("properties", properties));
  }
}
