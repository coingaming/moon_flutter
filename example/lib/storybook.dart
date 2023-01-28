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
      initialStory: "FilledButton",
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
          name: "FilledButton",
          description: "FilledButton",
          builder: (context) {
            return Center(
              child: MoonFilledButton(
                buttonSize: context.knobs.options(
                  label: "Sizes",
                  initial: MoonButtonSize.md,
                  options: const [
                    Option(label: "XS", value: MoonButtonSize.xs),
                    Option(label: "SM", value: MoonButtonSize.sm),
                    Option(label: "MD", value: MoonButtonSize.md),
                    Option(label: "LG", value: MoonButtonSize.lg),
                    Option(label: "XL", value: MoonButtonSize.xl)
                  ],
                ),
                onTap: () {},
                backgroundColor: context.moonTheme!.colors.bulma,
                leftIcon: const MoonPlaceholderIcon(),
                rightIcon: const MoonPlaceholderIcon(),
                label: const Text("Testy", style: TextStyle(fontSize: 16)),
              ),
            );
          },
        ),
      ],
    );
  }
}
