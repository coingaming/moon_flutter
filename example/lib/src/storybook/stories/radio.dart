import 'package:auto_route/auto_route.dart';
import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum ChoiceCustom { first, second }

enum ChoiceLabel { first, second }

@RoutePage()
class RadioStory extends StatefulWidget {
  const RadioStory({super.key});

  @override
  State<RadioStory> createState() => _RadioStoryState();
}

class _RadioStoryState extends State<RadioStory> {
  ChoiceCustom? valueCustom = ChoiceCustom.first;
  ChoiceLabel? valueLabel = ChoiceLabel.first;

  @override
  Widget build(BuildContext context) {
    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonRadio with label text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

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
      description: "Whether the selected MoonRadio can be unselected.",
    );

    final isDisabledKnob = context.knobs.boolean(
      label: "Disabled",
      description: "onChanged() is null.",
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "Customisable MoonRadio buttons",
              paddingTop: 0,
            ),
            MoonRadio(
              value: ChoiceCustom.first,
              groupValue: valueCustom,
              onChanged: isDisabledKnob ? null : (ChoiceCustom? choice) => setState(() => valueCustom = choice),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              toggleable: isToggleableKnob,
            ),
            const SizedBox(height: 8),
            MoonRadio(
              value: ChoiceCustom.second,
              groupValue: valueCustom,
              onChanged: isDisabledKnob ? null : (ChoiceCustom? choice) => setState(() => valueCustom = choice),
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              toggleable: isToggleableKnob,
            ),
            const TextDivider(text: "MoonRadio buttons with clickable text"),
            MoonRadio.withLabel(
              context,
              textStyle: TextStyle(color: textColor),
              value: ChoiceLabel.first,
              groupValue: valueLabel,
              label: "With label #1",
              onChanged: isDisabledKnob ? null : (ChoiceLabel? choice) => setState(() => valueLabel = choice),
              toggleable: isToggleableKnob,
            ),
            const SizedBox(height: 8),
            MoonRadio.withLabel(
              context,
              textStyle: TextStyle(color: textColor),
              value: ChoiceLabel.second,
              groupValue: valueLabel,
              label: "With label #2",
              onChanged: isDisabledKnob ? null : (ChoiceLabel? choice) => setState(() => valueLabel = choice),
              toggleable: isToggleableKnob,
            ),
          ],
        ),
      ),
    );
  }
}
