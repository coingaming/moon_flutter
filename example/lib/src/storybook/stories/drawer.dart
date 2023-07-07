import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class DrawerStory extends Story {
  DrawerStory()
      : super(
          name: "Drawer",
          builder: (context) {
            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonDrawer background.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final barrierColorsKnob = context.knobs.nullable.options(
              label: "barrierColor",
              description: "MoonColors variants for MoonDrawer barrier.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final barrierColor = colorTable(context)[barrierColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonDrawer.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            final drawerWidthKnob = context.knobs.nullable.sliderInt(
              label: "width",
              description: "The width of the MoonDrawer",
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
                  barrierColor: barrierColorsKnob != null
                      ? barrierColor
                      : context.moonTheme?.drawerTheme.colors.barrierColor ?? MoonColors.light.zeno,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(borderRadiusKnob?.toDouble() ?? 0),
                    bottomEnd: Radius.circular(borderRadiusKnob?.toDouble() ?? 0),
                  ),
                  width: drawerWidthKnob?.toDouble() ?? MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      const Text("MoonDrawer"),
                      const SizedBox(height: 32),
                      Builder(
                        builder: (context) {
                          return MoonFilledButton(
                            label: const Text("Close"),
                            onTap: () => Navigator.of(context).pop(),
                          );
                        },
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      Builder(
                        builder: (context) {
                          return MoonFilledButton(
                            label: const Text("Tap me"),
                            onTap: () => Scaffold.of(context).openDrawer(),
                          );
                        },
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
