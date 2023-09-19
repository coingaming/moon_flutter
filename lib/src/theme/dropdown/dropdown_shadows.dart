import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonDropdownShadows extends ThemeExtension<MoonDropdownShadows> with DiagnosticableTreeMixin {
  /// Dropdown shadows.
  final List<BoxShadow> dropdownShadows;

  const MoonDropdownShadows({
    required this.dropdownShadows,
  });

  @override
  MoonDropdownShadows copyWith({List<BoxShadow>? dropdownShadows}) {
    return MoonDropdownShadows(
      dropdownShadows: dropdownShadows ?? this.dropdownShadows,
    );
  }

  @override
  MoonDropdownShadows lerp(ThemeExtension<MoonDropdownShadows>? other, double t) {
    if (other is! MoonDropdownShadows) return this;

    return MoonDropdownShadows(
      dropdownShadows: BoxShadow.lerpList(dropdownShadows, other.dropdownShadows, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonDropdownShadows"))
      ..add(DiagnosticsProperty<List<BoxShadow>>("dropdownShadows", dropdownShadows));
  }
}
