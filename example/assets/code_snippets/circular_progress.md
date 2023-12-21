import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonCircularProgress(
      value: 0.75,
      circularProgressSize: MoonCircularProgressSize.sm,
    );
  }
}

