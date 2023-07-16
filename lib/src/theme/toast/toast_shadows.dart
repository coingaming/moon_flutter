import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonToastShadows extends ThemeExtension<MoonToastShadows> with DiagnosticableTreeMixin {
  /// Toast shadows.
  final List<BoxShadow> toastShadows;

  const MoonToastShadows({
    required this.toastShadows,
  });

  @override
  MoonToastShadows copyWith({List<BoxShadow>? toastShadows}) {
    return MoonToastShadows(
      toastShadows: toastShadows ?? this.toastShadows,
    );
  }

  @override
  MoonToastShadows lerp(ThemeExtension<MoonToastShadows>? other, double t) {
    if (other is! MoonToastShadows) return this;

    return MoonToastShadows(
      toastShadows: BoxShadow.lerpList(toastShadows, other.toastShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonToastShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("toastShadows", toastShadows));
  }
}
