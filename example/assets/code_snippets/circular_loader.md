import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonCircularLoader(
      circularLoaderSize: MoonCircularLoaderSize.sm,
    );
  }
}