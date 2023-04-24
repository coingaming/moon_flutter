import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ChipStory extends Story {
  ChipStory()
      : super(
          name: "Chip",
          builder: (context) {
            final customLabelTextKnob = context.knobs.text(
              label: "label text",
              initial: "MoonChip",
            );

            final chipSizesKnob = context.knobs.nullable.options(
              label: "chipSize",
              description: "Chip size variants.",
              enabled: false,
              initial: MoonChipSize.md,
              options: const [
                Option(label: "sm", value: MoonChipSize.sm),
                Option(label: "md", value: MoonChipSize.md),
              ],
            );

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for Chip text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final activeColorsKnob = context.knobs.nullable.options(
              label: "activeColor",
              description: "MoonColors variants for the active Chip.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeColor = colorTable(context)[activeColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for the Chip background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for Chip border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for the Chip.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border when isActive.",
            );

            final isActiveKnob = context.knobs.boolean(
              label: "isActive",
              description: "Whether the Chip is active/selected.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in the leading slot.",
              initial: true,
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in the label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in the trailing slot.",
            );

            final resolvedIconVariant = chipSizesKnob == MoonChipSize.md ? MoonIcons.frame_24 : MoonIcons.frame_16;

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Default Chip"),
                    const SizedBox(height: 32),
                    MoonChip(
                      activeColor: activeColor,
                      textColor: textColor,
                      borderColor: borderColor,
                      isActive: isActiveKnob,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      chipSize: chipSizesKnob,
                      backgroundColor: backgroundColor,
                      leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Text Chip"),
                    const SizedBox(height: 32),
                    MoonTextChip(
                      isActive: isActiveKnob,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      chipSize: chipSizesKnob,
                      leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Preset Chip"),
                    const SizedBox(height: 32),
                    MoonChip(
                      isActive: isActiveKnob,
                      activeColor: context.moonColors!.dodoria100,
                      backgroundColor: context.moonColors!.krillin100,
                      hoverEffectColor: context.moonColors!.chiChi10,
                      borderWidth: 2,
                      showBorder: showBorderKnob,
                      chipSize: chipSizesKnob,
                      leading: showLeadingKnob ? Icon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? Icon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
