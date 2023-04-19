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

            final chipSizesKnob = context.knobs.options(
              label: "chipSize",
              description: "Chip size variants.",
              initial: MoonChipSize.md,
              options: const [
                Option(label: "sm", value: MoonChipSize.sm),
                Option(label: "md", value: MoonChipSize.md),
              ],
            );

            final textColorsKnob = context.knobs.options(
              label: "textColor",
              description: "MoonColors variants for Chip text.",
              initial: 40, // null
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob];

            final activeColorsKnob = context.knobs.options(
              label: "activeColor",
              description: "MoonColors variants for the active Chip.",
              initial: 40, // null
              options: colorOptions,
            );

            final activeColor = colorTable(context)[activeColorsKnob];

            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for the Chip background.",
              initial: 40, // null
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final borderColorsKnob = context.knobs.options(
              label: "borderColor",
              description: "MoonColors variants for Chip border.",
              initial: 40, // null
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 28,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for the Chip.",
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

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            final resolvedIconVariant = chipSizesKnob == MoonChipSize.md ? MoonIcons.frame_24 : MoonIcons.frame_16;

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
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
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
              ),
            );
          },
        );
}
