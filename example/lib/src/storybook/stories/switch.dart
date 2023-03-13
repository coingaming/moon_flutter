import 'package:example/src/storybook/common/options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class SwitchStory extends Story {
  SwitchStory()
      : super(
          name: "Switch",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "Custom label text",
              initial: "MoonSwitch",
            );

            /* final chipSizesKnob = context.knobs.options(
              label: "MoonSwitchSize",
              description: "Switch size variants.",
              initial: MoonSwitchSize.md,
              options: const [
                Option(label: "sm", value: MoonSwitchSize.sm),
                Option(label: "md", value: MoonSwitchSize.md),
              ],
            ); */

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for the Switch.",
              initial: 5, // bulma
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 28,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for the Switch.",
            );

            final isActiveKnob = context.knobs.boolean(
              label: "isActive",
              description: "Whether the Switch is active/selected.",
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border when isActive.",
            );

            final showLeftIconKnob = context.knobs.boolean(
              label: "Show leftIcon",
              description: "Show widget in the leftIcon slot.",
              initial: true,
            );

            final showLabelKnob = context.knobs.boolean(
              label: "Show label",
              description: "Show widget in the label slot.",
              initial: true,
            );

            final showRightIconKnob = context.knobs.boolean(
              label: "Show rightIcon",
              description: "Show widget in the rightIcon slot.",
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            /* final resolvedIconVariant =
                chipSizesKnob == MoonSwitchSize.md ? MoonIconsOther.frame24 : MoonIconsOther.frame16; */

            bool value = true;

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Regular Switch"),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return MoonSwitch(
                          activeThumbWidget: Icon(MoonIconsGeneric.check_alternative24),
                          inactiveThumbWidget: Icon(MoonIconsControls.close24),
                          value: value,
                          onChanged: (newValue) => setState(() => value = newValue),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return CupertinoSwitch(value: value, onChanged: (newValue) => setState(() => value = newValue));
                      },
                    ),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Switch(value: value, onChanged: (newValue) => setState(() => value = newValue));
                      },
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
