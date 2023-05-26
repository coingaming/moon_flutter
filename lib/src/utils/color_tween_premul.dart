import 'package:flutter/animation.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

// TODO: This will be unnecessary once Flutter finally moves from straight alpha to premultiplied alpha for color lerping.
class ColorTweenWithPremultipliedAlpha extends Tween<Color?> {
  /// Creates a [Color] tween with premultiplied alpha.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as transparent.
  ///
  /// We recommend that you do not pass [Colors.transparent] as [begin]
  /// or [end] if you want the effect of fading in or out of transparent.
  /// Instead prefer null. [Colors.transparent] refers to black transparent and
  /// thus will fade out of or into black which is likely unwanted.
  ColorTweenWithPremultipliedAlpha({super.begin, super.end});

  /// Returns the value this variable has at the given animation clock value.
  @override
  Color? lerp(double t) => colorPremulLerp(begin, end, t);
}
