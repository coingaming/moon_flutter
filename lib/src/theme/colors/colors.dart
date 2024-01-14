import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

@immutable
class MoonColors extends ThemeExtension<MoonColors>
    with DiagnosticableTreeMixin {
  static const light = MoonColors(
    piccolo: Color(0xFF00E701),
    hit: Color(0xFF1BD29A),
    beerus: Color(0xFFDCDEE3),
    goku: Color(0xFFFFFFFF),
    gohan: Color(0xFFF6F7F9),
    bulma: Color(0xFF000000),
    trunks: Color(0xFF687083),
    goten: Color(0xFFFFFFFF),
    popo: Color(0xFF000000),
    jiren: Color(0x1F5C33CF),
    heles: Color(0x0A000000),
    zeno: Color(0x8F000000),
    krillin: Color(0xFFFFB319),
    krillin60: Color(0x8FFFB319),
    krillin10: Color(0x14FFB319),
    chichi: Color(0xFFFF4E64),
    chichi60: Color(0x8FFF4E64),
    chichi10: Color(0x14FF4E64),
    roshi: Color(0xFF49B356),
    roshi60: Color(0x8F49B356),
    roshi10: Color(0x1449B356),
    dodoria: Color(0xFFD33030),
    dodoria60: Color(0x8FD33030),
    dodoria10: Color(0x14D33030),
    cell: Color(0xFF95F1D5),
    cell60: Color(0x8F95F1D5),
    cell10: Color(0x1495F1D5),
    raditz: Color(0xFFB3804A),
    raditz60: Color(0x8FB3804A),
    raditz10: Color(0x14B3804A),
    whis: Color(0xFF3448F0),
    whis60: Color(0x8F3448F0),
    whis10: Color(0x143448F0),
    frieza: Color(0xFF5C33CF),
    frieza60: Color(0x8F5C33CF),
    frieza10: Color(0x145C33CF),
    nappa: Color(0xFF725550),
    nappa60: Color(0x8F725550),
    nappa10: Color(0x14725550),
    textPrimary: Color(0xFF000000), // bulma
    textSecondary: Color(0xFF687083), // trunks
    iconPrimary: Color(0xFF000000), // bulma
    iconSecondary: Color(0xFF687083), // trunks
  );

  static const dark = MoonColors(
    piccolo: Color(0xFF00E701),
    hit: Color(0xFF1BD29A),
    beerus: Color(0xFF292929),
    goku: Color(0xFF0B0E0F),
    gohan: Color(0xFF171C1E),
    bulma: Color(0xFFFFFFFF),
    trunks: Color(0xFF94989E),
    goten: Color(0xFF070809),
    popo: Color(0xFF000000),
    jiren: Color(0x1F5C33CF),
    heles: Color(0x14FFFFFF),
    zeno: Color(0x8F000000),
    krillin: Color(0xFFFFB319),
    krillin60: Color(0x8FFFB319),
    krillin10: Color(0x14FFB319),
    chichi: Color(0xFFFF4E64),
    chichi60: Color(0x8FFF4E64),
    chichi10: Color(0x14FF4E64),
    roshi: Color(0xFF49B356),
    roshi60: Color(0x8F49B356),
    roshi10: Color(0x1449B356),
    dodoria: Color(0xFFD33030),
    dodoria60: Color(0x8FD33030),
    dodoria10: Color(0x14D33030),
    cell: Color(0xFF95F1D5),
    cell60: Color(0x8F95F1D5),
    cell10: Color(0x1495F1D5),
    raditz: Color(0xFFB3804A),
    raditz60: Color(0x8FB3804A),
    raditz10: Color(0x14B3804A),
    whis: Color(0xFF3448F0),
    whis60: Color(0x8F3448F0),
    whis10: Color(0x143448F0),
    frieza: Color(0xFF5C33CF),
    frieza60: Color(0x8F5C33CF),
    frieza10: Color(0x145C33CF),
    nappa: Color(0xFF725550),
    nappa60: Color(0x8F725550),
    nappa10: Color(0x14725550),
    textPrimary: Color(0xFFFFFFFF), // bulma
    textSecondary: Color(0xFF94989E), // trunks
    iconPrimary: Color(0xFFFFFFFF), // bulma
    iconSecondary: Color(0xFF94989E), //trunks
  );

  // Main colors:

  /// Primary color.
  final Color piccolo;

  /// Secondary (accent) color.
  final Color hit;

  /// Border and line color.
  final Color beerus;

  /// Background color.
  final Color goku;

  /// Surface color.
  final Color gohan;

  /// Primary body text and icon color.
  final Color bulma;

  /// Secondary body text and icon color.
  final Color trunks;

  /// filled button text and icon color.
  final Color goten;

  /// outlined button text and icon color.
  final Color popo;

  /// Secondary hover effect color.
  final Color jiren;

  /// Primary hover effect color.
  final Color heles;

  /// Modal overlay (scrim) color.
  final Color zeno;

  // Supportive and Semantic colors:

  /// Warning color.
  final Color krillin;

  /// Warning color.
  final Color krillin60;

  /// Warning color.
  final Color krillin10;

  /// Error color.
  final Color chichi;

  /// Error color.
  final Color chichi60;

  /// Error color.
  final Color chichi10;

  /// Success color.
  final Color roshi;

  /// Success color.
  final Color roshi60;

  /// Success color.
  final Color roshi10;

  /// Supportive color.
  final Color frieza;

  /// Supportive color.
  final Color frieza60;

  /// Supportive color.
  final Color frieza10;

  /// Supportive color.
  final Color dodoria;

  /// Supportive color.
  final Color dodoria60;

  /// Supportive color.
  final Color dodoria10;

  /// Supportive color.
  final Color cell;

  /// Supportive color.
  final Color cell60;

  /// Supportive color.
  final Color cell10;

  /// Supportive color.
  final Color raditz;

  /// Supportive color.
  final Color raditz60;

  /// Supportive color.
  final Color raditz10;

  /// Supportive color.
  final Color nappa;

  /// Supportive color.
  final Color nappa60;

  /// Supportive color.
  final Color nappa10;

  /// Supportive color.
  final Color whis;

  /// Supportive color.
  final Color whis60;

  /// Supportive color.
  final Color whis10;

  /// Primary text color.
  final Color textPrimary;

  /// Secondary text color.
  final Color textSecondary;

  /// Primary icon color.
  final Color iconPrimary;

  /// Primary icon color.
  final Color iconSecondary;

  const MoonColors({
    required this.piccolo,
    required this.hit,
    required this.beerus,
    required this.goku,
    required this.gohan,
    required this.bulma,
    required this.trunks,
    required this.goten,
    required this.popo,
    required this.jiren,
    required this.heles,
    required this.zeno,
    required this.krillin,
    required this.krillin60,
    required this.krillin10,
    required this.chichi,
    required this.chichi60,
    required this.chichi10,
    required this.roshi,
    required this.roshi60,
    required this.roshi10,
    required this.frieza,
    required this.frieza60,
    required this.frieza10,
    required this.dodoria,
    required this.dodoria60,
    required this.dodoria10,
    required this.cell,
    required this.cell60,
    required this.cell10,
    required this.raditz,
    required this.raditz60,
    required this.raditz10,
    required this.nappa,
    required this.nappa60,
    required this.nappa10,
    required this.whis,
    required this.whis60,
    required this.whis10,
    required this.textPrimary,
    required this.textSecondary,
    required this.iconPrimary,
    required this.iconSecondary,
  });

  @override
  MoonColors copyWith({
    Color? piccolo,
    Color? hit,
    Color? beerus,
    Color? goku,
    Color? gohan,
    Color? bulma,
    Color? trunks,
    Color? goten,
    Color? popo,
    Color? jiren,
    Color? heles,
    Color? zeno,
    Color? krillin,
    Color? krillin60,
    Color? krillin10,
    Color? chichi,
    Color? chichi60,
    Color? chichi10,
    Color? roshi,
    Color? roshi60,
    Color? roshi10,
    Color? frieza,
    Color? frieza60,
    Color? frieza10,
    Color? dodoria,
    Color? dodoria60,
    Color? dodoria10,
    Color? cell,
    Color? cell60,
    Color? cell10,
    Color? raditz,
    Color? raditz60,
    Color? raditz10,
    Color? nappa,
    Color? nappa60,
    Color? nappa10,
    Color? whis,
    Color? whis60,
    Color? whis10,
    Color? textPrimary,
    Color? textSecondary,
    Color? iconPrimary,
    Color? iconSecondary,
  }) {
    return MoonColors(
      piccolo: piccolo ?? this.piccolo,
      hit: hit ?? this.hit,
      beerus: beerus ?? this.beerus,
      goku: goku ?? this.goku,
      gohan: gohan ?? this.gohan,
      bulma: bulma ?? this.bulma,
      trunks: trunks ?? this.trunks,
      goten: goten ?? this.goten,
      popo: popo ?? this.popo,
      jiren: jiren ?? this.jiren,
      heles: heles ?? this.heles,
      zeno: zeno ?? this.zeno,
      krillin: krillin ?? this.krillin,
      krillin60: krillin60 ?? this.krillin60,
      krillin10: krillin10 ?? this.krillin10,
      chichi: chichi ?? this.chichi,
      chichi60: chichi60 ?? this.chichi60,
      chichi10: chichi10 ?? this.chichi10,
      roshi: roshi ?? this.roshi,
      roshi60: roshi60 ?? this.roshi60,
      roshi10: roshi10 ?? this.roshi10,
      frieza: frieza ?? this.frieza,
      frieza60: frieza60 ?? this.frieza60,
      frieza10: frieza10 ?? this.frieza10,
      dodoria: dodoria ?? this.dodoria,
      dodoria60: dodoria60 ?? this.dodoria60,
      dodoria10: dodoria10 ?? this.dodoria10,
      cell: cell ?? this.cell,
      cell60: cell60 ?? this.cell60,
      cell10: cell10 ?? this.cell10,
      raditz: raditz ?? this.raditz,
      raditz60: raditz60 ?? this.raditz60,
      raditz10: raditz10 ?? this.raditz10,
      nappa: nappa ?? this.nappa,
      nappa60: nappa60 ?? this.nappa60,
      nappa10: nappa10 ?? this.nappa10,
      whis: whis ?? this.whis,
      whis60: whis60 ?? this.whis60,
      whis10: whis10 ?? this.whis10,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconSecondary: iconSecondary ?? this.iconSecondary,
    );
  }

  @override
  MoonColors lerp(ThemeExtension<MoonColors>? other, double t) {
    if (other is! MoonColors) return this;

    return MoonColors(
      piccolo: colorPremulLerp(piccolo, other.piccolo, t)!,
      hit: colorPremulLerp(hit, other.hit, t)!,
      beerus: colorPremulLerp(beerus, other.beerus, t)!,
      goku: colorPremulLerp(goku, other.goku, t)!,
      gohan: colorPremulLerp(gohan, other.gohan, t)!,
      bulma: colorPremulLerp(bulma, other.bulma, t)!,
      trunks: colorPremulLerp(trunks, other.trunks, t)!,
      goten: colorPremulLerp(goten, other.goten, t)!,
      popo: colorPremulLerp(popo, other.popo, t)!,
      jiren: colorPremulLerp(jiren, other.jiren, t)!,
      heles: colorPremulLerp(heles, other.heles, t)!,
      zeno: colorPremulLerp(zeno, other.zeno, t)!,
      krillin: colorPremulLerp(krillin, other.krillin, t)!,
      krillin60: colorPremulLerp(krillin60, other.krillin60, t)!,
      krillin10: colorPremulLerp(krillin10, other.krillin10, t)!,
      chichi: colorPremulLerp(chichi, other.chichi, t)!,
      chichi60: colorPremulLerp(chichi60, other.chichi60, t)!,
      chichi10: colorPremulLerp(chichi10, other.chichi10, t)!,
      roshi: colorPremulLerp(roshi, other.roshi, t)!,
      roshi60: colorPremulLerp(roshi60, other.roshi60, t)!,
      roshi10: colorPremulLerp(roshi10, other.roshi10, t)!,
      frieza: colorPremulLerp(frieza, other.frieza, t)!,
      frieza60: colorPremulLerp(frieza60, other.frieza60, t)!,
      frieza10: colorPremulLerp(frieza10, other.frieza10, t)!,
      dodoria: colorPremulLerp(dodoria, other.dodoria, t)!,
      dodoria60: colorPremulLerp(dodoria60, other.dodoria60, t)!,
      dodoria10: colorPremulLerp(dodoria10, other.dodoria10, t)!,
      cell: colorPremulLerp(cell, other.cell, t)!,
      cell60: colorPremulLerp(cell60, other.cell60, t)!,
      cell10: colorPremulLerp(cell10, other.cell10, t)!,
      raditz: colorPremulLerp(raditz, other.raditz, t)!,
      raditz60: colorPremulLerp(raditz60, other.raditz60, t)!,
      raditz10: colorPremulLerp(raditz10, other.raditz10, t)!,
      nappa: colorPremulLerp(nappa, other.nappa, t)!,
      nappa60: colorPremulLerp(nappa60, other.nappa60, t)!,
      nappa10: colorPremulLerp(nappa10, other.nappa10, t)!,
      whis: colorPremulLerp(whis, other.whis, t)!,
      whis60: colorPremulLerp(whis60, other.whis60, t)!,
      whis10: colorPremulLerp(whis10, other.whis10, t)!,
      textPrimary: colorPremulLerp(textPrimary, other.textPrimary, t)!,
      textSecondary: colorPremulLerp(textSecondary, other.textSecondary, t)!,
      iconPrimary: colorPremulLerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: colorPremulLerp(iconSecondary, other.iconSecondary, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonColors"))
      ..add(ColorProperty("piccolo", piccolo))
      ..add(ColorProperty("hit", hit))
      ..add(ColorProperty("beerus", beerus))
      ..add(ColorProperty("goku", goku))
      ..add(ColorProperty("gohan", gohan))
      ..add(ColorProperty("bulma", bulma))
      ..add(ColorProperty("trunks", trunks))
      ..add(ColorProperty("goten", goten))
      ..add(ColorProperty("popo", popo))
      ..add(ColorProperty("jiren", jiren))
      ..add(ColorProperty("heles", heles))
      ..add(ColorProperty("zeno", zeno))
      ..add(ColorProperty("krillin", krillin))
      ..add(ColorProperty("krillin60", krillin60))
      ..add(ColorProperty("krillin10", krillin10))
      ..add(ColorProperty("chichi", chichi))
      ..add(ColorProperty("chichi60", chichi60))
      ..add(ColorProperty("chichi10", chichi10))
      ..add(ColorProperty("roshi", roshi))
      ..add(ColorProperty("roshi60", roshi60))
      ..add(ColorProperty("roshi10", roshi10))
      ..add(ColorProperty("frieza", frieza))
      ..add(ColorProperty("frieza60", frieza60))
      ..add(ColorProperty("frieza10", frieza10))
      ..add(ColorProperty("dodoria", dodoria))
      ..add(ColorProperty("dodoria60", dodoria60))
      ..add(ColorProperty("dodoria10", dodoria10))
      ..add(ColorProperty("cell", cell))
      ..add(ColorProperty("cell60", cell60))
      ..add(ColorProperty("cell10", cell10))
      ..add(ColorProperty("raditz", raditz))
      ..add(ColorProperty("raditz60", raditz60))
      ..add(ColorProperty("raditz10", raditz10))
      ..add(ColorProperty("nappa", nappa))
      ..add(ColorProperty("nappa60", nappa60))
      ..add(ColorProperty("nappa10", nappa10))
      ..add(ColorProperty("whis", whis))
      ..add(ColorProperty("whis60", whis60))
      ..add(ColorProperty("whis10", whis10))
      ..add(ColorProperty("textPrimary", textPrimary))
      ..add(ColorProperty("textSecondary", textSecondary))
      ..add(ColorProperty("iconPrimary", iconPrimary))
      ..add(ColorProperty("iconSecondary", iconSecondary));
  }
}
