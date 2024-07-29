import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class DrawerStory extends StatelessWidget {
  static const path = '/primitives/drawer';

  const DrawerStory({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonDrawer background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final barrierColorKnob = context.knobs.nullable.options(
      label: "barrierColor",
      description: "MoonColors variants for MoonDrawer barrier.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final barrierColor = colorTable(context)[barrierColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonDrawer.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final drawerWidthKnob = context.knobs.nullable.sliderInt(
      label: "width",
      description: "Width for MoonDrawer.",
      enabled: false,
      initial: 200,
      max: MediaQuery.of(context).size.width.round(),
    );

    return OverflowBox(
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width,
      child: Scaffold(
        drawerScrimColor: barrierColor,
        drawer: MoonDrawer(
          backgroundColor: backgroundColor,
          borderRadius: BorderRadiusDirectional.horizontal(
            end: Radius.circular(borderRadiusKnob?.toDouble() ?? 0),
          ),
          width: drawerWidthKnob?.toDouble() ??
              MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("MoonDrawer"),
              const SizedBox(height: 32),
              Builder(
                builder: (BuildContext context) {
                  return MoonFilledButton(
                    label: const Text("Close"),
                    onTap: () => Navigator.of(context).pop(),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 64.0,
                  horizontal: 16.0,
                ),
                child: MoonFilledButton(
                  label: const Text("Tap me"),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
