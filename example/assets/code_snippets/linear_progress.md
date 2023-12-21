import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonLinearProgress(
      value: 0.75,
      linearProgressSize: MoonLinearProgressSize.x4s,
    );
  }
}