import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class SwitchStory extends StatefulWidget {
  static const path = '/switch';

  const SwitchStory({super.key});

  @override
  State<SwitchStory> createState() => _SwitchStoryState();
}

class _SwitchStoryState extends State<SwitchStory> {
  bool switchValue = false;
  bool switchTextValue = false;
  bool switchIconValue = false;

  @override
  Widget build(BuildContext context) {
    final switchSizeKnob = context.knobs.nullable.options(
      label: "switchSize",
      description: "Size variants for MoonSwitch.",
      enabled: false,
      initial: MoonSwitchSize.xs,
      options: const [
        Option(label: "x2s", value: MoonSwitchSize.x2s),
        Option(label: "xs", value: MoonSwitchSize.xs),
        Option(label: "sm", value: MoonSwitchSize.sm),
      ],
    );

    final thumbColorKnob = context.knobs.nullable.options(
      label: "thumbColor",
      description: "MoonColors variants for MoonSwitch thumb.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final thumbColor = colorTable(context)[thumbColorKnob ?? 40];

    final activeTrackColorKnob = context.knobs.nullable.options(
      label: "activeTrackColor",
      description: "MoonColors variants for MoonSwitch active track.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeTrackColor = colorTable(context)[activeTrackColorKnob ?? 40];

    final inactiveTrackColorKnob = context.knobs.nullable.options(
      label: "inactiveTrackColor",
      description: "MoonColors variants for MoonSwitch inactive track.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveTrackColor = colorTable(context)[inactiveTrackColorKnob ?? 40];

    final isDisabled = context.knobs.boolean(
      label: "Disabled",
      description: "MoonSwitch onChanged() is null.",
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "MoonSwitch",
              paddingTop: 0,
            ),
            MoonSwitch(
              switchSize: switchSizeKnob,
              thumbColor: thumbColor,
              activeTrackColor: activeTrackColor,
              inactiveTrackColor: inactiveTrackColor,
              value: switchValue,
              onChanged: isDisabled ? null : (bool newValue) => setState(() => switchValue = newValue),
            ),
            const TextDivider(text: "Customized MoonSwitch"),
            MoonSwitch(
              switchSize: switchSizeKnob,
              activeThumbWidget: const Icon(MoonIcons.generic_check_alternative_16_regular),
              inactiveThumbWidget: const Icon(MoonIcons.controls_close_small_16_regular),
              activeTrackWidget: const Text(
                "ON",
                textAlign: TextAlign.center,
              ),
              inactiveTrackWidget: const Text(
                "OFF",
                textAlign: TextAlign.center,
              ),
              value: switchTextValue,
              onChanged: (bool newValue) => setState(() => switchTextValue = newValue),
            ),
            const SizedBox(height: 32),
            MoonSwitch(
              switchSize: switchSizeKnob,
              activeTrackWidget: const Icon(MoonIcons.other_moon_16_regular),
              inactiveTrackWidget: const Icon(MoonIcons.other_sun_16_regular),
              value: switchIconValue,
              onChanged: (bool newValue) => setState(() => switchIconValue = newValue),
            ),
          ],
        ),
      ),
    );
  }
}
