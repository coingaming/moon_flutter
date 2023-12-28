import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

// Test
void main() {
  const key = Key("bottom_sheet_test");

  testWidgets("Botton sheet is shown after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Botton sheet is hidden after clicking outside content",
      (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsNothing);
  });

  testWidgets(
      "Botton sheet is not hidden after clicking outside content if not dismissable",
      (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        key: key,
        content: content,
        isDismissible: false,
      ),
    );
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });
  testWidgets("Botton sheet is expanded", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        key: key,
        content: content,
        isExpanded: true,
      ),
    );
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);

    await tester.tapAt(const Offset(1, 1));
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);

    await tester.tapAt(const Offset(100, 1));
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });
}

const String bottomSheetText = "Botton sheet content";
const Widget content = Text(bottomSheetText);

class TestWidget extends StatelessWidget {
  final Widget content;
  final bool isDismissible;
  final bool isExpanded;

  const TestWidget({
    required this.content,
    this.isDismissible = true,
    this.isExpanded = false,
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
                label: const Text("Tap me"),
                onTap: () => bottomSheetBuilder(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetBuilder(BuildContext context) {
    return showMoonModalBottomSheet(
      isExpanded: isExpanded,
      context: context,
      backgroundColor: Colors.black38,
      enableDrag: true,
      isDismissible: isDismissible,
      height: MediaQuery.of(context).size.height * 0.5,
      builder: (BuildContext context) => content,
    );
  }
}
