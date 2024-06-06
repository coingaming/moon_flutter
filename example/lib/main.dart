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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get _isInStorybookMode => true;

  @override
  Widget build(BuildContext context) {
    return _isInStorybookMode
        ? const StorybookPage()
        : MaterialApp(
            theme: ThemeData.light().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MoonTheme(tokens: MoonTokens.light),
              ],
            ),
            darkTheme: ThemeData.dark().copyWith(
              extensions: <ThemeExtension<dynamic>>[
                MoonTheme(tokens: MoonTokens.dark),
              ],
            ),
            home: Scaffold(
              body: Center(
                child: Text(
                  "Moon Design for Flutter",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 800 ? 72 : 32,
                  ),
                ),
              ),
            ),
          );
  }
}
