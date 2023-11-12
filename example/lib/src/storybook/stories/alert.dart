import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AlertStory extends StatefulWidget {
  static const path = '/alert';

  const AlertStory({super.key});

  @override
  State<AlertStory> createState() => _AlertStoryState();
}

class _AlertStoryState extends State<AlertStory> {
  bool _showAlert = true;

  @override
  Widget build(BuildContext context) {
    final leadingColorKnob = context.knobs.nullable.options(
      label: "Leading Color",
      description: "MoonColors variants for MoonAlert leading slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final leadingColor = colorTable(context)[leadingColorKnob ?? 40];

    final titleColorKnob = context.knobs.nullable.options(
      label: "Title color",
      description: "MoonColors variants for MoonAlert title slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final titleColor = colorTable(context)[titleColorKnob ?? 40];

    final trailingColorKnob = context.knobs.nullable.options(
      label: "Trailing color",
      description: "MoonColors variants for MoonAlert trailing slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final trailingColor = colorTable(context)[trailingColorKnob ?? 40];

    final bodyColorKnob = context.knobs.nullable.options(
      label: "Body color",
      description: "MoonColors variants for MoonAlert body slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final bodyColor = colorTable(context)[bodyColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonAlert background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderColorKnob = context.knobs.nullable.options(
      label: "borderColor",
      description: "MoonColors variants for MoonAlert border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final borderColor = colorTable(context)[borderColorKnob ?? 40];

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

    final BorderRadiusGeometry? borderRadius =
        borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
        child: Column(
          children: [
            const TextDivider(
              text: "Base MoonAlert",
              paddingTop: 0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoonAlert(
                  show: _showAlert,
                  showBorder: showBorderKnob,
                  borderColor: borderColor,
                  backgroundColor: backgroundColor,
                  borderRadius: borderRadius,
                  leading: showLeadingKnob
                      ? Icon(
                          MoonIcons.other_frame_24_light,
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
                          borderRadius: borderRadius,
                          disabledOpacityValue: 1,
                          icon: Icon(
                            MoonIcons.controls_close_small_24_light,
                            color: trailingColor,
                            size: 24,
                          ),
                          gap: 0,
                          onTap: showDisabledKnob ? null : () => setState(() => _showAlert = !_showAlert),
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
                  onTap: () => setState(() => _showAlert = !_showAlert),
                ),
              ],
            ),
            const TextDivider(text: "Filled MoonAlert variant"),
            MoonFilledAlert(
              show: true,
              color: context.moonColors!.chiChi100,
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.notifications_alert_24_light) : null,
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
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.generic_alarm_round_24_light) : null,
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
            const TextDivider(text: "Outlined MoonAlert variant"),
            MoonOutlinedAlert(
              show: true,
              color: context.moonColors!.roshi100,
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.generic_check_rounded_24_light) : null,
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
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.notifications_alert_24_light) : null,
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
          ],
        ),
      ),
    );
  }
}
