import 'package:example/src/storybook/common/constants.dart';
import 'package:example/src/storybook/common/widgets/logo.dart';
import 'package:example/src/storybook/common/widgets/version.dart';
import 'package:example/src/storybook/routing/route_aware_stories.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StorybookPage extends StatelessWidget {
  const StorybookPage({super.key});

  static final _plugins = initializePlugins(
    enableCodeView: true,
    enableCompactLayoutDeviceFrame: false,
    initialDeviceFrameData: (
      isFrameVisible: true,
      device: Devices.ios.iPhone12ProMax,
      orientation: Orientation.portrait,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: "Home",
      plugins: _plugins,
      enableLayout: false,
      autoLayoutThreshold: storybookAutoLayoutThreshold,
      canvasColor: Colors.white,
      logoWidget: const MoonLogoWidget(),
      routeWrapperBuilder: RouteWrapperBuilder(
        title: "Moon Design for Flutter",
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color(0xFFF6F7F9), // Gohan light.
          extensions: <ThemeExtension<dynamic>>[
            MoonTheme(
              tokens: MoonTokens.light.copyWith(
                colors: mdsLightColors,
                typography: MoonTypography.typography.copyWith(
                  heading: MoonTypography.typography.heading
                      .apply(fontFamily: "DMSans"),
                  body: MoonTypography.typography.body
                      .apply(fontFamily: "DMSans"),
                  caption: MoonTypography.typography.caption
                      .apply(fontFamily: "DMSans"),
                ),
              ),
            ),
          ],
        ),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1F1F1F), // Gohan dark.
          extensions: <ThemeExtension<dynamic>>[
            MoonTheme(
              tokens: MoonTokens.dark.copyWith(
                colors: mdsDarkColors,
                typography: MoonTypography.typography.copyWith(
                  heading: MoonTypography.typography.heading
                      .apply(fontFamily: "DMSans"),
                  body: MoonTypography.typography.body
                      .apply(fontFamily: "DMSans"),
                  caption: MoonTypography.typography.caption
                      .apply(fontFamily: "DMSans"),
                ),
              ),
            ),
          ],
        ),
        wrapperBuilder: (BuildContext context, Widget? child) => Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
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
