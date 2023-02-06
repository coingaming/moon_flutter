import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StorybookPage extends StatelessWidget {
  const StorybookPage({super.key});

  static final _plugins = initializePlugins(
    contentsSidePanel: true,
    knobsSidePanel: true,
    initialDeviceFrameData: DeviceFrameData(
      device: Devices.ios.iPhone13,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: "Buttons",
      plugins: _plugins,
      wrapperBuilder: (context, child) => MaterialApp(
        theme: ThemeData.light().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.light]),
        darkTheme: ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.dark]),
        useInheritedMediaQuery: true,
        home: Builder(
          builder: (context) {
            return Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: child,
              ),
            );
          },
        ),
      ),
      stories: [
        Story(
          name: "Buttons",
          builder: (context) {
            final showLeftIconKnob = context.knobs.boolean(
              label: "Show left icon",
              initial: true,
            );

            final showLabelKnob = context.knobs.boolean(
              label: "Show label",
              initial: true,
            );

            final showRightIconKnob = context.knobs.boolean(
              label: "Show right icon",
            );

            final buttonSizesKnob = context.knobs.options(
              label: "buttonSize",
              description: "Button size variants.",
              initial: ButtonSize.md,
              options: const [
                Option(label: "xs", value: ButtonSize.xs),
                Option(label: "sm", value: ButtonSize.sm),
                Option(label: "md", value: ButtonSize.md),
                Option(label: "lg", value: ButtonSize.lg),
                Option(label: "xl", value: ButtonSize.xl)
              ],
            );

            final setFullWidthKnob = context.knobs.boolean(
              label: "isFullWidth",
              description: "Set button to full width.",
            );

            final showPulseEffectKnob = context.knobs.boolean(
              label: "showPulseEffect",
              description: "Show pulse animation.",
            );

            final showPulseEffectJiggleKnob = context.knobs.boolean(
              label: "showPulseEffectJiggle",
              description: "Show jiggling with pulse animation.",
            );

            final customTextInputKnob = context.knobs.text(
              label: "Custom label text",
              initial: "MoonButton",
            );

            final showBorderRadiusKnob = context.knobs.sliderInt(
              max: 28,
              initial: 8,
              label: "borderRadius",
              description: "Button border radius.",
            );

            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  MoonPrimaryButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? const Text("MoonPrimaryButton") : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonSecondaryButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? const Text("MoonSecondaryButton") : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonTertiaryButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? const Text("MoonTertiaryButton") : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonGhostButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? const Text("MoonGhostButton") : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonButton(
                    onTap: () {},
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    borderRadius: BorderRadius.circular(16),
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    backgroundColor: context.moonTheme!.colors.krillin100,
                    showPulseEffect: showPulseEffectKnob,
                    showPulseEffectJiggle: showPulseEffectJiggleKnob,
                    leftIcon: showLeftIconKnob
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : null,
                    label: showLabelKnob
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircleAvatar(
                              backgroundColor: context.moonTheme!.colors.trunks,
                              child: const Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonButton(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(showBorderRadiusKnob.toDouble()),
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    backgroundColor: context.moonTheme!.colors.bulma,
                    showPulseEffect: showPulseEffectKnob,
                    showPulseEffectJiggle: showPulseEffectJiggleKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? Text(customTextInputKnob) : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
