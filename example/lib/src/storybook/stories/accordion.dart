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
            final accordionSizesKnob = context.knobs.nullable.options(
              label: "accordionSize",
              description: "Accordion size variants.",
              enabled: false,
              initial: MoonAccordionItemSize.md,
              options: const [
                Option(label: "sm", value: MoonAccordionItemSize.sm),
                Option(label: "md", value: MoonAccordionItemSize.md),
                Option(label: "lg", value: MoonAccordionItemSize.lg),
                Option(label: "xl", value: MoonAccordionItemSize.xl)
              ],
            );

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for Accordion text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final iconColorsKnob = context.knobs.nullable.options(
              label: "iconColor",
              description: "MoonColors variants for Accordion trailing icon.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final iconColor = colorTable(context)[iconColorsKnob ?? 40];

            final expandedIconColorsKnob = context.knobs.nullable.options(
              label: "expandedIconColor",
              description: "MoonColors variants for expanded Accordion trailing icon.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final expandedIconColor = colorTable(context)[expandedIconColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for Accordion background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final expandedBackgroundColorsKnob = context.knobs.nullable.options(
              label: "expandedBackgroundColor",
              description: "MoonColors variants for expanded Accordion background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final expandedBackgroundColor = colorTable(context)[expandedBackgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for Accordion border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final dividerColorsKnob = context.knobs.nullable.options(
              label: "dividerColor",
              description: "MoonColors variants for expanded Accordion divider.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final dividerColor = colorTable(context)[dividerColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for Accordion.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border around the Accordion.",
            );

            final showDividerKnob = context.knobs.boolean(
              label: "showDivider",
              description: "Show divider between Accordion header and body.",
              initial: true,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadows",
              description: "Show shadows under the Accordion.",
              initial: true,
            );

            return StatefulBuilder(
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
                      textColor: textColor,
                      borderColor: borderColor,
                      trailingIconColor: iconColor,
                      expandedTrailingIconColor: expandedIconColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
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
                      textColor: textColor,
                      borderColor: borderColor,
                      trailingIconColor: iconColor,
                      expandedTrailingIconColor: expandedIconColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
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
                      initiallyExpanded: true,
                      hasContentOutside: true,
                      textColor: textColor,
                      borderColor: borderColor,
                      trailingIconColor: iconColor,
                      expandedTrailingIconColor: expandedIconColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
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
                      hasContentOutside: true,
                      textColor: textColor,
                      borderColor: borderColor,
                      trailingIconColor: iconColor,
                      expandedTrailingIconColor: expandedIconColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
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
            );
          },
        );
}
