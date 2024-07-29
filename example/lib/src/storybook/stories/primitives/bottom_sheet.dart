import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class BottomSheetStory extends StatelessWidget {
  static const path = '/primitives/bottom_sheet';

  const BottomSheetStory({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonBottomSheet background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final barrierColorKnob = context.knobs.nullable.options(
      label: "barrierColor",
      description: "MoonColors variants for MoonBottomSheet barrier.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final barrierColor = colorTable(context)[barrierColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonBottomSheet.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final heightKnob = context.knobs.nullable.slider(
      label: "height",
      description: "Height of MoonBottomSheet.",
      enabled: false,
      initial: 0.64,
      min: 0.1,
    );

    final closeProgressThresholdKnob = context.knobs.nullable.slider(
      label: "closeProgressThreshold",
      description: "Close progress threshold for MoonBottomSheet.",
      enabled: false,
      initial: 0.6,
    );

    Future<dynamic> bottomSheetBuilder(BuildContext context) {
      return showMoonModalBottomSheet(
        context: context,
        backgroundColor: backgroundColor,
        barrierColor: barrierColor,
        enableDrag: true,
        height: heightKnob != null
            ? MediaQuery.of(context).size.height * heightKnob
            : MediaQuery.of(context).size.height * 0.7,
        closeProgressThreshold: closeProgressThresholdKnob,
        borderRadius: borderRadiusKnob != null
            ? BorderRadius.circular(borderRadiusKnob.toDouble())
            : null,
        builder: (BuildContext context) => Column(
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: ShapeDecoration(
                color: context.moonColors!.beerus,
                shape: const StadiumBorder(),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Center(
                    child: Text(
                      'Pick your choice!',
                      style: MoonTypography.typography.body.text16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MoonButton.icon(
                      icon: const Icon(MoonIcons.controls_close_small_16_light),
                      buttonSize: MoonButtonSize.sm,
                      backgroundColor: context.moonColors!.beerus,
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 0,
              thickness: 1,
              color: context.moonColors!.beerus,
            ),
            Expanded(
              child: ListView.builder(
                primary: true,
                itemCount: 100,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext _, int index) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item nr:"),
                      Text("$index"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Builder(
        builder: (BuildContext context) {
          return MoonFilledButton(
            label: const Text("Tap me"),
            onTap: () => bottomSheetBuilder(context),
          );
        },
      ),
    );
  }
}
