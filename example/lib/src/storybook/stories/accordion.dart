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
          builder: (BuildContext context) {
            final accordionSizeKnob = context.knobs.nullable.options(
              label: "accordionSize",
              description: "Size variants for MoonAccordion.",
              enabled: false,
              initial: MoonAccordionSize.md,
              options: const [
                Option(label: "sm", value: MoonAccordionSize.sm),
                Option(label: "md", value: MoonAccordionSize.md),
                Option(label: "lg", value: MoonAccordionSize.lg),
                Option(label: "xl", value: MoonAccordionSize.xl),
              ],
            );

            final textColorKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonAccordion header text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorKnob ?? 40];

            final expandedTextColorKnob = context.knobs.nullable.options(
              label: "expandedTextColor",
              description: "MoonColors variants for expanded MoonAccordion header text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedTextColor = colorTable(context)[expandedTextColorKnob ?? 40];

            final contentTextColorKnob = context.knobs.nullable.options(
              label: "Content text color",
              description: "MoonColors variants for MoonAccordion content text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final contentTextColor = colorTable(context)[contentTextColorKnob ?? 40];

            final iconColorKnob = context.knobs.nullable.options(
              label: "iconColor",
              description: "MoonColors variants for MoonAccordion icon.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final iconColor = colorTable(context)[iconColorKnob ?? 40];

            final expandedIconColorKnob = context.knobs.nullable.options(
              label: "expandedIconColor",
              description: "MoonColors variants for expanded MoonAccordion icon.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedIconColor = colorTable(context)[expandedIconColorKnob ?? 40];

            final backgroundColorKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonAccordion background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

            final expandedBackgroundColorKnob = context.knobs.nullable.options(
              label: "expandedBackgroundColor",
              description: "MoonColors variants for expanded MoonAccordion background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final expandedBackgroundColor = colorTable(context)[expandedBackgroundColorKnob ?? 40];

            final borderColorKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonAccordion border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorKnob ?? 40];

            final dividerColorKnob = context.knobs.nullable.options(
              label: "dividerColor",
              description: "MoonColors variants for expanded MoonAccordion divider.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final dividerColor = colorTable(context)[dividerColorKnob ?? 40];

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

            const String contentText =
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

            final BorderRadiusGeometry? borderRadius =
                borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

            return StatefulBuilder(
              builder: (context, setState) {
                return ListView(
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.symmetric(vertical: 64),
                  children: [
                    const TextDivider(
                      text: "Grouped MoonAccordion",
                      paddingTop: 0,
                    ),
                    MoonAccordion<AccordionItems>(
                      identityValue: AccordionItems.first,
                      groupIdentityValue: currentlyOpenAccordionItem,
                      accordionSize: accordionSizeKnob,
                      textColor: textColor,
                      expandedTextColor: expandedTextColor,
                      iconColor: iconColor,
                      expandedIconColor: expandedIconColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius: borderRadius,
                      showBorder: showBorderKnob,
                      showDivider: showDividerKnob,
                      shadows: showShadowKnob == true ? null : [],
                      childrenPadding: const EdgeInsets.all(12),
                      onExpansionChanged: (value) => setState(() => currentlyOpenAccordionItem = value),
                      leading: const MoonIcon(MoonIcons.frame_24),
                      title: const Text("Grouped MoonAccordion item #1"),
                      children: [
                        Text(
                          contentText,
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    MoonAccordion<AccordionItems>(
                      identityValue: AccordionItems.second,
                      groupIdentityValue: currentlyOpenAccordionItem,
                      accordionSize: accordionSizeKnob,
                      textColor: textColor,
                      expandedTextColor: expandedTextColor,
                      iconColor: iconColor,
                      expandedIconColor: expandedIconColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius: borderRadius,
                      showBorder: showBorderKnob,
                      showDivider: showDividerKnob,
                      shadows: showShadowKnob == true ? null : [],
                      childrenPadding: const EdgeInsets.all(12),
                      onExpansionChanged: (value) => setState(() => currentlyOpenAccordionItem = value),
                      leading: const MoonIcon(MoonIcons.frame_24),
                      title: const Text("Grouped MoonAccordion item #2"),
                      children: [
                        Text(
                          contentText,
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                    const TextDivider(text: "Ungrouped MoonAccordion with content outside"),
                    MoonAccordion<AccordionItems>(
                      accordionSize: accordionSizeKnob,
                      initiallyExpanded: true,
                      hasContentOutside: true,
                      textColor: textColor,
                      expandedTextColor: expandedTextColor,
                      iconColor: iconColor,
                      expandedIconColor: expandedIconColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      borderRadius: borderRadius,
                      showBorder: showBorderKnob,
                      shadows: showShadowKnob == true ? null : [],
                      childrenPadding: const EdgeInsets.symmetric(vertical: 12),
                      title: const Text("Ungrouped MoonAccordion item #1"),
                      children: [
                        Text(
                          contentText,
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    MoonAccordion<AccordionItems>(
                      accordionSize: accordionSizeKnob,
                      hasContentOutside: true,
                      textColor: textColor,
                      expandedTextColor: expandedTextColor,
                      iconColor: iconColor,
                      expandedIconColor: expandedIconColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      expandedBackgroundColor: expandedBackgroundColor,
                      dividerColor: dividerColor,
                      borderRadius: borderRadius,
                      showBorder: showBorderKnob,
                      shadows: showShadowKnob == true ? null : [],
                      childrenPadding: const EdgeInsets.symmetric(vertical: 12),
                      title: const Text("Ungrouped MoonAccordion item #2"),
                      children: [
                        Text(
                          contentText,
                          style: TextStyle(color: contentTextColor),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
}
