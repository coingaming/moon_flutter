import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

// Test
void main() {
  const key = Key("popover_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        content: content,
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });
  testWidgets("Popover is shown after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.text(openButtonText);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Popover is hidden after clicking outside content",
      (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.text(openButtonText);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsNothing);
  });

  testWidgets("Popover is hidden after clicking on button", (tester) async {
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

const String contentText = "Content";
const Widget content = Text(contentText);
const String openButtonText = "Open";
const String closeButtonText = "Close";

class TestWidget extends StatefulWidget {
  final Widget content;
  final bool isDismissible;
  final Key? widgetKey;

  const TestWidget({
    required this.content,
    this.isDismissible = true,
    this.widgetKey,
    super.key,
  });

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MoonPopover(
            key: widget.widgetKey,
            show: show,
            onTapOutside: widget.isDismissible
                ? () => setState(() => show = false)
                : null,
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 190),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.content,
                  const SizedBox(height: 16),
                  MoonFilledButton(
                    buttonSize: MoonButtonSize.sm,
                    isFullWidth: true,
                    onTap: () => setState(() => show = false),
                    label: const Text(closeButtonText),
                  ),
                ],
              ),
            ),
            child: MoonFilledButton(
              onTap: () => setState(() => show = !show),
              label: const Text(openButtonText),
            ),
          ),
        ),
      ),
    );
  }
}
