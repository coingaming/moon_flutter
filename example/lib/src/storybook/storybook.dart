import 'package:example/src/storybook/common/widgets/version.dart';
import 'package:example/src/storybook/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StorybookPage extends StatelessWidget {
  const StorybookPage({super.key});

  static const double autoLayoutThreshold = 1000;

  static final _plugins = initializePlugins(
    enableCompactLayoutDeviceFrame: false,
    initialDeviceFrameData: (
      isFrameVisible: true,
      device: Devices.ios.iPhone13,
      orientation: Orientation.portrait,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: "Accordion",
      plugins: _plugins,
      enableLayout: false,
      autoLayoutThreshold: autoLayoutThreshold,
      routeWrapperBuilder: RouteWrapperBuilder(
        title: "Moon Design for Flutter",
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MoonTheme(
              tokens: MoonTokens.light.copyWith(
                typography: MoonTypography.typography.copyWith(
                  heading: MoonTypography.typography.heading.apply(fontFamily: "DMSans"),
                  body: MoonTypography.typography.body.apply(fontFamily: "DMSans"),
                  caption: MoonTypography.typography.caption.apply(fontFamily: "DMSans"),
                ),
              ),
            ),
          ],
        ),
        darkTheme: ThemeData.dark().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MoonTheme(
              tokens: MoonTokens.dark.copyWith(
                typography: MoonTypography.typography.copyWith(
                  heading: MoonTypography.typography.heading.apply(fontFamily: "DMSans"),
                  body: MoonTypography.typography.body.apply(fontFamily: "DMSans"),
                  caption: MoonTypography.typography.caption.apply(fontFamily: "DMSans"),
                ),
              ),
            ),
          ],
        ),
        wrapperBuilder: (BuildContext context, Widget? child) => Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            top: false,
            bottom: false,
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
      brandingWidget: const MoonVersionWidget(),
      stories: routeAwareStories,
    );
  }
}
