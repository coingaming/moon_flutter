import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum MoonColor {
  piccolo,
  hit,
  beerus,
  goku,
  gohan,
  bulma,
  trunks,
  goten,
  popo,
  jiren,
  heles,
  zeno,
  krillin,
  krillin60,
  krillin10,
  chichi,
  chichi60,
  chichi10,
  roshi,
  roshi60,
  roshi10,
  frieza,
  frieza60,
  frieza10,
  dodoria,
  dodoria60,
  dodoria10,
  cell,
  cell60,
  cell10,
  raditz,
  raditz60,
  raditz10,
  nappa,
  nappa60,
  nappa10,
  whis,
  whis60,
  whis10,
}

List<MoonColor> mainColorsList = [
  MoonColor.piccolo,
  MoonColor.hit,
  MoonColor.beerus,
  MoonColor.goku,
  MoonColor.gohan,
  MoonColor.bulma,
  MoonColor.trunks,
  MoonColor.goten,
  MoonColor.popo,
  MoonColor.jiren,
  MoonColor.heles,
  MoonColor.zeno,
];

List<MoonColor> supportiveColorsList = [
  MoonColor.krillin,
  MoonColor.krillin60,
  MoonColor.krillin10,
  MoonColor.chichi,
  MoonColor.chichi60,
  MoonColor.chichi10,
  MoonColor.roshi,
  MoonColor.roshi60,
  MoonColor.roshi10,
  MoonColor.cell,
  MoonColor.cell60,
  MoonColor.cell10,
  MoonColor.dodoria,
  MoonColor.dodoria60,
  MoonColor.dodoria10,
  MoonColor.frieza,
  MoonColor.frieza60,
  MoonColor.frieza10,
  MoonColor.nappa,
  MoonColor.nappa60,
  MoonColor.nappa10,
  MoonColor.raditz,
  MoonColor.raditz60,
  MoonColor.raditz10,
  MoonColor.whis,
  MoonColor.whis60,
  MoonColor.whis10,
];

Color getColor(BuildContext context, MoonColor color) => switch (color) {
      MoonColor.piccolo => context.moonColors!.piccolo,
      MoonColor.hit => context.moonColors!.hit,
      MoonColor.beerus => context.moonColors!.beerus,
      MoonColor.goku => context.moonColors!.goku,
      MoonColor.gohan => context.moonColors!.gohan,
      MoonColor.bulma => context.moonColors!.bulma,
      MoonColor.trunks => context.moonColors!.trunks,
      MoonColor.goten => context.moonColors!.goten,
      MoonColor.popo => context.moonColors!.popo,
      MoonColor.jiren => context.moonColors!.jiren,
      MoonColor.heles => context.moonColors!.heles,
      MoonColor.zeno => context.moonColors!.zeno,
      MoonColor.krillin => context.moonColors!.krillin,
      MoonColor.krillin60 => context.moonColors!.krillin60,
      MoonColor.krillin10 => context.moonColors!.krillin10,
      MoonColor.chichi => context.moonColors!.chichi,
      MoonColor.chichi60 => context.moonColors!.chichi60,
      MoonColor.chichi10 => context.moonColors!.chichi10,
      MoonColor.roshi => context.moonColors!.roshi,
      MoonColor.roshi60 => context.moonColors!.roshi60,
      MoonColor.roshi10 => context.moonColors!.roshi10,
      MoonColor.frieza => context.moonColors!.frieza,
      MoonColor.frieza60 => context.moonColors!.frieza60,
      MoonColor.frieza10 => context.moonColors!.frieza10,
      MoonColor.dodoria => context.moonColors!.dodoria,
      MoonColor.dodoria60 => context.moonColors!.dodoria60,
      MoonColor.dodoria10 => context.moonColors!.dodoria10,
      MoonColor.cell => context.moonColors!.cell,
      MoonColor.cell60 => context.moonColors!.cell60,
      MoonColor.cell10 => context.moonColors!.cell10,
      MoonColor.raditz => context.moonColors!.raditz,
      MoonColor.raditz60 => context.moonColors!.raditz60,
      MoonColor.raditz10 => context.moonColors!.raditz10,
      MoonColor.nappa => context.moonColors!.nappa,
      MoonColor.nappa60 => context.moonColors!.nappa60,
      MoonColor.nappa10 => context.moonColors!.nappa10,
      MoonColor.whis => context.moonColors!.whis,
      MoonColor.whis60 => context.moonColors!.whis60,
      MoonColor.whis10 => context.moonColors!.whis10,
    };

/// The index of the color options.
List<Option<int>> colorOptions = [
  ...MoonColor.values.map(
    (MoonColor color) => Option(label: color.name, value: color.index),
  ),
  Option(label: 'transparent', value: MoonColor.values.length),
];

// The combination of "indexes" and colors in the colorTable() look-up table
// (LUT) is designed to circumvent the issue of a stale closure that would
// occur with the knob otherwise.

/// The look-up table for the color options.
List<Color?> colorTable(BuildContext context) => [
      ...MoonColor.values.map((MoonColor color) => getColor(context, color)),
      Colors.transparent,
      null,
    ];
