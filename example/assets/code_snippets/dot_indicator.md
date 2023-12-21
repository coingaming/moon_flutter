import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonDotIndicator(
      dotCount: 4,
      selectedDot: 2,
    );
  }
}