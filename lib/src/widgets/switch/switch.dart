import 'package:flutter/material.dart';

class MoonSwitch extends StatelessWidget {
  const MoonSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(value: true, onChanged: (bool newValue) {});
  }
}
