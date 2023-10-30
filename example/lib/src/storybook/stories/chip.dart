import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ChipStory extends StatelessWidget {
  static const path = '/chip';

  const ChipStory({super.key});

  @override
  Widget build(BuildContext context) {
    final customLabelTextKnob = context.knobs.text(
      label: "Label text",
      initial: "MoonChip",
    );

    final chipSizeKnob = context.knobs.nullable.options(
      label: "chipSize",
      description: "Size variants for MoonChip.",
      enabled: false,
      initial: MoonChipSize.md,
      options: const [
        Option(label: "sm", value: MoonChipSize.sm),
        Option(label: "md", value: MoonChipSize.md),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "textColor",
      description: "MoonColors variants for MoonChip text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final activeColorKnob = context.knobs.nullable.options(
      label: "activeColor",
      description: "MoonColors variants for active MoonChip.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeColor = colorTable(context)[activeColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonChip background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final activeBackgroundColorKnob = context.knobs.nullable.options(
      label: "activeBackgroundColor",
      description: "MoonColors variants for active MoonChip background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeBackgroundColor = colorTable(context)[activeBackgroundColorKnob ?? 40];

    final borderColorKnob = context.knobs.nullable.options(
      label: "borderColor",
      description: "MoonColors variants for MoonChip border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

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

    final BorderRadiusGeometry? borderRadius =
        borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "Default MoonChip",
              paddingTop: 0,
            ),
            MoonChip(
              activeColor: activeColor,
              borderColor: borderColor,
              backgroundColor: backgroundColor,
              activeBackgroundColor: activeBackgroundColor,
              textColor: textColor,
              isActive: isActiveKnob,
              borderRadius: borderRadius,
              showBorder: showBorderKnob,
              chipSize: chipSizeKnob,
              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
              label: showLabelKnob ? Text(customLabelTextKnob) : null,
              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
            ),
            const TextDivider(text: "Text MoonChip"),
            MoonChip.text(
              activeBackgroundColor: activeBackgroundColor,
              borderColor: borderColor,
              textColor: textColor,
              isActive: isActiveKnob,
              borderRadius: borderRadius,
              showBorder: showBorderKnob,
              chipSize: chipSizeKnob,
              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
              label: showLabelKnob ? Text(customLabelTextKnob) : null,
              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
            ),
            const TextDivider(text: "Preset MoonChip"),
            MoonChip(
              isActive: isActiveKnob,
              activeColor: context.moonColors!.dodoria100,
              backgroundColor: context.moonColors!.krillin100,
              activeBackgroundColor: context.moonColors!.chiChi10,
              textColor: context.moonColors!.goten,
              borderWidth: 2,
              showBorder: showBorderKnob,
              chipSize: chipSizeKnob,
              leading: showLeadingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
              label: showLabelKnob ? Text(customLabelTextKnob) : null,
              trailing: showTrailingKnob ? const MoonIcon(MoonIcons.frame_24) : null,
            ),
          ],
        ),
      ),
    );
  }
}
