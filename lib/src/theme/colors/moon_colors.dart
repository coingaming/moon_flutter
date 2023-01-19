import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@immutable
class MoonColors extends ThemeExtension<MoonColors> with DiagnosticableTreeMixin {
  static const light = MoonColors(
    piccolo: Color(0xFF4E46B4),
    hit: Color(0xFF40A69F),
    beerus: Color(0xFFEBEBEB),
    goku: Color(0xFFF5F5F5),
    gohan: Color(0xFFFFFFFF),
    bulma: Color(0xFF000000),
    trunks: Color(0xFF999CA0),
    goten: Color(0xFFFFFFFF),
    popo: Color(0xFF000000),
    jiren: Color(0x1F4E46B4),
    heles: Color(0x0A000000),
    zeno: Color(0x8F000000),
    krillin100: Color(0xFFFF9800),
    krillin60: Color(0x8FFF9800),
    krillin10: Color(0x14FF9800),
    chiChi100: Color(0xFFFF4E64),
    chiChi60: Color(0x8FFF4E64),
    chiChi10: Color(0x14FF4E64),
    roshi100: Color(0xFF2E7D32),
    roshi60: Color(0x8F2E7D32),
    roshi10: Color(0x142E7D32),
    frieza100: Color(0xFF5C33CF),
    frieza60: Color(0x8F5C33CF),
    frieza10: Color(0x145C33CF),
    dodoria100: Color(0xFFD33030),
    dodoria60: Color(0x8FD33030),
    dodoria10: Color(0x14D33030),
    cell100: Color(0xFF95F1D5),
    cell60: Color(0x8F95F1D5),
    cell10: Color(0x1495F1D5),
    raditz100: Color(0xFFB3804A),
    raditz60: Color(0x8FB3804A),
    raditz10: Color(0x14B3804A),
    nappa100: Color(0xFF725550),
    nappa60: Color(0x8F725550),
    nappa10: Color(0x14725550),
    whis100: Color(0xFF3448F0),
    whis60: Color(0x8F3448F0),
    whis10: Color(0x143448F0),
  );

  static const dark = MoonColors(
    piccolo: Color(0xFF5B50EE),
    hit: Color(0xFF40A69F),
    beerus: Color(0xFF444444),
    goku: Color(0xFF0B0B0B),
    gohan: Color(0xFF1F1F1F),
    bulma: Color(0xFFFFFFFF),
    trunks: Color(0xFF999CA0),
    goten: Color(0xFFFFFFFF),
    popo: Color(0xFF000000),
    jiren: Color(0x525B50EE),
    heles: Color(0x1FFFFFFF),
    zeno: Color(0x8F000000),
    krillin100: Color(0xFFFF9800),
    krillin60: Color(0x8FFF9800),
    krillin10: Color(0x14FF9800),
    chiChi100: Color(0xFFFF4E64),
    chiChi60: Color(0x8FFF4E64),
    chiChi10: Color(0x14FF4E64),
    roshi100: Color(0xFF2E7D32),
    roshi60: Color(0x8F2E7D32),
    roshi10: Color(0x142E7D32),
    frieza100: Color(0xFF5C33CF),
    frieza60: Color(0x8F5C33CF),
    frieza10: Color(0x145C33CF),
    dodoria100: Color(0xFFD33030),
    dodoria60: Color(0x8FD33030),
    dodoria10: Color(0x14D33030),
    cell100: Color(0xFF95F1D5),
    cell60: Color(0x8F95F1D5),
    cell10: Color(0x1495F1D5),
    raditz100: Color(0xFFB3804A),
    raditz60: Color(0x8FB3804A),
    raditz10: Color(0x14B3804A),
    nappa100: Color(0xFF725550),
    nappa60: Color(0x8F725550),
    nappa10: Color(0x14725550),
    whis100: Color(0xFF3448F0),
    whis60: Color(0x8F3448F0),
    whis10: Color(0x143448F0),
  );

  // Main colours:
  // Accent colours
  final Color piccolo;
  final Color hit;
  // Border and line colour
  final Color beerus;
  // Background colours
  final Color goku;
  final Color gohan;
  // Text and icon colours
  final Color bulma;
  final Color trunks;
  // Forced colours
  final Color goten;
  final Color popo;
  // Ghost/disabled colour
  final Color jiren;
  // Generic hover effect colour
  final Color heles;
  // Modal overlay colour
  final Color zeno;

