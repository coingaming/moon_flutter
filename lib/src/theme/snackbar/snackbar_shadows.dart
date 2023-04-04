import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/shadows.dart';

@immutable
class MoonSnackbarShadows extends ThemeExtension<MoonSnackbarShadows> with DiagnosticableTreeMixin {
  static final light = MoonSnackbarShadows(
    shadows: MoonShadows.light.sm,
  );

  static final dark = MoonSnackbarShadows(
    shadows: MoonShadows.dark.sm,
  );

  /// Snackbar item shadows.
  final List<BoxShadow> shadows;

  const MoonSnackbarShadows({
    required this.shadows,
  });

  @override
  MoonSnackbarShadows copyWith({List<BoxShadow>? shadows}) {
    return MoonSnackbarShadows(
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  MoonSnackbarShadows lerp(ThemeExtension<MoonSnackbarShadows>? other, double t) {
    if (other is! MoonSnackbarShadows) return this;

    return MoonSnackbarShadows(
      shadows: BoxShadow.lerpList(shadows, other.shadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonSnackbarShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("shadows", shadows));
  }
}
