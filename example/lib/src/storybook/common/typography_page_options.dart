import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

enum MoonTextStyle {
  body,
  heading,
}

enum MoonTextSize {
  size6,
  size8,
  size9,
  size10,
  size12,
  size14,
  size16,
  size18,
  size20,
  size24,
  size32,
  size40,
  size48,
  size56,
  size64,
  size72;

  String get name {
    final String rawName = toString().split('.').last;
    return rawName.replaceFirst('size', 'Size ');
  }
}

TextStyle getBodyTextStyle(BuildContext context, MoonTextSize textSize) =>
    switch (textSize) {
      MoonTextSize.size6 => context.moonTypography!.body.text6,
      MoonTextSize.size8 => context.moonTypography!.body.text8,
      MoonTextSize.size9 => context.moonTypography!.body.text9,
      MoonTextSize.size10 => context.moonTypography!.body.text10,
      MoonTextSize.size12 => context.moonTypography!.body.text12,
      MoonTextSize.size14 => context.moonTypography!.body.text14,
      MoonTextSize.size16 => context.moonTypography!.body.text16,
      MoonTextSize.size18 => context.moonTypography!.body.text18,
      MoonTextSize.size20 => context.moonTypography!.body.text20,
      MoonTextSize.size24 => context.moonTypography!.body.text24,
      MoonTextSize.size32 => context.moonTypography!.body.text32,
      MoonTextSize.size40 => context.moonTypography!.body.text40,
      MoonTextSize.size48 => context.moonTypography!.body.text48,
      MoonTextSize.size56 => context.moonTypography!.body.text56,
      MoonTextSize.size64 => context.moonTypography!.body.text64,
      MoonTextSize.size72 => context.moonTypography!.body.text72,
    };

TextStyle getHeadingTextStyle(BuildContext context, MoonTextSize textSize) =>
    switch (textSize) {
      MoonTextSize.size6 => context.moonTypography!.heading.text6,
      MoonTextSize.size8 => context.moonTypography!.heading.text8,
      MoonTextSize.size9 => context.moonTypography!.heading.text9,
      MoonTextSize.size10 => context.moonTypography!.heading.text10,
      MoonTextSize.size12 => context.moonTypography!.heading.text12,
      MoonTextSize.size14 => context.moonTypography!.heading.text14,
      MoonTextSize.size16 => context.moonTypography!.heading.text16,
      MoonTextSize.size18 => context.moonTypography!.heading.text18,
      MoonTextSize.size20 => context.moonTypography!.heading.text20,
      MoonTextSize.size24 => context.moonTypography!.heading.text24,
      MoonTextSize.size32 => context.moonTypography!.heading.text32,
      MoonTextSize.size40 => context.moonTypography!.heading.text40,
      MoonTextSize.size48 => context.moonTypography!.heading.text48,
      MoonTextSize.size56 => context.moonTypography!.heading.text56,
      MoonTextSize.size64 => context.moonTypography!.heading.text64,
      MoonTextSize.size72 => context.moonTypography!.heading.text72,
    };

enum TypographyPageSection {
  typography,
  body,
  heading;

  String get titleText => switch (this) {
        typography => 'Typography',
        body => 'Body',
        heading => 'Heading',
      };

  String get bodyText => switch (this) {
        typography => 'Moon typography includes body and heading text styles. '
            'The body and header text styles have a set font size, while the '
            'heading text style also includes a semibold font weight.',
        _ => '',
      };
}
