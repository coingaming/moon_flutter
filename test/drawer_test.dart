import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  testWidgets("Drawer is shown after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(content: content));
    final button = find.text(openButtonText);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Drawer close after clicking outside", (tester) async {
    await tester.pumpWidget(const TestWidget(content: content));
    final button = find.text(openButtonText);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
    await tester.tapAt(const Offset(210, 10));
    await tester.pumpAndSettle();
    expect(find.byWidget(content), findsNothing);
  });

  testWidgets("Drawer close after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(content: content));
    final button = find.text(openButtonText);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
    await tester.tap(find.text(closeButtonText));
    await tester.pumpAndSettle();
    expect(find.byWidget(content), findsNothing);
  });
}

const String contentText = "Drawer content";
const String openButtonText = "Open";
const String closeButtonText = "Close";

const Widget content = Text(contentText);

class TestWidget extends StatelessWidget {
  final Widget content;

  const TestWidget({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OverflowBox(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
        child: Scaffold(
          drawer: MoonDrawer(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                content,
                const SizedBox(height: 32),
                Builder(
                  builder: (BuildContext context) {
                    return MoonFilledButton(
                      label: const Text(closeButtonText),
                      onTap: () => Navigator.of(context).pop(),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 64.0,
                    horizontal: 16.0,
                  ),
                  child: MoonFilledButton(
                    label: const Text(openButtonText),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
