import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

enum RadioSelection { first, second }

class Radio extends StatefulWidget {
  const Radio({super.key});

  @override
  State<Radio> createState() => _RadioState();
}

class _RadioState extends State<Radio> {
  RadioSelection? radioSelection = RadioSelection.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonRadio(
          value: RadioSelection.first,
          groupValue: radioSelection,
          onChanged: (RadioSelection? selection) => setState(() => radioSelection = selection),
        ),
        MoonMenuItem(
          label: const Text("MoonRadio with label"),
          onTap: () => setState(() => radioSelection = RadioSelection.second),
          trailing: MoonRadio(
            value: RadioSelection.second,
            groupValue: radioSelection,
            tapAreaSizeValue: 0,
            onChanged: (_) {},
          ),
        ),
      ],
    );
  }
}