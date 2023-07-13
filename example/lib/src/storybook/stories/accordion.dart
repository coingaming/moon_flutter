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
              description: "Size variants for MoonAccordion.",
              enabled: false,
              initial: MoonAccordionItemSize.md,
              options: const [
                Option(label: "sm", value: MoonAccordionItemSize.sm),
                Option(label: "md", value: MoonAccordionItemSize.md),
                Option(label: "lg", value: MoonAccordionItemSize.lg),
                Option(label: "xl", value: MoonAccordionItemSize.xl)
              ],
            );

            final leadingColorsKnob = context.knobs.nullable.options(
              label: "leadingColor",
              description: "MoonColors variants for MoonAccordion leading.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final leadingColor = colorTable(context)[leadingColorsKnob ?? 40];

            final expandedLeadingColorsKnob = context.knobs.nullable.options(
              label: "expandedLeadingColor",
              description: "MoonColors variants for expanded MoonAccordion leading.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedLeadingColor = colorTable(context)[expandedLeadingColorsKnob ?? 40];

            final labelColorsKnob = context.knobs.nullable.options(
              label: "labelColor",
              description: "MoonColors variants for MoonAccordion label.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final labelColor = colorTable(context)[labelColorsKnob ?? 40];

            final expandedLabelColorsKnob = context.knobs.nullable.options(
              label: "expandedLabelColor",
              description: "MoonColors variants for expanded MoonAccordion label.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedLabelColor = colorTable(context)[expandedLabelColorsKnob ?? 40];

            final trailingColorsKnob = context.knobs.nullable.options(
              label: "trailingColor",
              description: "MoonColors variants for MoonAccordion trailing.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final trailingColor = colorTable(context)[trailingColorsKnob ?? 40];

            final expandedTrailingColorsKnob = context.knobs.nullable.options(
              label: "expandedTrailingColor",
              description: "MoonColors variants for expanded MoonAccordion trailing.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedTrailingColor = colorTable(context)[expandedTrailingColorsKnob ?? 40];

            final contentTextColorsKnob = context.knobs.nullable.options(
              label: "Content color",
              description: "MoonColors variants for MoonAccordion content.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final contentTextColor = colorTable(context)[contentTextColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonAccordion background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final expandedBackgroundColorsKnob = context.knobs.nullable.options(
              label: "expandedBackgroundColor",
              description: "MoonColors variants for expanded MoonAccordion background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedBackgroundColor = colorTable(context)[expandedBackgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonAccordion border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final dividerColorsKnob = context.knobs.nullable.options(
              label: "dividerColor",
              description: "MoonColors variants for expanded MoonAccordion divider.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final dividerColor = colorTable(context)[dividerColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonAccordion.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border around MoonAccordion.",
            );

            final showDividerKnob = context.knobs.boolean(
              label: "showDivider",
              description: "Show divider between MoonAccordion header and body.",
              initial: true,
            );

            final showShadowKnob = context.knobs.boolean(
              label: "Show shadows",
              description: "Show shadows under MoonAccordion.",
              initial: true,
            );

            return StatefulBuilder(
              builder: (context, setState) {
                return ListView(
                  clipBehavior: Clip.none,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Grouped MoonAccordion"),
                    const SizedBox(height: 32),
                    MoonAccordionItem<AccordionItems>(
                      identityValue: AccordionItems.first,
                      groupIdentityValue: currentlyOpenAccordionItem,
                      accordionSize: accordionSizesKnob,
                      leadingColor: leadingColor,
                      expandedLeadingColor: expandedLeadingColor,
                      titleColor: labelColor,
                      expandedTitleColor: expandedLabelColor,
                      trailingColor: trailingColor,
                      expandedTrailingColor: expandedTrailingColor,
                      borderColor: borderColor,
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
                      leading: const MoonIcon(MoonIcons.frame_24),
                      title: const Text("Grouped MoonAccordion item #1"),
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    MoonAccordionItem<AccordionItems>(
                      identityValue: AccordionItems.second,
                      groupIdentityValue: currentlyOpenAccordionItem,
                      initiallyExpanded: true,
                      accordionSize: accordionSizesKnob,
                      leadingColor: leadingColor,
                      expandedLeadingColor: expandedLeadingColor,
                      titleColor: labelColor,
                      expandedTitleColor: expandedLabelColor,
                      trailingColor: trailingColor,
                      expandedTrailingColor: expandedTrailingColor,
                      borderColor: borderColor,
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
                      leading: const MoonIcon(MoonIcons.frame_24),
                      title: const Text("Grouped MoonAccordion item #2"),
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Ungrouped MoonAccordion with content outside"),
                    const SizedBox(height: 32),
                    MoonAccordionItem<AccordionItems>(
                      accordionSize: accordionSizesKnob,
                      initiallyExpanded: true,
                      hasContentOutside: true,
                      leadingColor: leadingColor,
                      expandedLeadingColor: expandedLeadingColor,
                      titleColor: labelColor,
                      expandedTitleColor: expandedLabelColor,
                      trailingColor: trailingColor,
                      expandedTrailingColor: expandedTrailingColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      shadows: showShadowKnob == true ? null : [],
                      childrenPadding: const EdgeInsets.symmetric(vertical: 12),
                      title: const Text("Ungrouped MoonAccordion item #1"),
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    MoonAccordionItem<AccordionItems>(
                      accordionSize: accordionSizesKnob,
                      hasContentOutside: true,
                      leadingColor: leadingColor,
                      expandedLeadingColor: expandedLeadingColor,
                      titleColor: labelColor,
                      expandedTitleColor: expandedLabelColor,
                      trailingColor: trailingColor,
                      expandedTrailingColor: expandedTrailingColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      shadows: showShadowKnob == true ? null : [],
                      childrenPadding: const EdgeInsets.symmetric(vertical: 12),
                      title: const Text("Ungrouped MoonAccordion item #2"),
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: TextStyle(color: contentTextColor),
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
