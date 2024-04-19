import 'package:example/src/storybook/storybook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:moon_design/moon_design.dart';

void main() async {
  usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInStorybookMode = true;

  void toggleStorybookMode() {
    setState(() => _isInStorybookMode = !_isInStorybookMode);
  }

  @override
  Widget build(BuildContext context) {
    return _isInStorybookMode
        ? const StorybookPage()
        : MaterialApp(
            theme:
                ThemeData.light().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: MoonTokens.light)]),
            darkTheme:
                ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[MoonTheme(tokens: MoonTokens.dark)]),
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
