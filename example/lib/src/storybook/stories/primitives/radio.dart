import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum ChoiceCustom { first, second }

enum ChoiceLabel { first, second }

class RadioStory extends StatefulWidget {
  static const path = '/primitives/radio';

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
      description: "MoonColors variants for selected MoonRadio.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeColor = colorTable(context)[activeColorKnob ?? 40];

    final inactiveColorKnob = context.knobs.nullable.options(
      label: "inactiveColor",
      description: "MoonColors variants for unselected MoonRadio.",
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
            ...List.generate(
              2,
              (int index) => MoonRadio(
                value: ChoiceCustom.values[index],
                groupValue: valueCustom,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                toggleable: isToggleableKnob,
                onChanged: isDisabledKnob
                    ? null
                    : (ChoiceCustom? choice) =>
                        setState(() => valueCustom = choice),
              ),
            ),
            const TextDivider(text: "MoonRadio with label"),
            ...List.generate(
              2,
              (int index) {
                final ChoiceLabel value = ChoiceLabel.values[index];
                final shouldReset = isToggleableKnob && valueLabel == value;

                return MoonMenuItem(
                  absorbGestures: true,
                  onTap: isDisabledKnob
                      ? null
                      : () => setState(
                            () => valueLabel = shouldReset ? null : value,
                          ),
                  label: Text("With label #${index + 1}"),
                  trailing: MoonRadio(
                    value: value,
                    groupValue: valueLabel,
                    toggleable: isToggleableKnob,
                    tapAreaSizeValue: 0,
                    onChanged: isDisabledKnob ? null : (_) {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
