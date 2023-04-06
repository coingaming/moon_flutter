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
            final backgroundColorsKnob = context.knobs.options(
              label: "backgroundColor",
              description: "MoonColors variants for background.",
              initial: 4, // Gohan
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob];

            final textColorsKnob = context.knobs.options(
              label: "textColor",
              description: "MoonColors variants for text.",
              initial: 5, // Bulma
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob];

            final leadingColorsKnob = context.knobs.options(
              label: "leadingColor",
              description: "MoonColors variants for leading.",
              initial: 5, // Bulma
              options: colorOptions,
            );

            final leadingColor = colorTable(context)[leadingColorsKnob];

            final trailingColorsKnob = context.knobs.options(
              label: "trailingColor",
              description: "MoonColors variants for trailing.",
              initial: 5, // Bulma
              options: colorOptions,
            );

            final trailingColor = colorTable(context)[trailingColorsKnob];

            final borderColorsKnob = context.knobs.options(
              label: "borderColor",
              description: "MoonColors variants for border.",
              initial: 5, // Bulma
              options: colorOptions,
            );

            final borderColor = colorTable(context)[borderColorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 12,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for Alert.",
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

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return Directionality(
              textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
              child: Center(
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
                                borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                                leading: showLeadingKnob ? const Icon(MoonIcons.frame_24) : null,
                                trailing: showTrailingKnob
                                    ? MoonButton.icon(
                                        buttonSize: MoonButtonSize.xs,
                                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
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
              ),
            );
          },
        );
}
