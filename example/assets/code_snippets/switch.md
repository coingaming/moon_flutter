import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Switch extends StatefulWidget {
  const Switch({super.key});

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return MoonSwitch(
      value: switchValue,
      switchSize: MoonSwitchSize.sm,
      onChanged: (bool newValue) => setState(() => switchValue = newValue),
    );
  }
}