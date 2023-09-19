import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_design/src/widgets/buttons/filled_button.dart';
import 'package:moon_design/src/widgets/dropdown/dropdown.dart';

void main() {
  const key = Key("dropdown_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(MoonDropdown(key: key, show: true, content: Container(), child: Container()));
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Dropdown is shown after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Dropdown is hidden after clicking outside content", (tester) async {
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

  testWidgets("Provided color is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        key: key,
        content: content,
        color: Colors.red,
      ),
    );
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
    expect(
      find.byWidgetPredicate((widget) => widget is MoonDropdown && widget.backgroundColor == Colors.red),
      findsOneWidget,
    );
  });
}

const String dropdownText = "Dropdown content";
const Widget content = Text(dropdownText);

bool show = false;

class TestWidget extends StatelessWidget {
  final Widget content;
  final Color color;

  const TestWidget({
    required this.content,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return MoonDropdown(
                show: show,
                backgroundColor: color,
                content: content,
                onTapOutside: () => setState(() => show = false),
                child: MoonFilledButton(
                  onTap: () {
                    setState(() => show = true);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
