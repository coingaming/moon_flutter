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
      initialStory: "Default",
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
            return /* ElevatedButton(
                  onPressed: () {},
                  child: Text(
                      "y"))  */
                Center(
              child: MoonFilledButton(
                child:
                    MoonPlaceholderIcon(), /* Text(
                              "TEST",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
              ) */
              ),
            );
          },
        ),
      ],
    );
  }
}
