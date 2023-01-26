import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Moon Design for Flutter',
      color: Colors.white,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final plugins = initializePlugins(
    contentsSidePanel: true,
    knobsSidePanel: true,
    initialDeviceFrameData: DeviceFrameData(
      device: Devices.ios.iPhone13,
    ),
  );

  bool _isInStorybookMode = false;

  void toggleStorybookMode() {
    setState(() {
      _isInStorybookMode = !_isInStorybookMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isInStorybookMode
        ? Storybook(
            initialStory: "Default",
            plugins: plugins,
            wrapperBuilder: (context, child) => MaterialApp(
              theme: ThemeData.light().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.light]),
              darkTheme: ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.dark]),
              useInheritedMediaQuery: true,
              home: Scaffold(body: child),
            ),
            stories: [
              Story(
                name: "Test Story",
                description: "Test description",
                builder: (context) {
                  final theme = Theme.of(context).extension<MoonTheme>()!;
                  return Container(
                    color: theme.colors.piccolo,
                    alignment: Alignment.center,
                    child: Text("Test text", style: theme.typography.heading.text32),
                  );
                },
              ),
            ],
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Moon Design for Flutter",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 800 ? 72 : 32,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width > 800 ? 36 : 16),
                  GestureDetector(
                    onLongPress: toggleStorybookMode,
                    child: Text(
                      "Coming soon...",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 800 ? 24 : 20,
                        color: const Color(0xFF999CA0),
                      ),
                    ),
                  ),
                  const MoonFilledButton(
                    child: Text(
                      "TEST",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
