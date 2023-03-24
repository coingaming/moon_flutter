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
              label: "Custom label text",
              initial: "MoonChip",
            );

            final chipSizesKnob = context.knobs.options(
              label: "MoonChipSize",
              description: "Chip size variants.",
              initial: MoonChipSize.md,
              options: const [
                Option(label: "sm", value: MoonChipSize.sm),
                Option(label: "md", value: MoonChipSize.md),
              ],
            );

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for the Chip.",
              initial: 5, // bulma
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 28,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for the Chip.",
            );

            final isActiveKnob = context.knobs.boolean(
              label: "isActive",
              description: "Whether the Chip is active/selected.",
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

            final resolvedIconVariant =
                chipSizesKnob == MoonChipSize.md ? MoonIconsOther.frame24 : MoonIconsOther.frame16;

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      const TextDivider(text: "Regular Chip"),
                      const SizedBox(height: 32),
                      MoonChip(
                        isActive: isActiveKnob,
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        showBorder: showBorderKnob,
                        chipSize: chipSizesKnob,
                        backgroundColor: color,
                        leftIcon: showLeftIconKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? Text(customLabelTextKnob) : null,
                        rightIcon: showRightIconKnob ? Icon(resolvedIconVariant) : null,
                      ),
                      const SizedBox(height: 40),
                      const TextDivider(text: "Text Chip"),
                      const SizedBox(height: 32),
                      MoonTextChip(
                        isActive: isActiveKnob,
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        showBorder: showBorderKnob,
                        chipSize: chipSizesKnob,
                        leftIcon: showLeftIconKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? Text(customLabelTextKnob) : null,
                        rightIcon: showRightIconKnob ? Icon(resolvedIconVariant) : null,
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
                        leftIcon: showLeftIconKnob ? Icon(resolvedIconVariant) : null,
                        label: showLabelKnob ? Text(customLabelTextKnob) : null,
                        rightIcon: showRightIconKnob ? Icon(resolvedIconVariant) : null,
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
