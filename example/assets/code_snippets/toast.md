import 'package:flutter/material.dart'; 
import 'package:moon_design/moon_design.dart';

class Toast extends StatelessWidget { 
  const Toast({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonFilledButton(
      onTap: () => MoonToast.show(
        context,
        label: const Text('This is MoonToast'),
      ),
      label: const Text("Show MoonToast"),
    );
  }
}