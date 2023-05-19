import 'package:flutter/widgets.dart';

import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/utils/squircle/squircle_border_radius.dart';

class ClipSquircleRect extends StatelessWidget {
  const ClipSquircleRect({
    super.key,
    required this.child,
    this.radius = SquircleBorderRadius.zero,
    this.clipBehavior = Clip.antiAlias,
  });

  final SquircleBorderRadius radius;
  final Clip clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      clipBehavior: clipBehavior,
      shape: SquircleBorder(
        borderRadius: radius,
      ),
      child: child,
    );
  }
}
