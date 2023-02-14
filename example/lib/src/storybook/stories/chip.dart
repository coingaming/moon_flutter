import 'package:example/src/storybook/common/options.dart';
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

            final colorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for the chip.",
              initial: 5, // bulma
              options: colorOptions,
            );

            final color = colorTable(context)[colorsKnob];

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border for the chip.",
              initial: true,
            );

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 28,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for the chip.",
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

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
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

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      MoonChip(
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        showBorder: showBorderKnob,
                        chipSize: chipSizesKnob,
                        backgroundColor: color,
                        leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                        label: showLabelKnob ? Text(customLabelTextKnob) : null,
                        rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
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
