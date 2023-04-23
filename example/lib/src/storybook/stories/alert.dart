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
            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final textColorsKnob = context.knobs.nullable.options(
              label: "textColor",
              description: "MoonColors variants for text.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final leadingColorsKnob = context.knobs.nullable.options(
              label: "leadingColor",
              description: "MoonColors variants for leading.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final leadingColor = colorTable(context)[leadingColorsKnob ?? 40];

            final trailingColorsKnob = context.knobs.nullable.options(
              label: "trailingColor",
              description: "MoonColors variants for trailing.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final trailingColor = colorTable(context)[trailingColorsKnob ?? 40];

            final borderColorsKnob = context.knobs.nullable.options(
              label: "borderColor",
              description: "MoonColors variants for border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for Alert.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final showBorderKnob = context.knobs.boolean(
              label: "showBorder",
              description: "Show border for Alert.",
            );

            final showLeadingKnob = context.knobs.boolean(
              label: "leading",
              description: "Show widget in the leading slot.",
              initial: true,
            );

            final showBodyKnob = context.knobs.boolean(
              label: "body",
              description: "Show widget in the body slot.",
            );

            final showTrailingKnob = context.knobs.boolean(
              label: "trailing",
              description: "Show widget in the trailing slot.",
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
                    const TextDivider(text: "Base Alert"),
                    const SizedBox(height: 32),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            MoonAlert(
                              show: showAlert,
                              title: const SizedBox(
                                height: 24,
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text("Base Alert"),
                                ),
                              ),
                              borderRadius:
                                  borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                              leading: showLeadingKnob ? const Icon(MoonIcons.frame_24) : null,
                              trailing: showTrailingKnob
                                  ? MoonButton.icon(
                                      buttonSize: MoonButtonSize.xs,
                                      borderRadius: borderRadiusKnob != null
                                          ? BorderRadius.circular(borderRadiusKnob.toDouble())
                                          : null,
                                      disabledOpacityValue: 1,
                                      icon: Icon(
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
                              backgroundColor: backgroundColor,
                              showBorder: showBorderKnob,
                              leadingColor: leadingColor,
                              trailingColor: trailingColor,
                              textColor: textColor,
                              borderColor: borderColor,
                              body: showBodyKnob
                                  ? const SizedBox(
                                      height: 24,
                                      child: Align(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text("Here goes Alert body"),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            MoonFilledButton(
                              label: const Text("Show/Hide Alert"),
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
                    const TextDivider(text: "Filled Alert variant"),
                    const SizedBox(height: 32),
                    MoonFilledAlert(
                      show: true,
                      title: const Text("Filled error Alert"),
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const Icon(MoonIcons.alert_24) : null,
                      color: context.moonColors!.chiChi100,
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes Alert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 16),
                    MoonFilledAlert(
                      show: true,
                      title: const Text("Filled warning Alert"),
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const Icon(MoonIcons.alarm_round_24) : null,
                      color: context.moonColors!.krillin100,
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes Alert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 40),
                    const TextDivider(text: "Outlined Alert variant"),
                    const SizedBox(height: 32),
                    MoonOutlinedAlert(
                      show: true,
                      title: const Text("Outlined success Alert"),
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const Icon(MoonIcons.check_rounded_24) : null,
                      color: context.moonColors!.roshi100,
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes Alert body"),
                              ),
                            )
                          : null,
                      onTrailingTap: () {},
                    ),
                    const SizedBox(height: 16),
                    MoonOutlinedAlert(
                      show: true,
                      title: const Text('Outlined info Alert'),
                      borderRadius:
                          borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                      leading: showLeadingKnob ? const Icon(MoonIcons.alert_24) : null,
                      color: context.moonColors!.whis100,
                      body: showBodyKnob
                          ? const SizedBox(
                              height: 24,
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text("Here goes Alert body"),
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
