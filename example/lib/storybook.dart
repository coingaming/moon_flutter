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
      //initialStory: "FilledButton",
      plugins: _plugins,
      wrapperBuilder: (context, child) => MaterialApp(
        theme: ThemeData.light().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.light]),
        darkTheme: ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.dark]),
        useInheritedMediaQuery: true,
        home: Scaffold(
          body: child,
        ),
      ),
      stories: [
        Story(
          name: "Button",
          builder: (context) {
            return Center(
              child: MoonButton(
                buttonSize: context.knobs.options(
                  label: "Sizes",
                  initial: ButtonSize.md,
                  options: const [
                    Option(label: "XS", value: ButtonSize.xs),
                    Option(label: "SM", value: ButtonSize.sm),
                    Option(label: "MD", value: ButtonSize.md),
                    Option(label: "LG", value: ButtonSize.lg),
                    Option(label: "XL", value: ButtonSize.xl)
                  ],
                ),
                onTap: () {},
                backgroundColor: context.moonTheme!.colors.bulma,
                //showPulseAnimation: true,
                //showBorder: true,
                leftIcon: const MoonPlaceholderIcon(),
                //rightIcon: const MoonPlaceholderIcon(),
                label: const Text("Testy"),
              ),
            );
          },
        ),
        Story(
          name: "Button.outlined",
          builder: (context) {
            return Center(
              child: MoonButton.outlined(
                buttonSize: context.knobs.options(
                  label: "Sizes",
                  initial: ButtonSize.md,
                  options: const [
                    Option(label: "XS", value: ButtonSize.xs),
                    Option(label: "SM", value: ButtonSize.sm),
                    Option(label: "MD", value: ButtonSize.md),
                    Option(label: "LG", value: ButtonSize.lg),
                    Option(label: "XL", value: ButtonSize.xl)
                  ],
                ),
                onTap: () {},
                showPulseAnimation: true,
                //showBorder: true,
                leftIcon: const MoonPlaceholderIcon(),
                //rightIcon: const MoonPlaceholderIcon(),
                label: const Text("Testy"),
              ),
            );
          },
        ),
        Story(
          name: "Button.text",
          builder: (context) {
            return Center(
              child: MoonButton.text(
                buttonSize: context.knobs.options(
                  label: "Sizes",
                  initial: ButtonSize.md,
                  options: const [
                    Option(label: "XS", value: ButtonSize.xs),
                    Option(label: "SM", value: ButtonSize.sm),
                    Option(label: "MD", value: ButtonSize.md),
                    Option(label: "LG", value: ButtonSize.lg),
                    Option(label: "XL", value: ButtonSize.xl)
                  ],
                ),
                onTap: () {},
                //showPulseAnimation: true,
                //showBorder: true,
                leftIcon: const MoonPlaceholderIcon(),
                //rightIcon: const MoonPlaceholderIcon(),
                label: const Text("Testy"),
              ),
            );
          },
        ),
      ],
    );
  }
}
