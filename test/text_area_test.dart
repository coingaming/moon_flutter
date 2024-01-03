import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("text_area_test");

  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.byType(MoonFilledButton));
    await tester.pumpAndSettle();
  }

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonTextArea && widget.key == key,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Enter valid text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    final textArea = find.byKey(key);

    await tester.enterText(textArea, validText);
    await tester.pumpAndSettle();
    expect(
      find.text(validText),
      findsOneWidget,
    );
    await submit(tester);
    expect(
      find.text(error),
      findsNothing,
    );
  });

  testWidgets("Enter invalid text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    final textArea = find.byKey(key);

    await tester.enterText(textArea, invalidText);
    await tester.pumpAndSettle();
    expect(
      find.text(invalidText),
      findsOneWidget,
    );
    await submit(tester);
    expect(
      find.text(error),
      findsOneWidget,
    );
  });

  testWidgets("Check helper text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showHelper: true,
      ),
    );

    expect(
      find.text(helper),
      findsOneWidget,
    );
  });

  testWidgets("Check hint", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showHelper: true,
      ),
    );

    expect(
      find.text(hint),
      findsOneWidget,
    );
  });

  testWidgets("Disabled: enter text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        enabled: false,
      ),
    );

    final textArea = find.byKey(key);

    await tester.enterText(textArea, validText);
    await tester.pumpAndSettle();
    expect(
      find.text(validText),
      findsNothing,
    );
  });
}

const validText =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry';
const invalidText = 'Lorem';

const hint = 'Hint';
const error = 'Error';
const helper = 'Helper';

class TestWidget extends StatelessWidget {
  final bool enabled;
  final bool showHelper;
  final Key? widgetKey;

  const TestWidget({
    super.key,
    this.enabled = true,
    this.showHelper = false,
    this.widgetKey,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MoonTextArea(
                    key: widgetKey,
                    enabled: enabled,
                    hintText: hint,
                    validator: (String? value) =>
                        value?.length != null && value!.length < 10
                            ? error
                            : null,
                    helper: showHelper ? const Text(helper) : null,
                  ),
                  const SizedBox(height: 32),
                  MoonFilledButton(
                    label: const Text("Submit"),
                    onTap: () => Form.of(context).validate(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
