import 'package:example/src/storybook/common/options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AccordionStory extends Story {
  AccordionStory()
      : super(
          name: "Accordion",
          builder: (context) {
            final accordionSizesKnob = context.knobs.options(
              label: "MoonAccordionSize",
              description: "Accordion size variants.",
              initial: MoonAccordionSize.md,
              options: const [
                Option(label: "sm", value: MoonAccordionSize.sm),
                Option(label: "md", value: MoonAccordionSize.md),
                Option(label: "lg", value: MoonAccordionSize.lg),
                Option(label: "xl", value: MoonAccordionSize.xl)
              ],
            );

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for Accordion background.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final expandedBackgroundColorsKnob = context.knobs.options(
              label: "expandedBackgroundColor",
              description: "MoonColors variants for expanded Accordion background.",
              initial: 4, // gohan
              options: colorOptions,
            );

            final expandedBackgroundColor = colorTable(context)[expandedBackgroundColorsKnob];

            final showDividerKnob = context.knobs.boolean(
              label: "showDivider",
              description: "Show divider in the Accordion.",
              initial: true,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border around the Accordion.",
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadows",
              description: "Show shadows under the Accordion.",
              initial: true,
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: SizedBox(
                  height: 245,
                  child: Column(
                    children: [
                      MoonAccordion(
                        accordionSize: accordionSizesKnob,
                        backgroundColor: backgroundColor,
                        expandedBackgroundColor: expandedBackgroundColor,
                        showBorder: showBorderKnob,
                        showDivider: showDividerKnob,
                        shadows: showShadowKnob == true ? null : [],
                        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        title: const Text("Accordion title"),
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
}
