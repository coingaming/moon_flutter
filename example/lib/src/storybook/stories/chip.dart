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
              description: "Size variants for MoonChip.",
              enabled: false,
              initial: MoonChipSize.md,
              options: const [
                Option(label: "sm", value: MoonChipSize.sm),
                Option(label: "md", value: MoonChipSize.md),
              ],
            );

            final activeColorsKnob = context.knobs.nullable.options(
              label: "activeColor",
              description: "MoonColors variants for active MoonChip.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final activeColor = colorTable(context)[activeColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonChip background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final activeBackgroundColorsKnob = context.knobs.nullable.options(
              label: "activeBackgroundColor",
              description: "MoonColors variants for active MoonChip background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final activeBackgroundColor = colorTable(context)[activeBackgroundColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonChip border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for MoonChip text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonChip.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border when hovered, focused or isActive is true.",
            );
            final isActiveKnob = context.knobs.boolean(
              label: "isActive",
              description: "Whether MoonChip is active/selected.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonChip leading slot.",
              initial: true,
            );

            final showLabelKnob = context.knobs.boolean(
              label: "label",
              description: "Show widget in MoonChip label slot.",
              initial: true,
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonChip trailing slot.",
            );

            final resolvedIconVariant = chipSizesKnob == MoonChipSize.sm ? MoonIcons.frame_16 : MoonIcons.frame_24;

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Default MoonChip"),
                    const SizedBox(height: 32),
                    MoonChip(
                      activeColor: activeColor,
                      borderColor: borderColor,
                      backgroundColor: backgroundColor,
                      activeBackgroundColor: activeBackgroundColor,
                      textColor: textColor,
                      isActive: isActiveKnob,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      chipSize: chipSizesKnob,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Text MoonChip"),
                    const SizedBox(height: 32),
                    MoonChip.text(
                      activeBackgroundColor: activeBackgroundColor,
                      borderColor: borderColor,
                      textColor: textColor,
                      isActive: isActiveKnob,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      showBorder: showBorderKnob,
                      chipSize: chipSizesKnob,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Preset MoonChip"),
                    const SizedBox(height: 32),
                    MoonChip(
                      isActive: isActiveKnob,
                      activeColor: context.moonColors!.dodoria100,
                      backgroundColor: context.moonColors!.krillin100,
                      activeBackgroundColor: context.moonColors!.chiChi10,
                      textColor: context.moonTypography!.colors.controlPrimary,
                      borderWidth: 2,
                      showBorder: showBorderKnob,
                      chipSize: chipSizesKnob,
                      leading: showLeadingKnob ? MoonIcon(resolvedIconVariant) : null,
                      label: showLabelKnob ? Text(customLabelTextKnob) : null,
                      trailing: showTrailingKnob ? MoonIcon(resolvedIconVariant) : null,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
