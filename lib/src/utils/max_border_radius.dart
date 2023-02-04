import 'dart:math';

import 'package:flutter/material.dart';

double maxBorderRadius(BorderRadius borderRadius) {
  final maxRadiusValue = [
    max(borderRadius.topLeft.x, borderRadius.topLeft.y),
    max(borderRadius.topRight.x, borderRadius.topRight.y),
    max(borderRadius.bottomLeft.x, borderRadius.bottomLeft.y),
    max(borderRadius.bottomRight.x, borderRadius.bottomRight.y)
  ].reduce(max);

  return maxRadiusValue;
}
