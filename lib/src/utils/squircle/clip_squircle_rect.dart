import 'package:flutter/widgets.dart';

import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';

class MoonClipSquircleRect extends StatelessWidget {
  final MoonSquircleBorderRadius radius;
  final Clip clipBehavior;
  final Widget? child;

  const MoonClipSquircleRect({
    super.key,
    required this.child,
    this.radius = MoonSquircleBorderRadius.zero,
    this.clipBehavior = Clip.antiAlias,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      clipBehavior: clipBehavior,
      shape: MoonSquircleBorder(
        borderRadius: radius,
      ),
      child: child,
    );
  }
}
