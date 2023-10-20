import 'package:auto_route/auto_route.dart';
import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

@RoutePage()
class CheckboxStory extends StatefulWidget {
  const CheckboxStory({super.key});

  @override
  State<CheckboxStory> createState() => _CheckboxStoryState();
}

class _CheckboxStoryState extends State<CheckboxStory> {
  bool? checkboxValue = false;
  bool? checkboxWithLabelValue = false;

  @override
  Widget build(BuildContext context) {
    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonCheckbox with label text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final checkColorKnob = context.knobs.nullable.options(
      label: "checkColor",
      description: "MoonColors variants for MoonCheckbox icon.",
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
      description: "MoonColors variants for MoonCheckbox border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

    final isTristate = context.knobs.boolean(
      label: "tristate",
      description: "Whether MoonCheckbox uses tristate.",
    );

    final isDisabled = context.knobs.boolean(
      label: "Disabled",
      description: "onChanged() is null.",
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextDivider(
            text: "Customisable MoonCheckbox",
            paddingTop: 0,
          ),
          MoonCheckbox(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            checkColor: checkColor,
            borderColor: borderColor,
            tristate: isTristate,
            value: checkboxValue,
            onChanged: isDisabled ? null : (bool? newValue) => setState(() => checkboxValue = newValue),
          ),
          const TextDivider(text: "MoonCheckbox with clickable text"),
          MoonCheckbox.withLabel(
            context,
            label: "With label",
            textStyle: TextStyle(color: textColor),
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            checkColor: checkColor,
            tristate: isTristate,
            value: checkboxWithLabelValue,
            onChanged: isDisabled ? null : (bool? newValue) => setState(() => checkboxWithLabelValue = newValue),
          ),
        ],
      ),
    );
  }
}
