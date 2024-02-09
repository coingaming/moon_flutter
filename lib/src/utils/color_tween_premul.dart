import 'package:flutter/animation.dart';

import 'package:moon_design/src/utils/color_premul_lerp.dart';

// TODO: Remove this once Flutter transitions from straight alpha to premultiplied alpha for color lerping.
class ColorTweenWithPremultipliedAlpha extends Tween<Color?> {
  /// Creates a [Color] tween with premultiplied alpha.
  ///
  /// The [begin] and [end] properties may be null to indicate transparency.
  /// It's discouraged to pass [Colors.transparent] as it may result in fading
  /// in or out of black, which may not be the intended effect.
  /// Instead, prefer using null to indicate transparency.
  ColorTweenWithPremultipliedAlpha({super.begin, super.end});

  /// Returns the value of this variable at the given animation clock value.
  @override
  Color? lerp(double t) => colorPremulLerp(begin, end, t);
}
