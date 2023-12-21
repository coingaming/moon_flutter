import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Checkbox extends StatefulWidget {
  const Checkbox({super.key});

  @override
  State<Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  bool? checkboxValue = false;
  bool? checkboxWithLabelValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonCheckbox(
          value: checkboxValue,
          onChanged: (bool? newValue) => setState(() => checkboxValue = newValue),
        ),
        MoonCheckbox.withLabel(
          context,
          value: checkboxWithLabelValue,
          label: "MoonCheckbox with label",
          onChanged: (bool? newValue) => setState(() => checkboxWithLabelValue = newValue),
        ),
      ],
    );
  }
}