import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Checkbox extends StatefulWidget {
  const Checkbox({super.key});

  @override
  State<Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  bool? checkboxValue = false;
  bool checkboxWithLabelValue = false;
  bool? tristateCheckboxWithLabelValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonCheckbox(
          value: checkboxValue,
          onChanged: (bool? newValue) => setState(() => checkboxValue = newValue),
        ),
        MoonMenuItem(
          absorbGestures: true,
          onTap: () => setState(() => checkboxWithLabelValue = !checkboxWithLabelValue),
          label: const Text("MoonCheckbox with label"),
          trailing: MoonCheckbox(
            value: checkboxWithLabelValue,
            tapAreaSizeValue: 0,
            onChanged: (_) => {},
          ),
        ),
        MoonMenuItem(
          absorbGestures: true,
          onTap: () => setState(
            () => switch (tristateCheckboxWithLabelValue) {
              true => tristateCheckboxWithLabelValue = null,
              null => tristateCheckboxWithLabelValue = false,
              false => tristateCheckboxWithLabelValue = true,
            },
          ),
          label: const Text("Tristate MoonCheckbox with label"),
          trailing: MoonCheckbox(
            value: tristateCheckboxWithLabelValue,
            tapAreaSizeValue: 0,
            onChanged: (_) => {},
          ),
        ),
      ],
    );
  }
}