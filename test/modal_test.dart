import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

// Test
void main() {
  const key = Key("modal_test");

  testWidgets("Modal is shown after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.text(openButtonText);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Modal is hidden after clicking outside content", (tester) async {
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

  testWidgets(
      "Modal is not hidden after clicking outside content if not dismissable",
      (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        key: key,
        content: content,
        isDismissible: false,
      ),
    );
    final button = find.text(openButtonText);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Modal close after clicking on button", (tester) async {
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

class TestWidget extends StatelessWidget {
  final Widget content;
  final bool isDismissible;

  const TestWidget({
    required this.content,
    this.isDismissible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return MoonFilledButton(
                label: const Text(openButtonText),
                onTap: () => modalBuilder(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> modalBuilder(BuildContext context) {
    return showMoonModal<void>(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: false,
      builder: (BuildContext _) {
        return Directionality(
          textDirection: Directionality.of(context),
          child: MoonModal(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  content,
                  MoonFilledButton(
                    label: const Text(closeButtonText),
                    isFullWidth: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
