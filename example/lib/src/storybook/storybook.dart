import 'package:example/src/storybook/common/widgets/version.dart';
import 'package:example/src/storybook/stories/avatar.dart';
import 'package:example/src/storybook/stories/button.dart';
import 'package:example/src/storybook/stories/chip.dart';
import 'package:example/src/storybook/stories/circular_loader.dart';
import 'package:example/src/storybook/stories/circular_progress.dart';
import 'package:example/src/storybook/stories/icons.dart';
import 'package:example/src/storybook/stories/linear_loader.dart';
import 'package:example/src/storybook/stories/linear_progress.dart';
import 'package:example/src/storybook/stories/popover.dart';
import 'package:example/src/storybook/stories/switch.dart';
import 'package:example/src/storybook/stories/tag.dart';
import 'package:example/src/storybook/stories/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StorybookPage extends StatelessWidget {
  const StorybookPage({super.key});

  static final _storyPanelFocusNode = FocusNode();

  static final _plugins = initializePlugins(
    contentsSidePanel: true,
    knobsSidePanel: true,
    initialDeviceFrameData: DeviceFrameData(
      device: Devices.ios.iPhone13,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Storybook(
          initialStory: "Avatar",
          plugins: _plugins,
          wrapperBuilder: (context, child) => MaterialApp(
            title: "Moon Design for Flutter",
            theme: ThemeData.light().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.light]),
            darkTheme: ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.dark]),
            useInheritedMediaQuery: true,
            home: Builder(
              builder: (context) {
                return Focus(
                  focusNode: _storyPanelFocusNode,
                  descendantsAreFocusable: true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _storyPanelFocusNode.requestFocus();
                    },
                    child: Scaffold(
                      extendBody: true,
                      extendBodyBehindAppBar: true,
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: child,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          stories: [
            AvatarStory(),
            ButtonStory(),
            ChipStory(),
            CircularLoaderStory(),
            CircularProgressStory(),
            IconsStory(),
            LinearLoaderStory(),
            LinearProgressStory(),
            PopoverStory(),
            SwitchStory(),
            TagStory(),
            TooltipStory(),
          ],
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: MoonVersionWidget(),
        ),
      ],
    );
  }
}
