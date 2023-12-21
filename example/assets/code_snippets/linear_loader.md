import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class LinearLoader extends StatelessWidget {
  const LinearLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonLinearLoader(
      linearLoaderSize: MoonLinearLoaderSize.x4s,
    );
  }
}