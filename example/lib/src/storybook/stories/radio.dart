import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum ChoiceCustom { first, second }

enum ChoiceLabel { first, second }

class RadioStory extends StatefulWidget {
  static const path = '/radio';

  const RadioStory({super.key});

  @override
  State<RadioStory> createState() => _RadioStoryState();
}

class _RadioStoryState extends State<RadioStory> {
  ChoiceCustom? valueCustom = ChoiceCustom.first;
  ChoiceLabel? valueLabel = ChoiceLabel.first;

  @override
  Widget build(BuildContext context) {
    final activeColorKnob = context.knobs.nullable.options(
      label: "activeColor",
      description: "MoonColors variants for checked MoonRadio.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeColor = colorTable(context)[activeColorKnob ?? 40];

    final inactiveColorKnob = context.knobs.nullable.options(
      label: "inactiveColor",
      description: "MoonColors variants for unchecked MoonRadio.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveColor = colorTable(context)[inactiveColorKnob ?? 40];

    final isToggleableKnob = context.knobs.boolean(
      label: "toggleable",
      description: "Whether selected MoonRadio can be unselected.",
    );

    final isDisabledKnob = context.knobs.boolean(
      label: "Disabled",
      description: "MoonRadio onChanged() is null.",
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "MoonRadio",
              paddingTop: 0,
            ),
            MoonRadio(
              value: ChoiceCustom.first,
              groupValue: valueCustom,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              toggleable: isToggleableKnob,
              onChanged: isDisabledKnob ? null : (ChoiceCustom? choice) => setState(() => valueCustom = choice),
            ),
            const SizedBox(height: 8),
            MoonRadio(
              value: ChoiceCustom.second,
              groupValue: valueCustom,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              toggleable: isToggleableKnob,
              onChanged: isDisabledKnob ? null : (ChoiceCustom? choice) => setState(() => valueCustom = choice),
            ),
            const TextDivider(text: "MoonRadio with label"),
            MoonMenuItem(
              absorbGestures: true,
              onTap: isDisabledKnob
                  ? null
                  : () => setState(
                        () => switch (valueLabel) {
                          ChoiceLabel.first when isToggleableKnob => valueLabel = null,
                          _ => valueLabel = ChoiceLabel.first,
                        },
                      ),
              label: const Text("With label #1"),
              trailing: MoonRadio(
                value: ChoiceLabel.first,
                groupValue: valueLabel,
                toggleable: isToggleableKnob,
                tapAreaSizeValue: 0,
                onChanged: isDisabledKnob ? null : (_) {},
              ),
            ),
            const SizedBox(height: 8),
            MoonMenuItem(
              absorbGestures: true,
              onTap: isDisabledKnob
                  ? null
                  : () => setState(
                        () => switch (valueLabel) {
                          ChoiceLabel.second when isToggleableKnob => valueLabel = null,
                          _ => valueLabel = ChoiceLabel.second,
                        },
                      ),
              label: const Text("With label #2"),
              trailing: MoonRadio(
                value: ChoiceLabel.second,
                groupValue: valueLabel,
                toggleable: isToggleableKnob,
                tapAreaSizeValue: 0,
                onChanged: isDisabledKnob ? null : (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
