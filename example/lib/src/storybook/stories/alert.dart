import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool showAlert = true;

class AlertStory extends Story {
  AlertStory()
      : super(
          name: "Alert",
          builder: (context) {
            final leadingColorsKnob = context.knobs.nullable.options(
              label: "Leading Color",
              description: "MoonColors variants for MoonAlert leading.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final leadingColor = colorTable(context)[leadingColorsKnob ?? 40];

            final titleColorsKnob = context.knobs.nullable.options(
              label: "Title color",
              description: "MoonColors variants for MoonAlert title.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final titleColor = colorTable(context)[titleColorsKnob ?? 40];

            final trailingColorsKnob = context.knobs.nullable.options(
              label: "Trailing color",
              description: "MoonColors variants for MoonAlert trailing.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final trailingColor = colorTable(context)[trailingColorsKnob ?? 40];

            final bodyColorsKnob = context.knobs.nullable.options(
              label: "Body color",
              description: "MoonColors variants for MoonAlert body.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final bodyColor = colorTable(context)[bodyColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonAlert background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];


            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for MoonAlert border.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonAlert.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border for MoonAlert.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in MoonAlert leading slot.",
              initial: true,
            );

            final showBodyKnob = context.knobs.boolean(
              label: "body",
              description: "Show widget in MoonAlert body slot.",
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in MoonAlert trailing slot.",
              initial: true,
            );

            final showDisabledKnob = context.knobs.boolean(
              label: "Disabled",
              description: "onTrailingTap() is null.",
            );

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    const TextDivider(text: "Base MoonAlert"),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            MoonAlert(
                              show: showAlert,
                              showBorder: showBorderKnob,
                              borderColor: borderColor,
                              backgroundColor: backgroundColor,
                              borderRadius:
                                  borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                              leading: showLeadingKnob
                                  ? MoonIcon(
                                      MoonIcons.frame_24,
                                      color: leadingColor,
                                    )
                                  : null,
                              title: SizedBox(
                                height: 24,
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    "Base MoonAlert",
                                    style: TextStyle(color: titleColor),
                                  ),
                                ),
                              ),
                              trailing: showTrailingKnob
                                  ? MoonButton.icon(
                                      buttonSize: MoonButtonSize.xs,
                                      borderRadius: borderRadiusKnob != null
                                          ? BorderRadius.circular(borderRadiusKnob.toDouble())
                                          : null,
                                      disabledOpacityValue: 1,
                                      icon: MoonIcon(
                                        MoonIcons.close_small_24,
                                        color: trailingColor,
                                        size: 24,
                                      ),
                                      gap: 0,
                                      onTap: showDisabledKnob
                                          ? null
                                          : () {
                                              setState(() => showAlert = !showAlert);
                                            },
                                    )
                                  : null,
                              body: showBodyKnob
                                  ? SizedBox(
                                      height: 24,
                                      child: Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text(
                                          "Here goes MoonAlert body",
                                          style: TextStyle(color: bodyColor),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            MoonFilledButton(
                              label: const Text("Show/Hide MoonAlert"),
                              backgroundColor: context.moonColors!.piccolo,
                              onTap: () {
                                setState(() => showAlert = !showAlert);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Filled MoonAlert variant"),
                    const SizedBox(height: 32),
                    MoonFilledAlert(
                      show: true,
                      color: context.moonColors!.chiChi100,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const MoonIcon(MoonIcons.alert_24) : null,
                      title: const Text("Filled error MoonAlert"),
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes MoonAlert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 16),
                    MoonFilledAlert(
                      show: true,
                      color: context.moonColors!.krillin100,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const MoonIcon(MoonIcons.alarm_round_24) : null,
                      title: const Text("Filled warning MoonAlert"),
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes MoonAlert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Outlined MoonAlert variant"),
                    const SizedBox(height: 32),
                    MoonOutlinedAlert(
                      show: true,
                      color: context.moonColors!.roshi100,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const MoonIcon(MoonIcons.check_rounded_24) : null,
                      title: const Text("Outlined success MoonAlert"),
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes MoonAlert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 16),
                    MoonOutlinedAlert(
                      show: true,
                      color: context.moonColors!.whis100,
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const MoonIcon(MoonIcons.alert_24) : null,
                      title: const Text('Outlined info MoonAlert'),
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes MoonAlert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
}
