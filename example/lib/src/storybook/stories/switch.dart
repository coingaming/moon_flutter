import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool value = false;

class SwitchStory extends Story {
  SwitchStory()
      : super(
          name: "Switch",
          builder: (BuildContext context) {
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
              description: "MoonColors variants for active MoonSwitch track.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final activeTrackColor = colorTable(context)[activeTrackColorKnob ?? 40];

            final inactiveTrackColorKnob = context.knobs.nullable.options(
              label: "inactiveTrackColor",
              description: "MoonColors variants for inactive MoonSwitch track.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final inactiveTrackColor = colorTable(context)[inactiveTrackColorKnob ?? 40];

            final isDisabled = context.knobs.boolean(
              label: "Disabled",
              description: "onChanged() is null.",
            );

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Column(
                  children: [
                    const TextDivider(
                      text: "Customisable MoonSwitch",
                      paddingTop: 0,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonSwitch(
                          switchSize: switchSizeKnob,
                          thumbColor: thumbColor,
                          activeTrackColor: activeTrackColor,
                          inactiveTrackColor: inactiveTrackColor,
                          value: value,
                          onChanged: isDisabled ? null : (bool newValue) => setState(() => value = newValue),
                        );
                      },
                    ),
                    const TextDivider(text: "MoonSwitches with custom children"),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonSwitch(
                          switchSize: switchSizeKnob,
                          activeThumbWidget: const MoonIcon(MoonIcons.check_alternative_16),
                          inactiveThumbWidget: const MoonIcon(MoonIcons.close_small_16),
                          activeTrackWidget: const Text(
                            "ON",
                            textAlign: TextAlign.center,
                          ),
                          inactiveTrackWidget: const Text(
                            "OFF",
                            textAlign: TextAlign.center,
                          ),
                          value: value,
                          onChanged: (bool newValue) => setState(() => value = newValue),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonSwitch(
                          switchSize: switchSizeKnob,
                          activeTrackWidget: const MoonIcon(MoonIcons.moon_16),
                          inactiveTrackWidget: const MoonIcon(MoonIcons.sun_16),
                          value: value,
                          onChanged: (bool newValue) => setState(() => value = newValue),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
