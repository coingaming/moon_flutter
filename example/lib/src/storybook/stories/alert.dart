import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AlertStory extends StatefulWidget {
  static const path = '/primitives/alert';

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

    final labelColorKnob = context.knobs.nullable.options(
      label: "Label color",
      description: "MoonColors variants for MoonAlert label slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final labelColor = colorTable(context)[labelColorKnob ?? 40];

    final trailingColorKnob = context.knobs.nullable.options(
      label: "Trailing color",
      description: "MoonColors variants for MoonAlert trailing slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final trailingColor = colorTable(context)[trailingColorKnob ?? 40];

    final contentColorKnob = context.knobs.nullable.options(
      label: "Content color",
      description: "MoonColors variants for MoonAlert content slot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final contentColor = colorTable(context)[contentColorKnob ?? 40];

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

    final showContentKnob = context.knobs.boolean(
      label: "content",
      description: "Show widget in MoonAlert content slot.",
    );

    final showTrailingKnob = context.knobs.boolean(
      label: "trailing",
      description: "Show widget in MoonAlert trailing slot.",
      initial: true,
    );

    final showDisabledKnob = context.knobs.boolean(
      label: "Disabled",
      description: "MoonAlert onTrailingTap() is null.",
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
                  label: SizedBox(
                    height: 24,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Base MoonAlert",
                        style: TextStyle(color: labelColor),
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
                  content: showContentKnob
                      ? SizedBox(
                          height: 24,
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              "Here goes MoonAlert content",
                              style: TextStyle(color: contentColor),
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
            MoonAlert.filled(
              show: true,
              color: context.moonColors!.chichi,
              backgroundColor: context.moonColors!.chichi10,
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.notifications_alert_24_light) : null,
              label: const Text("Filled error MoonAlert"),
              trailing: MoonButton.icon(
                buttonSize: MoonButtonSize.xs,
                borderRadius: borderRadius,
                gap: 0,
                onTap: () {},
                icon: Icon(
                  MoonIcons.controls_close_small_24_light,
                  size: 24,
                  color: context.moonColors!.chichi,
                ),
              ),
              content: showContentKnob
                  ? const SizedBox(
                      height: 24,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Here goes MoonAlert content"),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            MoonAlert.filled(
              show: true,
              color: context.moonColors!.krillin,
              backgroundColor: context.moonColors!.krillin10,
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.generic_alarm_round_24_light) : null,
              label: const Text("Filled warning MoonAlert"),
              trailing: MoonButton.icon(
                buttonSize: MoonButtonSize.xs,
                borderRadius: borderRadius,
                gap: 0,
                onTap: () {},
                icon: Icon(
                  MoonIcons.controls_close_small_24_light,
                  size: 24,
                  color: context.moonColors!.krillin,
                ),
              ),
              content: showContentKnob
                  ? const SizedBox(
                      height: 24,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Here goes MoonAlert content"),
                      ),
                    )
                  : null,
            ),
            const TextDivider(text: "Outlined MoonAlert variant"),
            MoonAlert.outlined(
              show: true,
              color: context.moonColors!.roshi,
              borderColor: context.moonColors!.roshi,
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.generic_check_rounded_24_light) : null,
              label: const Text("Outlined success MoonAlert"),
              trailing: MoonButton.icon(
                buttonSize: MoonButtonSize.xs,
                borderRadius: borderRadius,
                gap: 0,
                onTap: () {},
                icon: Icon(
                  MoonIcons.controls_close_small_24_light,
                  size: 24,
                  color: context.moonColors!.roshi,
                ),
              ),
              content: showContentKnob
                  ? const SizedBox(
                      height: 24,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Here goes MoonAlert content"),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            MoonAlert.outlined(
              show: true,
              color: context.moonColors!.whis,
              borderColor: context.moonColors!.whis,
              borderRadius: borderRadius,
              leading: showLeadingKnob ? const Icon(MoonIcons.notifications_alert_24_light) : null,
              label: const Text('Outlined info MoonAlert'),
              trailing: MoonButton.icon(
                buttonSize: MoonButtonSize.xs,
                borderRadius: borderRadius,
                gap: 0,
                onTap: () {},
                icon: Icon(
                  MoonIcons.controls_close_small_24_light,
                  size: 24,
                  color: context.moonColors!.whis,
                ),
              ),
              content: showContentKnob
                  ? const SizedBox(
                      height: 24,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Here goes MoonAlert content"),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
