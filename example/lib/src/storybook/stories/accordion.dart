import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

enum AccordionItems { first, second }

AccordionItems? currentlyOpenAccordionItem = AccordionItems.first;

class AccordionStory extends Story {
  AccordionStory()
      : super(
          name: "Accordion",
          builder: (context) {
            final accordionSizesKnob = context.knobs.options(
              label: "MoonAccordionItemSize",
              description: "Accordion size variants.",
              initial: MoonAccordionItemSize.md,
              options: const [
                Option(label: "sm", value: MoonAccordionItemSize.sm),
                Option(label: "md", value: MoonAccordionItemSize.md),
                Option(label: "lg", value: MoonAccordionItemSize.lg),
                Option(label: "xl", value: MoonAccordionItemSize.xl)
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
              child: StatefulBuilder(
                builder: (context, setState) {
                  return ListView(
                    clipBehavior: Clip.none,
                    children: [
                      const SizedBox(height: 64),
                      const TextDivider(text: "Grouped accordion"),
                      const SizedBox(height: 32),
                      MoonAccordionItem<AccordionItems>(
                        identityValue: AccordionItems.first,
                        groupIdentityValue: currentlyOpenAccordionItem,
                        accordionSize: accordionSizesKnob,
                        backgroundColor: backgroundColor,
                        expandedBackgroundColor: expandedBackgroundColor,
                        showBorder: showBorderKnob,
                        showDivider: showDividerKnob,
                        shadows: showShadowKnob == true ? null : [],
                        childrenPadding: const EdgeInsets.all(12),
                        onExpansionChanged: (value) => setState(() => currentlyOpenAccordionItem = value),
                        leading: const Icon(MoonIcons.frame_24),
                        title: const Text("Grouped accordion item #1"),
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      MoonAccordionItem<AccordionItems>(
                        identityValue: AccordionItems.second,
                        groupIdentityValue: currentlyOpenAccordionItem,
                        initiallyExpanded: true,
                        accordionSize: accordionSizesKnob,
                        backgroundColor: backgroundColor,
                        expandedBackgroundColor: expandedBackgroundColor,
                        showBorder: showBorderKnob,
                        showDivider: showDividerKnob,
                        shadows: showShadowKnob == true ? null : [],
                        childrenPadding: const EdgeInsets.all(12),
                        onExpansionChanged: (value) => setState(() => currentlyOpenAccordionItem = value),
                        leading: const Icon(MoonIcons.frame_24),
                        title: const Text("Grouped accordion item #2"),
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const TextDivider(text: "Ungrouped accordion with content outside"),
                      const SizedBox(height: 32),
                      MoonAccordionItem<AccordionItems>(
                        accordionSize: accordionSizesKnob,
                        backgroundColor: backgroundColor,
                        initiallyExpanded: true,
                        hasContentOutside: true,
                        expandedBackgroundColor: expandedBackgroundColor,
                        showBorder: showBorderKnob,
                        showDivider: showDividerKnob,
                        shadows: showShadowKnob == true ? null : [],
                        childrenPadding: const EdgeInsets.symmetric(vertical: 12),
                        title: const Text("Ungrouped accordion item #1"),
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      MoonAccordionItem<AccordionItems>(
                        accordionSize: accordionSizesKnob,
                        backgroundColor: backgroundColor,
                        hasContentOutside: true,
                        expandedBackgroundColor: expandedBackgroundColor,
                        showBorder: showBorderKnob,
                        showDivider: showDividerKnob,
                        shadows: showShadowKnob == true ? null : [],
                        childrenPadding: const EdgeInsets.symmetric(vertical: 12),
                        title: const Text("Ungrouped accordion item #2"),
                        children: const [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                    ],
                  );
                },
              ),
            );
          },
        );
}