  // Supportive and Semantic colours:
  // Warning colour
  final Color krillin100;
  final Color krillin60;
  final Color krillin10;
  // Error colour
  final Color chiChi100;
  final Color chiChi60;
  final Color chiChi10;
  // Success colour
  final Color roshi100;
  final Color roshi60;
  final Color roshi10;
  //Other supportive colours
  final Color frieza100;
  final Color frieza60;
  final Color frieza10;
  final Color dodoria100;
  final Color dodoria60;
  final Color dodoria10;
  final Color cell100;
  final Color cell60;
  final Color cell10;
  final Color raditz100;
  final Color raditz60;
  final Color raditz10;
  final Color nappa100;
  final Color nappa60;
  final Color nappa10;
  final Color whis100;
  final Color whis60;
  final Color whis10;

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
    required this.krillin100,
    required this.krillin60,
    required this.krillin10,
    required this.chiChi100,
    required this.chiChi60,
    required this.chiChi10,
    required this.roshi100,
    required this.roshi60,
    required this.roshi10,
    required this.frieza100,
    required this.frieza60,
    required this.frieza10,
    required this.dodoria100,
    required this.dodoria60,
    required this.dodoria10,
    required this.cell100,
    required this.cell60,
    required this.cell10,
    required this.raditz100,
    required this.raditz60,
    required this.raditz10,
    required this.nappa100,
    required this.nappa60,
    required this.nappa10,
    required this.whis100,
    required this.whis60,
    required this.whis10,
  });

  @override
  MoonColors copyWith({
    Color? piccolo,
    Color? jiren,
    Color? hit,
    Color? heles,
    Color? beerus,
    Color? goku,
    Color? gohan,
    Color? zeno,
    Color? bulma,
    Color? trunks,
    Color? goten,
    Color? popo,
    Color? krillin100,
    Color? krillin60,
    Color? krillin10,
    Color? chiChi100,
    Color? chiChi60,
    Color? chiChi10,
    Color? roshi100,
    Color? roshi60,
    Color? roshi10,
    Color? frieza100,
    Color? frieza60,
    Color? frieza10,
    Color? dodoria100,
    Color? dodoria60,
    Color? dodoria10,
    Color? cell100,
    Color? cell60,
    Color? cell10,
    Color? raditz100,
    Color? raditz60,
    Color? raditz10,
    Color? nappa100,
    Color? nappa60,
    Color? nappa10,
    Color? whis100,
    Color? whis60,
    Color? whis10,
  }) {
    return MoonColors(
      piccolo: piccolo ?? this.piccolo,
      jiren: jiren ?? this.jiren,
      hit: hit ?? this.hit,
      heles: heles ?? this.heles,
      beerus: beerus ?? this.beerus,
      goku: goku ?? this.goku,
      gohan: gohan ?? this.gohan,
      zeno: zeno ?? this.zeno,
      bulma: bulma ?? this.bulma,
      trunks: trunks ?? this.trunks,
      goten: goten ?? this.goten,
      popo: popo ?? this.popo,
      krillin100: krillin100 ?? this.krillin100,
      krillin60: krillin60 ?? this.krillin60,
      krillin10: krillin10 ?? this.krillin10,
      chiChi100: chiChi100 ?? this.chiChi100,
      chiChi60: chiChi60 ?? this.chiChi60,
      chiChi10: chiChi10 ?? this.chiChi10,
      roshi100: roshi100 ?? this.roshi100,
      roshi60: roshi60 ?? this.roshi60,
      roshi10: roshi10 ?? this.roshi10,
      frieza100: frieza100 ?? this.frieza100,
      frieza60: frieza60 ?? this.frieza60,
      frieza10: frieza10 ?? this.frieza10,
      dodoria100: dodoria100 ?? this.dodoria100,
      dodoria60: dodoria60 ?? this.dodoria60,
      dodoria10: dodoria10 ?? this.dodoria10,
      cell100: cell100 ?? this.cell100,
      cell60: cell60 ?? this.cell60,
      cell10: cell10 ?? this.cell10,
      raditz100: raditz100 ?? this.raditz100,
      raditz60: raditz60 ?? this.raditz60,
      raditz10: raditz10 ?? this.raditz10,
      nappa100: nappa100 ?? this.nappa100,
      nappa60: nappa60 ?? this.nappa60,
      nappa10: nappa10 ?? this.nappa10,
      whis100: whis100 ?? this.whis100,
      whis60: whis60 ?? this.whis60,
      whis10: whis10 ?? this.whis10,
    );
  }

  @override
  MoonColors lerp(ThemeExtension<MoonColors>? other, double t) {
    if (other is! MoonColors) return this;

    return MoonColors(
      piccolo: Color.lerp(piccolo, other.piccolo, t)!,
      jiren: Color.lerp(jiren, other.jiren, t)!,
      hit: Color.lerp(hit, other.hit, t)!,
      heles: Color.lerp(heles, other.heles, t)!,
      beerus: Color.lerp(beerus, other.beerus, t)!,
      goku: Color.lerp(goku, other.goku, t)!,
      gohan: Color.lerp(gohan, other.gohan, t)!,
      zeno: Color.lerp(zeno, other.zeno, t)!,
      bulma: Color.lerp(bulma, other.bulma, t)!,
      trunks: Color.lerp(trunks, other.trunks, t)!,
      goten: Color.lerp(goten, other.goten, t)!,
      popo: Color.lerp(popo, other.popo, t)!,
      krillin100: Color.lerp(krillin100, other.krillin100, t)!,
      krillin60: Color.lerp(krillin60, other.krillin60, t)!,
      krillin10: Color.lerp(krillin10, other.krillin10, t)!,
      chiChi100: Color.lerp(chiChi100, other.chiChi100, t)!,
      chiChi60: Color.lerp(chiChi60, other.chiChi60, t)!,
      chiChi10: Color.lerp(chiChi10, other.chiChi10, t)!,
      roshi100: Color.lerp(roshi100, other.roshi100, t)!,
      roshi60: Color.lerp(roshi60, other.roshi60, t)!,
      roshi10: Color.lerp(roshi10, other.roshi10, t)!,
      frieza100: Color.lerp(frieza100, other.frieza100, t)!,
      frieza60: Color.lerp(frieza60, other.frieza60, t)!,
      frieza10: Color.lerp(frieza10, other.frieza10, t)!,
      dodoria100: Color.lerp(dodoria100, other.dodoria100, t)!,
      dodoria60: Color.lerp(dodoria60, other.dodoria60, t)!,
      dodoria10: Color.lerp(dodoria10, other.dodoria10, t)!,
      cell100: Color.lerp(cell100, other.cell100, t)!,
      cell60: Color.lerp(cell60, other.cell60, t)!,
      cell10: Color.lerp(cell10, other.cell10, t)!,
      raditz100: Color.lerp(raditz100, other.raditz100, t)!,
      raditz60: Color.lerp(raditz60, other.raditz60, t)!,
      raditz10: Color.lerp(raditz10, other.raditz10, t)!,
      nappa100: Color.lerp(nappa100, other.nappa100, t)!,
      nappa60: Color.lerp(nappa60, other.nappa60, t)!,
      nappa10: Color.lerp(nappa10, other.nappa10, t)!,
      whis100: Color.lerp(whis100, other.whis100, t)!,
      whis60: Color.lerp(whis60, other.whis60, t)!,
      whis10: Color.lerp(whis10, other.whis10, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonColors"))
      ..add(DiagnosticsProperty("piccolo", piccolo))
      ..add(DiagnosticsProperty("jiren", jiren))
      ..add(DiagnosticsProperty("hit", hit))
      ..add(DiagnosticsProperty("heles", heles))
      ..add(DiagnosticsProperty("beerus", beerus))
      ..add(DiagnosticsProperty("goku", goku))
      ..add(DiagnosticsProperty("gohan", gohan))
      ..add(DiagnosticsProperty("zeno", zeno))
      ..add(DiagnosticsProperty("bulma", bulma))
      ..add(DiagnosticsProperty("trunks", trunks))
      ..add(DiagnosticsProperty("goten", goten))
      ..add(DiagnosticsProperty("popo", popo))
      ..add(DiagnosticsProperty("krillin100", krillin100))
      ..add(DiagnosticsProperty("krillin60", krillin60))
      ..add(DiagnosticsProperty("krillin10", krillin10))
      ..add(DiagnosticsProperty("chiChi100", chiChi100))
      ..add(DiagnosticsProperty("chiChi60", chiChi60))
      ..add(DiagnosticsProperty("chiChi10", chiChi10))
      ..add(DiagnosticsProperty("roshi100", roshi100))
      ..add(DiagnosticsProperty("roshi60", roshi60))
      ..add(DiagnosticsProperty("roshi10", roshi10))
      ..add(DiagnosticsProperty("frieza100", frieza100))
      ..add(DiagnosticsProperty("frieza60", frieza60))
      ..add(DiagnosticsProperty("frieza10", frieza10))
      ..add(DiagnosticsProperty("dodoria100", dodoria100))
      ..add(DiagnosticsProperty("dodoria60", dodoria60))
      ..add(DiagnosticsProperty("dodoria10", dodoria10))
      ..add(DiagnosticsProperty("cell100", cell100))
      ..add(DiagnosticsProperty("cell60", cell60))
      ..add(DiagnosticsProperty("cell10", cell10))
      ..add(DiagnosticsProperty("raditz100", raditz100))
      ..add(DiagnosticsProperty("raditz60", raditz60))
      ..add(DiagnosticsProperty("raditz10", raditz10))
      ..add(DiagnosticsProperty("nappa100", nappa100))
      ..add(DiagnosticsProperty("nappa60", nappa60))
      ..add(DiagnosticsProperty("nappa10", nappa10))
      ..add(DiagnosticsProperty("whis100", whis100))
      ..add(DiagnosticsProperty("whis60", whis60))
      ..add(DiagnosticsProperty("whis10", whis10));
  }
}
