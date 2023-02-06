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
            final buttonSizesKnob = context.knobs.options(
              label: "Sizes",
              initial: ButtonSize.md,
              options: const [
                Option(label: "XS", value: ButtonSize.xs),
                Option(label: "SM", value: ButtonSize.sm),
                Option(label: "MD", value: ButtonSize.md),
                Option(label: "LG", value: ButtonSize.lg),
                Option(label: "XL", value: ButtonSize.xl)
              ],
            );

            final customTextInputKnob = context.knobs.text(
              label: "Custom text input",
              initial: "Button",
            );

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

            final setFullWidthKnob = context.knobs.boolean(
              label: "Set full width",
            );

            final showPulseEffectKnob = context.knobs.boolean(
              label: "Show pulse animation",
            );

            final showPulseEffectJiggleKnob = context.knobs.boolean(
              label: "Show jiggling with pulse animation",
            );

            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  MoonButton(
                    onTap: () {},
                    borderRadius: BorderRadius.zero,
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    backgroundColor: context.moonTheme!.colors.bulma,
                    showPulseEffect: showPulseEffectKnob,
                    showPulseEffectJiggle: showPulseEffectJiggleKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? Text(customTextInputKnob) : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonPrimaryButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? Text(customTextInputKnob) : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonSecondaryButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? Text(customTextInputKnob) : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonTertiaryButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
                    leftIcon: showLeftIconKnob ? const MoonPlaceholderIcon() : null,
                    label: showLabelKnob ? Text(customTextInputKnob) : null,
                    rightIcon: showRightIconKnob ? const MoonPlaceholderIcon() : null,
                  ),
                  const SizedBox(height: 32),
                  MoonGhostButton(
                    onTap: () {},
                    buttonSize: buttonSizesKnob,
                    isFullWidth: setFullWidthKnob,
                    showPulseEffect: showPulseEffectKnob,
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
