import 'package:auto_route/auto_route.dart';
import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

@RoutePage()
class TagStory extends StatelessWidget {
  const TagStory({super.key});

  @override
  Widget build(BuildContext context) {
    final customLabelTextKnob = context.knobs.text(
      label: "Tag label text",
      initial: "MoonTag",
    );

    final tagSizeKnob = context.knobs.nullable.options(
      label: "tagSize",
      description: "Size variants for MoonTag.",
      enabled: false,
      initial: MoonTagSize.xs,
      options: const [
        Option(label: "x2s", value: MoonTagSize.x2s),
        Option(label: "xs", value: MoonTagSize.xs),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonTag text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final iconColorKnob = context.knobs.nullable.options(
      label: "Icon color",
      description: "MoonColors variants for MoonTag icon.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final iconColor = colorTable(context)[iconColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonTag background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonTag.",
      enabled: false,
      initial: 4,
      max: 32,
    );

    final showLeadingKnob = context.knobs.boolean(
      label: "leading",
      description: "Show widget in MoonTag leading slot.",
    );

    final showLabelKnob = context.knobs.boolean(
      label: "label",
      description: "Show widget in MoonTag label slot.",
      initial: true,
    );

    final showTrailingKnob = context.knobs.boolean(
      label: "trailing",
      description: "Show widget in MoonTag trailing slot.",
      initial: true,
    );

    final setUpperCase = context.knobs.boolean(
      label: "isUpperCase",
      description: "Sets the text style of MoonTag to upper case.",
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: MoonTag(
          borderRadius: borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
          onTap: () {},
          tagSize: tagSizeKnob,
          isUpperCase: setUpperCase,
          backgroundColor: backgroundColor,
          leading: showLeadingKnob
              ? MoonIcon(
                  MoonIcons.close_small_16,
                  color: iconColor,
                )
              : null,
          label: showLabelKnob
              ? Text(
                  setUpperCase ? customLabelTextKnob.toUpperCase() : customLabelTextKnob,
                  style: TextStyle(color: textColor),
                )
              : null,
          trailing: showTrailingKnob
              ? MoonIcon(
                  MoonIcons.close_small_16,
                  color: iconColor,
                )
              : null,
        ),
      ),
    );
  }
}
