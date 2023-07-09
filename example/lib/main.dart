import 'package:example/src/storybook/storybook.dart';
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

  bool _isInStorybookMode = true;

  void toggleStorybookMode() {
    setState(() {
      _isInStorybookMode = !_isInStorybookMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isInStorybookMode
        ? const StorybookPage()
        : MaterialApp(
            theme: ThemeData.light().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.light]),
            darkTheme: ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme.dark]),
            home: Scaffold(
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
                  ],
                ),
              ),
            ),
          );
  }
}
