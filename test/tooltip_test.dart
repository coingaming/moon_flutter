import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/src/widgets/buttons/filled_button.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

void main() {
  const key = Key("tooltip_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(MoonTooltip(key: key, show: true, content: Container(), child: Container()));
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Tooltip is shown after clicking on button", (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets("Tooltip is hidden after clicking on it", (tester) async {
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    final button = find.byType(MoonFilledButton);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();
    final tip = _findTooltipContent(tooltipText);
    await tester.tap(tip);
    await tester.pumpAndSettle();

    expect(tip, findsNothing);
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
      find.byWidgetPredicate((widget) => widget is MoonTooltip && widget.backgroundColor == Colors.red),
      findsOneWidget,
    );
  });
}

const String tooltipText = "Tooltip content";
const Widget content = Text(tooltipText);

Finder _findTooltipContent(String tooltipText) {
  return find.ancestor(
    of: find.text(tooltipText),
    matching: find.byType(Container),
  );
}

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
              return MoonTooltip(
                show: show,
                backgroundColor: color,
                content: content,
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
