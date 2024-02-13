import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CheckboxStory extends StatefulWidget {
  static const path = '/checkbox';

  const CheckboxStory({super.key});

  @override
  State<CheckboxStory> createState() => _CheckboxStoryState();
}

class _CheckboxStoryState extends State<CheckboxStory> {
  bool? checkboxValue = false;
  bool? checkboxWithLabelValue = false;

  @override
  Widget build(BuildContext context) {
    final checkColorKnob = context.knobs.nullable.options(
      label: "checkColor",
      description: "MoonColors variants for MoonCheckbox check icon.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final checkColor = colorTable(context)[checkColorKnob ?? 40];

    final activeColorKnob = context.knobs.nullable.options(
      label: "activeColor",
      description: "MoonColors variants for checked MoonCheckbox.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeColor = colorTable(context)[activeColorKnob ?? 40];

    final inactiveColorKnob = context.knobs.nullable.options(
      label: "inactiveColor",
      description: "MoonColors variants for unchecked MoonCheckbox.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveColor = colorTable(context)[inactiveColorKnob ?? 40];

    final borderColorKnob = context.knobs.nullable.options(
      label: "borderColor",
      description: "MoonColors variants for unchecked MoonCheckbox border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

    final isTristateKnob = context.knobs.boolean(
      label: "tristate",
      description: "Whether MoonCheckbox uses tristate.",
    );

    final isDisabledKnob = context.knobs.boolean(
      label: "Disabled",
      description: "MoonCheckbox onChanged() is null.",
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextDivider(
            text: "MoonCheckbox",
            paddingTop: 0,
          ),
          MoonCheckbox(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            checkColor: checkColor,
            borderColor: borderColor,
            tristate: isTristateKnob,
            value: checkboxValue,
            onChanged: isDisabledKnob ? null : (bool? newValue) => setState(() => checkboxValue = newValue),
          ),
          const TextDivider(text: "MoonCheckbox with label"),
          MoonMenuItem(
            onTap: isDisabledKnob
                ? null
                : () => setState(
                      () => switch (checkboxWithLabelValue) {
                        true when isTristateKnob => checkboxWithLabelValue = null,
                        false when isTristateKnob => checkboxWithLabelValue = true,
                        null => checkboxWithLabelValue = false,
                        _ => checkboxWithLabelValue = !checkboxWithLabelValue!,
                      },
                    ),
            label: const Text("With label"),
            trailing: MoonCheckbox(
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              checkColor: checkColor,
              tristate: isTristateKnob,
              value: checkboxWithLabelValue,
              tapAreaSizeValue: 0,
              onChanged: isDisabledKnob ? null : (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
